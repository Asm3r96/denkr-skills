param()

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillsRoot = Join-Path $repoRoot "skills"
$packagesRoot = Join-Path $repoRoot "packages"
$indexPath = Join-Path $repoRoot "index.json"

function Assert-NoBom {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $bytes = [System.IO.File]::ReadAllBytes($Path)
    if (
        $bytes.Length -ge 3 -and
        $bytes[0] -eq 0xEF -and
        $bytes[1] -eq 0xBB -and
        $bytes[2] -eq 0xBF
    ) {
        throw "JSON file has a UTF-8 BOM and may fail app parsing: $Path"
    }
}

function Read-JsonFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    Assert-NoBom -Path $Path

    try {
        return Get-Content -Raw -Path $Path | ConvertFrom-Json
    } catch {
        throw "Invalid JSON in $Path. $($_.Exception.Message)"
    }
}

function Assert-FileExists {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (!(Test-Path $Path)) {
        throw "Missing required file: $Path"
    }
}

Assert-FileExists -Path $indexPath
$index = Read-JsonFile -Path $indexPath

if ($null -eq $index.skills) {
    throw "index.json is missing the skills array."
}

$skillDirs = Get-ChildItem -Path $skillsRoot -Directory | Sort-Object Name
$manifestNames = @()

foreach ($skillDir in $skillDirs) {
    $skillJsonPath = Join-Path $skillDir.FullName "skill.json"
    $skillMdPath = Join-Path $skillDir.FullName "SKILL.md"

    Assert-FileExists -Path $skillJsonPath
    Assert-FileExists -Path $skillMdPath

    $skill = Read-JsonFile -Path $skillJsonPath

    if ([string]::IsNullOrWhiteSpace([string]$skill.name)) {
        throw "Skill name is missing in $skillJsonPath"
    }

    if ([string]::IsNullOrWhiteSpace([string]$skill.version)) {
        throw "Skill version is missing in $skillJsonPath"
    }

    if ([string]$skill.name -ne $skillDir.Name) {
        throw "Skill folder name '$($skillDir.Name)' does not match skill.json name '$($skill.name)'."
    }

    $manifestNames += [string]$skill.name

    $manifestEntry = @($index.skills | Where-Object { $_.name -eq $skill.name })
    if ($manifestEntry.Count -ne 1) {
        throw "index.json must contain exactly one manifest entry for skill '$($skill.name)'."
    }

    $entry = $manifestEntry[0]
    if ([string]$entry.version -ne [string]$skill.version) {
        throw "Version mismatch for '$($skill.name)': index.json has '$($entry.version)', skill.json has '$($skill.version)'."
    }

    $zipName = "$($skill.name)-$($skill.version).zip"
    $zipPath = Join-Path $packagesRoot $zipName
    Assert-FileExists -Path $zipPath

    $expectedHash = (Get-FileHash -Path $zipPath -Algorithm SHA256).Hash.ToLowerInvariant()
    if ([string]$entry.sha256 -ne $expectedHash) {
        throw "SHA mismatch for '$($skill.name)'. index.json has '$($entry.sha256)', actual is '$expectedHash'."
    }

    $actualSize = (Get-Item -LiteralPath $zipPath).Length
    if ([int64]$entry.size_bytes -ne $actualSize) {
        throw "Size mismatch for '$($skill.name)'. index.json has '$($entry.size_bytes)', actual is '$actualSize'."
    }

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
    try {
        $entryNames = @($zip.Entries | ForEach-Object { $_.FullName })
        if ($entryNames -notcontains "SKILL.md") {
            throw "Package '$zipName' is missing SKILL.md."
        }
        if ($entryNames -notcontains "skill.json") {
            throw "Package '$zipName' is missing skill.json."
        }
    } finally {
        $zip.Dispose()
    }
}

foreach ($entry in $index.skills) {
    if ($manifestNames -notcontains [string]$entry.name) {
        throw "index.json contains an entry for '$($entry.name)' but no matching skill folder exists."
    }
}

Write-Host "Release validation passed for $($manifestNames.Count) skill(s)."
