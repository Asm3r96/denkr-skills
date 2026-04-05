param(
    [string]$RepoOwner = "Asm3r96",
    [string]$RepoName = "denkr-skills",
    [string]$Branch = "main"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillsRoot = Join-Path $repoRoot "skills"
$packagesRoot = Join-Path $repoRoot "packages"
$distRoot = Join-Path $repoRoot "dist"

New-Item -ItemType Directory -Force -Path $packagesRoot | Out-Null
New-Item -ItemType Directory -Force -Path $distRoot | Out-Null

$manifestEntries = @()
$generatedAt = (Get-Date).ToUniversalTime().ToString("o")

$skillDirs = Get-ChildItem -Path $skillsRoot -Directory | Sort-Object Name

foreach ($skillDir in $skillDirs) {
    $skillJsonPath = Join-Path $skillDir.FullName "skill.json"
    $skillMdPath = Join-Path $skillDir.FullName "SKILL.md"

    if (!(Test-Path $skillJsonPath)) {
        throw "Missing skill.json in $($skillDir.FullName)"
    }

    if (!(Test-Path $skillMdPath)) {
        throw "Missing SKILL.md in $($skillDir.FullName)"
    }

    $skill = Get-Content -Raw -Path $skillJsonPath | ConvertFrom-Json
    $skillName = [string]$skill.name
    $skillVersion = [string]$skill.version

    if ([string]::IsNullOrWhiteSpace($skillName)) {
        throw "Skill name is missing in $skillJsonPath"
    }

    if ([string]::IsNullOrWhiteSpace($skillVersion)) {
        throw "Skill version is missing in $skillJsonPath"
    }

    $packageRoot = Join-Path $distRoot $skillName
    if (Test-Path $packageRoot) {
        Remove-Item -LiteralPath $packageRoot -Recurse -Force
    }

    New-Item -ItemType Directory -Force -Path $packageRoot | Out-Null

    foreach ($child in Get-ChildItem -Path $skillDir.FullName -Force) {
        Copy-Item -LiteralPath $child.FullName -Destination $packageRoot -Recurse -Force
    }

    $zipName = "$skillName-$skillVersion.zip"
    $zipPath = Join-Path $packagesRoot $zipName
    if (Test-Path $zipPath) {
        Remove-Item -LiteralPath $zipPath -Force
    }

    Compress-Archive -Path (Join-Path $packageRoot "*") -DestinationPath $zipPath -CompressionLevel Optimal

    $sha256 = (Get-FileHash -Path $zipPath -Algorithm SHA256).Hash.ToLowerInvariant()
    $sizeBytes = (Get-Item -LiteralPath $zipPath).Length

    $entry = [ordered]@{
        name = $skill.name
        display_name = $skill.display_name
        description = $skill.description
        version = $skill.version
        download_url = "https://raw.githubusercontent.com/$RepoOwner/$RepoName/$Branch/packages/$zipName"
        sha256 = $sha256
        size_bytes = $sizeBytes
        entry_file = "SKILL.md"
        repo_owner = $RepoOwner
        repo_name = $RepoName
        branch = $Branch
        published_at = $generatedAt
        capabilities = $skill.capabilities
        permissions = $skill.permissions
    }

    $manifestEntries += [pscustomobject]$entry
}

$manifest = [ordered]@{
    source = "https://raw.githubusercontent.com/$RepoOwner/$RepoName/$Branch/index.json"
    generated_at = $generatedAt
    skills = $manifestEntries
}

$manifestPath = Join-Path $repoRoot "index.json"
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$manifestJson = $manifest | ConvertTo-Json -Depth 8
[System.IO.File]::WriteAllText($manifestPath, $manifestJson + [Environment]::NewLine, $utf8NoBom)
