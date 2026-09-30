param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('codex', 'gajae')]
    [string]$Agent,
    [switch]$Force
)

$destination = if ($Agent -eq 'codex') {
    Join-Path $HOME '.codex\skills'
} else {
    Join-Path $HOME '.gjc\agent\skills'
}
$root = $PSScriptRoot

New-Item -ItemType Directory -Path $destination -Force | Out-Null
Get-ChildItem -LiteralPath (Join-Path $root 'skills') -Directory | ForEach-Object {
    $target = Join-Path $destination $_.Name
    if ((Test-Path -LiteralPath $target) -and -not $Force) {
        throw "exists: $target (rerun with -Force to replace)"
    }
    if (Test-Path -LiteralPath $target) {
        Remove-Item -LiteralPath $target -Recurse -Force
    }
    Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse
    Write-Output "installed: $target"
}
