#!/bin/bash

# 더블클릭 실행 시 스크립트가 위치한 폴더로 경로를 정확히 맞춤
cd "$(dirname "$0")"

echo "=========================================="
echo "로고 애니메이션 구동을 준비합니다... (Mac용)"
echo "=========================================="

# 1. Node.js 설치 여부 확인
if ! command -v npm &> /dev/null; then
    echo "[오류] Node.js가 설치되어 있지 않아 실행할 수 없습니다."
    echo "https://nodejs.org 에서 다운로드 후 설치해주세요."
    exit 1
fi

# 2. 에셋 복사 (CSV 우선, 없으면 XLSX 복사)
echo "[1/3] 데이터 및 이미지 파일 복사 중..."

if [ -f "logo.png" ]; then
    cp -f "logo.png" "react-app/public/logo.png"
else
    echo "[경고] logo.png 파일을 찾을 수 없습니다."
fi

if [ -f "namesData.csv" ]; then
    cp -f "namesData.csv" "react-app/public/namesData.csv"
    echo "- namesData.csv 파일을 적용했습니다."
elif [ -f "namesData.xlsx" ]; then
    cp -f "namesData.xlsx" "react-app/public/namesData.xlsx"
    echo "- namesData.xlsx 파일을 적용했습니다."
else
    echo "[경고] namesData 데이터 파일(csv 또는 xlsx)을 최상위 폴더에서 찾을 수 없습니다!"
fi

# 3. 리액트 폴더로 이동 (폴더명이 다르면 수정 필요)
cd react-app || exit

# 4. 패키지 설치
echo "[2/3] 필요한 라이브러리 설치 중 (최초 1회 시간이 걸릴 수 있습니다)..."
npm install

# 5. 로컬 서버 실행
echo "[3/3] 서버 실행 중... 잠시 후 브라우저가 열립니다."
npm run dev