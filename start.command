#!/bin/bash

# 1. 현재 스크립트가 있는 폴더로 경로 고정
cd "$(dirname "$0")" || exit 1

# 2. macOS 시스템 환경설정의 첫 번째 선호 언어 감지
if defaults read -g AppleLanguages | head -n 2 | grep -q "ko"; then
    LANG_MODE="KO"
else
    LANG_MODE="EN"
fi

# ==========================================
# [한국어 모드 함수]
# ==========================================
lang_ko() {
    echo "=========================================="
    echo "로고 애니메이션 구동을 준비합니다..."
    echo "=========================================="

    # Node.js Check
    if ! command -v npm &> /dev/null; then
        echo "[오류] Node.js가 설치되어 있지 않습니다."
        echo "https://nodejs.org 에서 다운로드 후 설치해주세요."
        exit 1
    fi

    # Asset Copy
    echo "[1/3] 에셋 복사 중..."
    mkdir -p "react-app/public"

    # Copy Logo (필수 항목 검사)
    if [ -f "logo.png" ]; then
        cp -f "logo.png" "react-app/public/logo.png"
    else
        echo "[오류] logo.png 파일을 찾을 수 없습니다!"
        echo "최상위 폴더에 logo.png 파일이 있는지 확인해주세요."
        exit 1
    fi

    # Priority Data Copy: CSV 우선 -> 없으면 XLSX -> 둘 다 없으면 종료
    if [ -f "namesData.csv" ]; then
        cp -f "namesData.csv" "react-app/public/namesData.csv"
        echo "- CSV 파일을 적용했습니다."
    elif [ -f "namesData.xlsx" ]; then
        cp -f "namesData.xlsx" "react-app/public/namesData.xlsx"
        echo "- XLSX 파일을 적용했습니다."
    else
        echo "[오류] namesData.csv 또는 namesData.xlsx 파일을 찾을 수 없습니다!"
        echo "최상위 폴더에 명단 데이터 파일이 있는지 확인해주세요."
        exit 1
    fi

    # Run Server
    cd react-app || exit 1
    echo "[2/3] 필요한 라이브러리 설치 중..."
    npm install
    echo "[3/3] 서버 실행 중..."
    npm run dev
}

# ==========================================
# [English Mode Function]
# ==========================================
lang_en() {
    echo "=========================================="
    echo "Preparing Logo Animation..."
    echo "=========================================="

    # Node.js Check
    if ! command -v npm &> /dev/null; then
        echo "[ERROR] Node.js is not installed."
        echo "Please install from https://nodejs.org"
        exit 1
    fi

    # Asset Copy
    echo "[1/3] Copying assets..."
    mkdir -p "react-app/public"

    # Copy Logo (Required)
    if [ -f "logo.png" ]; then
        cp -f "logo.png" "react-app/public/logo.png"
    else
        echo "[ERROR] logo.png not found!"
        echo "Please ensure logo.png exists in the root folder."
        exit 1
    fi

    # Priority Data Copy: CSV > XLSX > Fail
    if [ -f "namesData.csv" ]; then
        cp -f "namesData.csv" "react-app/public/namesData.csv"
        echo "- CSV file found and copied."
    elif [ -f "namesData.xlsx" ]; then
        cp -f "namesData.xlsx" "react-app/public/namesData.xlsx"
        echo "- XLSX file found and copied."
    else
        echo "[ERROR] Neither namesData.csv nor namesData.xlsx found!"
        echo "Please ensure one of these files exists in the root folder."
        exit 1
    fi

    # Run Server
    cd react-app || exit 1
    echo "[2/3] Installing dependencies..."
    npm install
    echo "[3/3] Starting server..."
    npm run dev
}

# ==========================================
# 실행 제어 분기
# ==========================================
if [ "$LANG_MODE" = "KO" ]; then
    lang_ko
else
    lang_en
fi