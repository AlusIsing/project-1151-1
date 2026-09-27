# Project-1151-1 Git 卡片牆

這是 GDG-NTUST 的 Git 卡片牆專案。每位學員透過編輯 `data/` 底下的 Markdown 檔案來製作自己的個人卡片，練習 Git 的基本操作與多人協作流程。當所有人的卡片合併到主專案後，網頁上會出現一面精美的卡片牆。

> **學員只需要編輯 `data/` 資料夾底下的 `.md` 檔案，不需要碰任何 HTML、CSS 或 JavaScript。**

## 目錄結構

```
data/              ← 學員編輯的資料檔
  members/         ← 個人卡片（每人一個 .md）
  teams/           ← 各組資料（每組一個資料夾）
scripts/           ← 建置與驗證腳本
site/              ← 網站模板與樣式
docs/              ← 教學文件
.github/workflows/ ← CI/CD 自動化
```

## 課前準備

### 講師：初始化小組

講師在課程當天依到場人數決定組數後執行：

```bash
# Windows（PowerShell / CMD）
scripts\init-teams 5          # 方式一：指定組數（自動產生 Team A 到 Team E）
scripts\init-teams a b c d e  # 方式二：明確指定代號

# macOS / Linux / Git Bash
bash scripts/init-teams.sh 5
bash scripts/init-teams.sh a b c d e
```

執行後 commit 並 push 到 `main`：

```bash
git add data/teams/
git commit -m "feat: initialize teams"
git push origin main
```

GitHub Actions 會自動建置並部署到 GitHub Pages。

> **重要：** 必須先完成小組初始化並 push，確認 GitHub Pages 更新後，才請各組組長 fork。否則組長的 fork 裡不會有小組資料夾。

### 學員：課前準備

請參閱 **[課前準備指南](docs/pre-setup.md)**，確保以下工具在課程開始前已安裝並配置完成：

- Git
- GitHub 帳號
- Visual Studio Code

## 組長操作流程

1. **Fork** 這個 repository 到自己的帳號
2. 進入 fork 的 **Actions** 頁面，點擊綠色按鈕同意啟用 Actions
3. 在 fork 的 Settings → Pages 啟用 GitHub Pages（Source 選 GitHub Actions）
4. 把組員加為 fork 的 **Collaborator**（Settings → Collaborators）
5. 組員在組長的 fork 上開 branch、編輯卡片檔案、發 PR
6. 組長 Review 並 Merge 組員的 PR
7. 全部完成後，組長從自己的 fork 發 PR 到上游的 `main`

## 本機預覽

不需要安裝額外工具，只要有 Git 即可：

```bash
# Windows（PowerShell / CMD）
scripts\build

# macOS / Linux / Git Bash
bash scripts/build.sh
```

然後用瀏覽器打開 `dist/index.html` 即可預覽。

## 驗證資料

```bash
# Windows（PowerShell / CMD）
scripts\validate

# macOS / Linux / Git Bash
bash scripts/validate.sh
```

會檢查資料檔格式、衝突標記、成員引用等問題。

## 相關文件

### 學員

- [課前準備指南](docs/pre-setup.md) — 課前必須完成的安裝與配置
- [學員指南](docs/guide.md) — 課程中跟著做的任務清單
- [Git & VS Code 速查表](docs/cheatsheet.md) — 情境 → VS Code 操作 → CLI 指令
- [貢獻指南](CONTRIBUTING.md) — 資料格式與 commit 規範

### 講師

- [講師流程表](docs/instructor/rundown.md) — 50 分鐘時間表
- [衝突演練腳本](docs/instructor/conflict-script.md) — 模擬衝突的教學劇本
