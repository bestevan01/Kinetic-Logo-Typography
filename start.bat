@echo off
cd /d "%~dp0"

:: 1. 시스템 언어 감지 (한국어면 KO로 점프, 아니면 EN으로 점프)
REG QUERY "HKCU\Control Panel\International" /v LocaleName 2>nul | find /i "ko-KR" >nul
if %errorlevel% equ 0 goto :LANG_KO
goto :LANG_EN


:: ==========================================
:: [한국어 모드]
:: ==========================================
:LANG_KO
chcp 65001 >nul
echo ==========================================
echo 로고 애니메이션 구동을 준비합니다...
echo ==========================================

where npm >nul 2>nul
if %errorlevel% equ 0 goto :CHECK_ASSET_KO
echo [오류] Node.js가 설치되어 있지 않습니다.
echo https://nodejs.org 에서 다운로드 후 설치해주세요.
pause
exit /b

:CHECK_ASSET_KO
echo [1/3] 에셋 복사 중...
if not exist "react-app\public" mkdir "react-app\public"

if exist "config.json" (
    copy /y "config.json" "react-app\public\config.json" >nul
)

if exist "logo.png" (
    copy /y "logo.png" "react-app\public\logo.png" >nul
    goto :CHECK_DATA_KO
)
echo [오류] logo.png 파일을 찾을 수 없습니다!
echo 최상위 폴더에 logo.png 파일이 있는지 확인해주세요.
pause
exit /b

:CHECK_DATA_KO
if exist "namesData.csv" (
    copy /y "namesData.csv" "react-app\public\namesData.csv" >nul
    echo - CSV 파일을 적용했습니다.
    goto :START_SERVER_KO
)
if exist "namesData.xlsx" (
    copy /y "namesData.xlsx" "react-app\public\namesData.xlsx" >nul
    echo - XLSX 파일을 적용했습니다.
    goto :START_SERVER_KO
)
echo [오류] namesData.csv 또는 namesData.xlsx 파일을 찾을 수 없습니다!
echo 최상위 폴더에 명단 데이터 파일이 있는지 확인해주세요.
pause
exit /b

:START_SERVER_KO
cd react-app
echo [2/3] 필요한 라이브러리 설치 중...
call npm install
echo [3/3] 서버 실행 중...
call npm run dev
pause
exit /b


:: ==========================================
:: [English Mode]
:: ==========================================
:LANG_EN
echo ==========================================
echo Preparing Logo Animation...
echo ==========================================

where npm >nul 2>nul
if %errorlevel% equ 0 goto :CHECK_ASSET_EN
echo [ERROR] Node.js is not installed.
echo Please install from https://nodejs.org
pause
exit /b

:CHECK_ASSET_EN
echo [1/3] Copying assets...
if not exist "react-app\public" mkdir "react-app\public"

if exist "config.json" (
    copy /y "config.json" "react-app\public\config.json" >nul
)

if exist "logo.png" (
    copy /y "logo.png" "react-app\public\logo.png" >nul
    goto :CHECK_DATA_EN
)
echo [ERROR] logo.png not found!
echo Please ensure logo.png exists in the root folder.
pause
exit /b

:CHECK_DATA_EN
if exist "namesData.csv" (
    copy /y "namesData.csv" "react-app\public\namesData.csv" >nul
    echo - CSV file found and copied.
    goto :START_SERVER_EN
)
if exist "namesData.xlsx" (
    copy /y "namesData.xlsx" "react-app\public\namesData.xlsx" >nul
    echo - XLSX file found and copied.
    goto :START_SERVER_EN
)
echo [ERROR] Neither namesData.csv nor namesData.xlsx found!
echo Please ensure one of these files exists in the root folder.
pause
exit /b

:START_SERVER_EN
cd react-app
echo [2/3] Installing dependencies...
call npm install
echo [3/3] Starting server...
call npm run dev
pause
exit /b