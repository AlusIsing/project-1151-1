# Git & VS Code 速查表

> 左欄是你想做的事情，中間是在 VS Code 怎麼做，右邊是對應的 CLI 指令。

## 基本操作

| 我想要... | VS Code 操作 | CLI 指令 |
|-----------|-------------|----------|
| 把專案下載到電腦 | 按 F1 → 輸入 `Git: Clone` → 貼上 URL | `git clone <url>` |
| 看看我改了什麼 | 左側 Source Control 面板（Ctrl+Shift+G / ⌘⇧G）→ 看檔案列表 | `git status` |
| 看某個檔案改了哪幾行 | Source Control 面板 → 點擊檔案，開啟 diff 檢視 | `git diff <檔案>` |
| 把修改記錄成一個版本 | Source Control → 點 `+` 暫存檔案 → 輸入訊息 → 按 ✓ Commit | `git add <檔案>` + `git commit -m "訊息"` |
| 把版本上傳到 GitHub | Source Control → 點 ··· → Push（或狀態列的 🔄 同步按鈕） | `git push origin <branch>` |
| 一次做完 commit + push | Commit 後，點 ··· → Push | `git add` + `git commit` + `git push` |

## Branch 操作

| 我想要... | VS Code 操作 | CLI 指令 |
|-----------|-------------|----------|
| 看我現在在哪個 branch | 看視窗**左下角**狀態列的 branch 名稱 | `git branch` |
| 開一條新 branch | 點左下角 branch 名稱 → **Create new branch** | `git checkout -b <名稱>` |
| 切換到別的 branch | 點左下角 branch 名稱 → 選目標 branch | `git checkout <名稱>` |
| 把遠端最新的東西拉下來 | Source Control → 點 ··· → **Pull** | `git pull origin <branch>` |

## 協作操作

| 我想要... | VS Code 操作 | CLI 指令 |
|-----------|-------------|----------|
| 發 PR 給組長 | 直接在 GitHub 網頁操作最可靠 | `gh pr create`（需裝 GitHub CLI） |
| 解決衝突 | 衝突檔案會標記，點開後選 Accept Current / Incoming / Both | 手動編輯衝突標記 + `git add` + `git commit` |
| 看 commit 歷史 | 安裝 Git Graph 擴充套件 → 點側邊欄的 Git Graph 圖示 | `git log --oneline --graph` |
| 看誰改了這一行 | 安裝 GitLens 擴充套件 → 每行程式碼旁會顯示作者 | `git blame <檔案>` |
| 看 branch 分支圖 | Git Graph 擴充套件 → 完整的分支圖形化檢視 | `git log --oneline --graph --all` |

## VS Code 快捷鍵

| 功能 | Windows / Linux | macOS |
|------|----------------|-------|
| 開啟 Source Control 面板 | Ctrl+Shift+G | ⌘⇧G |
| 開啟整合終端機 | Ctrl+` | ⌃` |
| 開啟命令面板 | F1 或 Ctrl+Shift+P | ⌘⇧P |
| 快速開啟檔案 | Ctrl+P | ⌘P |

## 建議安裝的 VS Code 擴充套件

| 擴充套件 | 用途 |
|----------|------|
| **Git Graph** | 視覺化分支歷史，看出誰從哪裡分出去、怎麼 merge 回來 |
| **GitLens** | 每一行都能看到是誰、什麼時候改的（git blame 圖形化） |
