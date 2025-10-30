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

REM Add bat file to .gitignore if not already there
findstr /C:"push-to-github.bat" .gitignore >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo push-to-github.bat >> .gitignore
)

git add .

REM Get commit count and increment
git rev-list --count HEAD >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    for /f %%i in ('git rev-list --count HEAD') do set /a COMMIT_NUM=%%i+1
) else (
    set COMMIT_NUM=1
)

REM Determine suffix (st, nd, rd, th)
set SUFFIX=th
if %COMMIT_NUM%==1 set SUFFIX=st
if %COMMIT_NUM%==2 set SUFFIX=nd
if %COMMIT_NUM%==3 set SUFFIX=rd
if %COMMIT_NUM%==21 set SUFFIX=st
if %COMMIT_NUM%==22 set SUFFIX=nd
if %COMMIT_NUM%==23 set SUFFIX=rd
if %COMMIT_NUM%==31 set SUFFIX=st
if %COMMIT_NUM%==32 set SUFFIX=nd
if %COMMIT_NUM%==33 set SUFFIX=rd

echo Committing changes...
git commit -m "%COMMIT_NUM%%SUFFIX% commit"

echo Pushing to GitHub...
git push -u origin main

echo Done!
