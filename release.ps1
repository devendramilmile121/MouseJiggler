#!/usr/bin/env pwsh

param(
    [Parameter(Mandatory=$true)]
    [string]$Version,
    
    [switch]$DryRun
)

# Validate version format
if ($Version -notmatch '^v?\d+\.\d+\.\d+$') {
    Write-Error "Version must be in format 'x.y.z' or 'vx.y.z'"
    exit 1
}

# Ensure version starts with 'v'
if (-not $Version.StartsWith('v')) {
    $Version = "v$Version"
}

$VersionNumber = $Version.Substring(1)

Write-Host "Preparing release for version: $Version" -ForegroundColor Green

# Update project file
$ProjectFile = "MouseJiggler.csproj"
if (Test-Path $ProjectFile) {
    Write-Host "Updating version in $ProjectFile..." -ForegroundColor Yellow
    
    $content = Get-Content $ProjectFile -Raw
    $content = $content -replace '<Version>.*</Version>', "<Version>$VersionNumber</Version>"
    $content = $content -replace '<AssemblyVersion>.*</AssemblyVersion>', "<AssemblyVersion>$VersionNumber.0</AssemblyVersion>"
    $content = $content -replace '<FileVersion>.*</FileVersion>', "<FileVersion>$VersionNumber.0</FileVersion>"
    
    if (-not $DryRun) {
        Set-Content $ProjectFile $content -Encoding UTF8
        Write-Host "✓ Updated project file" -ForegroundColor Green
    } else {
        Write-Host "✓ Would update project file (dry run)" -ForegroundColor Cyan
    }
} else {
    Write-Error "Project file not found: $ProjectFile"
    exit 1
}

# Check if we're in a git repository
if (Test-Path ".git") {
    Write-Host "Git repository detected. Preparing git operations..." -ForegroundColor Yellow
    
    # Check for uncommitted changes
    $gitStatus = git status --porcelain
    if ($gitStatus -and -not $DryRun) {
        Write-Host "Uncommitted changes detected:" -ForegroundColor Yellow
        git status --short
        $response = Read-Host "Do you want to commit these changes? (y/N)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            git add .
            git commit -m "Prepare release $Version"
            Write-Host "✓ Committed changes" -ForegroundColor Green
        } else {
            Write-Warning "Please commit your changes before creating a release tag"
            exit 1
        }
    }
    
    # Create and push tag
    if (-not $DryRun) {
        Write-Host "Creating git tag: $Version" -ForegroundColor Yellow
        git tag $Version
        
        $pushResponse = Read-Host "Push tag to remote? This will trigger the GitHub Actions release workflow. (y/N)"
        if ($pushResponse -eq 'y' -or $pushResponse -eq 'Y') {
            git push origin $Version
            Write-Host "✓ Pushed tag to remote" -ForegroundColor Green
            Write-Host ""
            Write-Host "🚀 Release workflow triggered! Check GitHub Actions for build progress." -ForegroundColor Green
            Write-Host "   URL: https://github.com/$(git config --get remote.origin.url | ForEach-Object { $_ -replace '.*/([^/]+)/([^/]+?)(?:\.git)?$', '$1/$2' })/actions" -ForegroundColor Cyan
        } else {
            Write-Host "✓ Tag created locally. Push manually with: git push origin $Version" -ForegroundColor Yellow
        }
    } else {
        Write-Host "✓ Would create and push tag: $Version (dry run)" -ForegroundColor Cyan
    }
} else {
    Write-Warning "Not in a git repository. Manual release process required."
}

Write-Host ""
Write-Host "Release preparation completed!" -ForegroundColor Green
Write-Host "Version: $Version" -ForegroundColor White
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Verify changes in MouseJiggler.csproj" -ForegroundColor White
Write-Host "  2. Push the tag to trigger GitHub Actions: git push origin $Version" -ForegroundColor White
Write-Host "  3. Monitor the build at GitHub Actions" -ForegroundColor White
Write-Host "  4. Download artifacts from the GitHub Release page" -ForegroundColor White