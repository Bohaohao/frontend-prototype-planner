param(
  [string]$Source = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
  [string[]]$Targets = @(
    (Join-Path $HOME ".claude\skills\frontend-prototype-planner"),
    (Join-Path $HOME ".codex\skills\frontend-prototype-planner")
  ),
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$excludeDirs = @(".git", ".claude", "优化方案", "notes", "evals", "tools")

function Invoke-Validation {
  param([string]$Root)

  $quickValidate = Join-Path $HOME ".codex\skills\.system\skill-creator\scripts\quick_validate.py"
  if (Test-Path $quickValidate) {
    python $quickValidate $Root
  } else {
    Write-Warning "quick_validate.py not found at $quickValidate"
  }

  python (Join-Path $Root "tools\check_skill_links.py") $Root
}

Invoke-Validation -Root $Source

foreach ($target in $Targets) {
  Write-Host "Sync target: $target"
  if ($DryRun) {
    Write-Host "Dry run only; no files copied."
    continue
  }

  New-Item -ItemType Directory -Force -Path $target | Out-Null
  Get-ChildItem -LiteralPath $target -Force | Where-Object {
    $excludeDirs -notcontains $_.Name
  } | Remove-Item -Recurse -Force

  Get-ChildItem -LiteralPath $Source -Force | Where-Object {
    $excludeDirs -notcontains $_.Name
  } | ForEach-Object {
    Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse -Force
  }
}

Write-Host "Reminder: if README usage examples and references templates diverge, update the single source in references/ and keep README as a pointer."
