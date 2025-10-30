@echo off
setlocal enabledelayedexpansion

REM Get current folder name and replace spaces with hyphens
for %%I in (.) do set REPO_NAME=%%~nxI
set REPO_NAME=%REPO_NAME: =-%

echo Checking repository: %REPO_NAME%

REM Initialize git if not already initialized
if not exist .git (
    echo Initializing git...
    git init
    git branch -M main
)

REM Check if repo exists on GitHub
gh repo view %REPO_NAME% >nul 2>&1

if %ERRORLEVEL% NEQ 0 (
    echo Repository does not exist. Creating...
    gh repo create %REPO_NAME% --public --source=. --remote=origin
    echo Repository created
) else (
    echo Repository already exists
    REM Set remote if not already set
    git remote get-url origin >nul 2>&1
    if %ERRORLEVEL% NEQ 0 (
        echo Setting remote origin...
        gh repo set-default
    )
)

REM Add, commit, and push
echo Adding files...
git add .

echo Committing changes...
git commit -m "Update from batch script"

echo Pushing to GitHub...
git push -u origin main

echo Done!
