# Kinetic Logo Typography For React

[🇰🇷 한국어](#한국어-korean) | [🇺🇸 English](#english)

---

## 한국어 (Korean)

수많은 사람들의 이름이 모여 하나의 로고로 완성되는 역동적인 타이포그래피 애니메이션 템플릿입니다.
복잡한 코딩이나 설정 없이, **사진과 엑셀(또는 CSV) 파일만 교체**하면 누구나 자신만의 애니메이션을 만들 수 있습니다.

### 📥 템플릿 다운로드 방법 (Download)

깃허브 환경이 익숙하지 않으시다면 아래의 방법으로 파일을 다운로드해 주세요.

1. 현재 화면 우측 상단의 초록색 **[ <> Code ]** 버튼을 클릭합니다.
2. 메뉴 맨 아래의 **[ Download ZIP ]**을 클릭하여 파일을 다운로드합니다.
3. 다운로드된 ZIP 파일의 압축을 완전히 해제하고 폴더 안으로 들어갑니다.

### ⚠️ 필수 준비 사항 (Prerequisites)

이 프로그램을 실행하려면 컴퓨터에 **Node.js**가 설치되어 있어야 합니다.<br>
설치되어 있지 않다면, 사용 중인 운영체제에 맞는 아래 링크를 클릭하여 설치 파일을 즉시 다운로드해 주세요.

* 🪟 **Windows 사용자:** [Node.js 다운로드 (클릭 시 바로 다운로드)](https://nodejs.org/dist/v24.16.0/node-v24.16.0-x64.msi)
* 🍎 **Mac (macOS) 사용자:** [Node.js 다운로드 (클릭 시 바로 다운로드)](https://nodejs.org/dist/v24.16.0/node-v24.16.0.pkg)

*(만약 위 직접 다운로드 링크가 작동하지 않거나 다른 버전이 필요하다면 [Node.js 공식 홈페이지](https://nodejs.org/ko/download)에 접속하여 직접 다운로드해 주세요.)*

### 🛠 사용 방법 (How to Use)

#### 1. 에셋 파일 준비하기

프로젝트의 최상위 폴더(이 README 파일이 있는 곳)에 아래 두 개의 파일을 준비해서 덮어씌워 주세요.

* **`logo.png`**: 완성될 로고 이미지 파일입니다. (배경이 투명한 PNG 파일을 권장합니다.)
* **`namesData.csv`** (또는 **`namesData.xlsx`**): 애니메이션에 등장할 이름 명단입니다.

#### 2. 명단 데이터 작성 규칙

엑셀이나 CSV 파일을 작성할 때는 반드시 아래의 규칙을 지켜주세요.

* **1행 (헤더)**: 아무 글자나 적혀 있어도 무방합니다. (예: `이름`, `우선순위`)
* **A열 (1번째 칸)**: 화면에 표시될 **이름**을 적습니다.
* **B열 (2번째 칸)**: 가장 먼저 화면에 나타나게 할 중요한 이름이라면 대문자 **`O`**를 적어줍니다. (일반 이름은 비워둡니다.)

*(예시)*

| 이름  | 우선순위 |
|:----|:-----|
| 홍길동 | O    |
| 김철수 |      |
| 이영희 | O    |

#### 3. 세부 설정 변경하기 (선택 사항)

코드를 수정할 필요 없이, 최상위 폴더에 있는 **`config.json`** 파일을 메모장으로 열어 애니메이션의 속도와 색상 등을 자유롭게 커스텀할 수 있습니다.

* `spreadDuration`: 입자들이 흩어져서 출발을 대기하는 총 시간 (초)
* `flightDuration`: 입자가 화면 밖에서 지정된 위치로 날아오는 순수 비행 시간 (초)
* `logoFadeDuration`: 최종 로고 사진이 서서히 선명하게 나타나는 시간 (초)
* `logoWidth`: 화면 중앙에 모이는 로고의 가로 크기 (픽셀)
* `backgroundColor`: 배경 색상 (예: `"#050a15"`, `"black"`)
* `sequentialOrder`: 명단에 적힌 순서대로 차례대로 출발할지 여부 (`true`: 명단 순서대로, `false`: 무작위 섞기)

### 🚀 실행 방법 (Run)

운영체제에 맞는 스크립트 파일을 실행하면 파일 복사부터 서버 구동까지 자동으로 진행됩니다.

* **Windows 사용자:** 최상위 폴더에 있는 **`start_final.bat`** 파일을 더블클릭하여 실행합니다.
* **Mac (macOS) 사용자:** 최상위 폴더에 있는 **`start.command`** 파일을 더블클릭하여 실행합니다.
  *(주의: macOS 보안 정책상 최초 1회는 실행 권한을 부여해야 합니다. 아래 절차를 따라주세요.)*
    1. `Launchpad` > `기타` > `터미널(Terminal)`을 엽니다.
    2. 터미널 창에 `chmod +x `를 입력합니다. (마지막에 띄어쓰기 한 칸 필수!)
    3. 그 옆에 `start.command` 파일을 마우스로 끌어다 놓고(Drag & Drop) 엔터를 칩니다.
    4. 이제부터 `start.command`를 일반 파일처럼 더블클릭해서 실행할 수 있습니다.

### ⏹ 멈추는 방법 (Stop)

애니메이션 감상을 마치셨다면, 실행창(터미널)을 그대로 `X` 버튼을 눌러 닫으시면 서버가 완전히 종료됩니다.

---

## English

A dynamic typography animation template where countless names gather to form a single logo.
Without complex coding or setup, **just replace the image and Excel (or CSV) file** to create your own animation.

### 📥 How to Download

If you are not familiar with GitHub, please follow these steps to download the template:

1. Click the green **[ <> Code ]** button at the top right of this screen.
2. Click **[ Download ZIP ]** at the bottom of the menu.
3. Completely extract the downloaded ZIP file and open the folder.

### ⚠️ Prerequisites

To run this program, **Node.js** must be installed on your computer.<br>
If not installed, click the link below that matches your operating system to download the installer directly:

* 🪟 **Windows Users:** [Download Node.js (Direct Link)](https://nodejs.org/dist/v24.16.0/node-v24.16.0-x64.msi)
* 🍎 **Mac (macOS) Users:** [Download Node.js (Direct Link)](https://nodejs.org/dist/v24.16.0/node-v24.16.0.pkg)

*(If the direct links above do not work, please visit the [Node.js Official Website](https://nodejs.org/en/download) to
download it manually.)*

### 🛠 How to Use

#### 1. Prepare Asset Files

Place the following two files in the root folder of the project (where this README is located), overwriting the existing
ones.

* **`logo.png`**: The final logo image file. (A transparent PNG is recommended.)
* **`namesData.csv`** (or **`namesData.xlsx`**): The list of names to appear in the animation.

#### 2. Data Formatting Rules

When preparing your Excel or CSV file, you must follow these rules:

* **Row 1 (Header)**: Can be anything (e.g., `Name`, `Priority`).
* **Column A (1st Column)**: Enter the **names** to be displayed.
* **Column B (2nd Column)**: If you want a name to appear first (high priority), enter a capital **`O`**. Leave it blank
  for regular names.

*(Example)*

| Name       | Priority |
|:-----------|:---------|
| John Doe   | O        |
| Jane Smith |          |
| Alice      | O        |

#### 3. Customize Settings (Optional)

Without modifying the code, you can open the **`config.json`** file in the root folder with a text editor (like Notepad)
to freely customize the speed, color, and more.

* `spreadDuration`: Total wait time for particles to scatter and depart (seconds).
* `flightDuration`: Pure flight time for particles to reach their designated positions (seconds).
* `logoFadeDuration`: Time it takes for the final logo to smoothly fade in (seconds).
* `logoWidth`: The width of the final logo gathered in the center (pixels).
* `backgroundColor`: Background color (e.g., `"#050a15"`, `"black"`).
* `sequentialOrder`: Whether particles depart in the order listed (`true`: list order, `false`: random shuffle).

### 🚀 How to Run

Run the script file matching your OS to automatically copy the files and start the server.

* **Windows Users:** Double-click the **`start_final.bat`** file in the root folder.
* **Mac (macOS) Users:** Double-click the **`start.command`** file in the root folder.
  *(Note: Due to macOS's security policy, you must grant execution permission the first time. Follow these steps:)*
    1. Open `Launchpad` > `Other` > `Terminal`.
    2. Type `chmod +x ` in the terminal window. (Make sure to leave a space at the end!)
    3. Drag and drop the `start.command` file next to it, then press Enter.
    4. From now on, you can simply double-click `start.command` to run it.

### ⏹ How to Stop

When you are done watching the animation, simply click the `X` button to close the execution window (Terminal), and the
server will shut down completely.