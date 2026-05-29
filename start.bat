@echo off
chcp 65001 >nul
echo ==========================================
echo 로고 애니메이션 구동을 준비합니다...
echo ==========================================

:: 1. Node.js 설치 여부 확인
where npm >nul 2>nul
if %errorlevel% neq 0 (
    echo [오류] Node.js가 설치되어 있지 않아 실행할 수 없습니다.
    echo https://nodejs.org 에서 다운로드 후 설치해주세요.
    pause
    exit /b
)

:: 2. 에셋 복사 (CSV 우선, 없으면 XLSX 복사)
echo [1/3] 데이터 및 이미지 파일 복사 중...

:: 로고 이미지 복사
if exist "logo.png" (
    copy /y "logo.png" "react-app\public\logo.png" >nul
) else (
    echo [경고] logo.png 파일을 찾을 수 없습니다.
)

:: 명단 데이터 복사 분기 처리
if exist "namesData.csv" (
    copy /y "namesData.csv" "react-app\public\namesData.csv" >nul
    echo - namesData.csv 파일을 적용했습니다.
) else if exist "namesData.xlsx" (
    copy /y "namesData.xlsx" "react-app\public\namesData.xlsx" >nul
    echo - namesData.xlsx 파일을 적용했습니다.
) else (
    echo [경고] namesData 데이터 파일(csv 또는 xlsx)을 최상위 폴더에서 찾을 수 없습니다!
)

:: 3. 리액트 폴더로 이동
cd react-app

:: 4. 패키지 설치
echo [2/3] 필요한 라이브러리 설치 중 (최초 1회 시간이 걸릴 수 있습니다)...
call npm install

:: 5. 로컬 서버 실행
echo [3/3] 서버 실행 중... 잠시 후 브라우저가 열립니다.
call npm run dev