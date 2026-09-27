# 課前準備指南

> **請在活動當天之前完成以下所有步驟。** 現場的網路和時間有限，如果當天才開始安裝，很可能會來不及跟上進度。整個準備過程大約需要 **25–35 分鐘**。

我們在活動中會用到三樣工具：

| 工具 | 用途 | 比喻 |
|------|------|------|
| **Git** | 版本控制系統，記錄檔案的每一次修改 | 像是幫文件自動存檔的時光機 |
| **GitHub** | 雲端平台，讓多人可以一起協作 | 像是 Google Drive，但專門給程式碼用的 |
| **VS Code** | 程式碼編輯器，我們用它來編輯檔案和操作 Git | 像是進階版的記事本 |

---

## Step 1：安裝 Git

Git 是一套版本控制工具，裝在你的電腦上後，就能追蹤檔案的每一次修改、和別人協作。

### Windows

1. 前往 [git-scm.com](https://git-scm.com)，點擊頁面上的 **Download for Windows** 按鈕
2. 下載完成後，執行安裝檔（`Git-x.xx.x-64-bit.exe`）
3. 安裝過程中會出現很多設定頁面，**大部分都維持預設值按 Next 就好**，以下幾個地方請留意：

   | 設定頁面 | 建議選項 | 說明 |
   |---------|---------|------|
   | **Choosing the default editor** | 選 **Use Visual Studio Code as Git's default editor** | 之後衝突合併等操作會用 VS Code 開啟 |
   | **Adjusting the name of the initial branch** | 選 **Override the default branch name for new repositories**，輸入 `main` | 確保新建的 repository 預設分支為 `main` |
   | **Adjusting your PATH environment** | 選 **Git from the command line and also from 3rd-party software**（預設值） | 讓你在任何終端機都能使用 git 指令 |

   > 其餘選項全部按 **Next** → 最後按 **Install** → 完成後按 **Finish**。

4. 安裝完成後，打開「開始」選單，搜尋 **Git Bash**（或 **命令提示字元**），輸入以下指令確認安裝成功：

   ```
   git --version
   ```

   你應該會看到類似這樣的輸出：

   ```
   git version 2.47.1.windows.1
   ```

   > 版本號碼不需要完全一樣，只要有出現 `git version` 就代表安裝成功。

### macOS

macOS 有兩種安裝方式，選一種即可：

**方法一：透過 Xcode Command Line Tools（推薦）**

1. 打開「終端機」（在 Spotlight 搜尋 `Terminal` 或從「應用程式 → 工具程式」找到）
2. 輸入以下指令：

   ```
   xcode-select --install
   ```

3. 會彈出一個對話框，點 **安裝**，等它跑完即可（約 5–10 分鐘）

   > 這個方法只會安裝開發者需要的命令列工具，**不會**安裝完整的 Xcode（好幾 GB 的那個）。

**方法二：從官網下載**

1. 前往 [git-scm.com](https://git-scm.com)，點擊 **Download for macOS**
2. 下載並執行安裝檔

**驗證安裝**

打開終端機，輸入：

```
git --version
```

你應該會看到類似這樣的輸出：

```
git version 2.39.5 (Apple Git-154)
```

> 版本號碼不需要完全一樣，只要有出現 `git version` 就代表安裝成功。

---

## Step 2：配置 Git

安裝完 Git 之後，需要告訴 Git「你是誰」。這些資訊會出現在你每一次的 commit（版本記錄）上，讓大家知道是誰做了這次修改。

> 這就像在圖書館借書時要填借閱證一樣——Git 需要知道這筆修改是誰做的。

打開終端機（Windows 可以用 Git Bash 或命令提示字元，macOS 用終端機），依序輸入以下三行指令：

```bash
git config --global user.name "你的名字"
```

```bash
git config --global user.email "你的email"
```

```bash
git config --global init.defaultBranch main
```

**請把引號裡的內容換成你自己的資訊。** 例如：

```bash
git config --global user.name "Wang Xiao Ming"
git config --global user.email "xiaoming@example.com"
git config --global init.defaultBranch main
```

### 各指令說明

| 指令 | 作用 |
|------|------|
| `user.name` | 設定你的名字，會顯示在 commit 記錄中 |
| `user.email` | 設定你的 email，**建議使用與 GitHub 帳號相同的 email**，這樣 GitHub 才能正確把 commit 對應到你的帳號 |
| `init.defaultBranch main` | 設定新建 repository 時的預設分支名稱為 `main`。某些舊版 Git 預設是 `master`，統一用 `main` 可以避免混亂 |

### 驗證配置

輸入以下指令確認設定是否正確：

```bash
git config --global user.name
```

應該會顯示你剛才填的名字，例如：

```
Wang Xiao Ming
```

```bash
git config --global user.email
```

應該會顯示你的 email，例如：

```
xiaoming@example.com
```

---

## Step 3：註冊 GitHub 帳號

GitHub 是一個讓開發者分享和協作程式碼的雲端平台。我們的 Workshop 會用 GitHub 來進行多人協作。

### 註冊步驟

1. 前往 [github.com](https://github.com)
2. 點擊右上角的 **Sign up**
3. 依照指示填寫：
   - **Email**：建議使用跟 Step 2 中 `git config` 設定的同一個 email
   - **Password**：設定一組密碼
   - **Username**：選一個你喜歡的帳號名稱

   > **關於 Username：** 你的 GitHub username 會出現在你的個人卡片和 GitHub 個人頁面上。選一個你覺得舒服的名字就好，例如 `xiaoming-wang`、`alicechen123` 等等。建議使用**英文小寫加上連字號或數字**。

4. 完成驗證（可能會有拼圖驗證）
5. 到你的 email 收驗證信，點擊確認連結

### 建議設定：啟用雙重驗證（Two-Factor Authentication）

GitHub 強烈建議啟用雙重驗證來保護你的帳號：

1. 登入 GitHub 後，點右上角頭像 → **Settings**
2. 左側選單點 **Password and authentication**
3. 找到 **Two-factor authentication**，點 **Enable**
4. 依照指示設定（可以用手機的驗證器 App，例如 Google Authenticator）

> 如果覺得設定太複雜，可以先跳過，活動當天不影響操作。但為了帳號安全，建議有空時補上。

---

## Step 4：安裝 Visual Studio Code

VS Code 是我們在活動中使用的程式碼編輯器。它免費、跨平台，而且內建了很好用的 Git 操作介面。

### 安裝步驟

1. 前往 [code.visualstudio.com](https://code.visualstudio.com)
2. 點擊 **Download** 按鈕（網站會自動偵測你的作業系統）
3. 下載完成後執行安裝檔
   - **Windows**：執行 `.exe` 安裝檔，按照預設值一路 Next → Install → Finish
     - 建議在安裝過程中勾選 **Add to PATH**（通常預設已勾選）
   - **macOS**：打開 `.dmg` 檔，把 VS Code 圖示拖到「應用程式」資料夾
4. 安裝完成後，打開 VS Code

### 認識 VS Code 介面

打開 VS Code 後，你會看到以下幾個主要區域：

- **左側邊欄**：檔案總管、搜尋、版本控制（Git）等功能的圖示
- **編輯區**：中間最大的區域，用來編輯檔案
- **下方面板**：終端機、輸出等工具（可能預設是收起來的）

### 開啟終端機

我們在活動中會經常用到 VS Code 內建的終端機。開啟方式：

- **快捷鍵**：按 `` Ctrl+` ``（Windows / Linux）或 `` Control+` ``（macOS）
  - `` ` `` 是鍵盤左上角、數字 `1` 左邊的那個按鍵（反引號）
- **選單**：上方選單 → **Terminal** → **New Terminal**
- **中文介面**：上方選單 → **終端** → **新終端**

打開後，你會在 VS Code 下方看到一個終端機視窗。在這裡可以直接輸入 Git 指令。

> **小提醒**：Windows 使用者在 VS Code 的終端機中，預設可能是 PowerShell。如果想切換成 Git Bash，可以點終端機右上角的下拉箭頭選擇。兩者都可以正常使用 Git 指令。

---

## Step 5：安裝 VS Code 擴充功能（選用但推薦）

以下擴充功能不是必要的，但會讓活動體驗更好。

### Git Graph

Git Graph 可以用圖形化的方式顯示 Git 的分支和合併歷史，讓你清楚看到每個人是從哪裡開出分支、做了什麼修改、怎麼合併回來的。

**安裝方式：**

1. 打開 VS Code
2. 點左側邊欄的 **擴充功能** 圖示（四個方塊的圖示，或按 `Ctrl+Shift+X` / `Cmd+Shift+X`）
3. 在搜尋框輸入 `Git Graph`
4. 找到由 **mhutchie** 發佈的 **Git Graph**，點 **Install**

安裝完成後，你可以在 VS Code 左下角的狀態列看到 **Git Graph** 按鈕，或從命令面板（`Ctrl+Shift+P` / `Cmd+Shift+P`）搜尋「Git Graph: View Git Graph」來打開。

---

## Step 6：驗證安裝

讓我們確認所有東西都裝好了。打開 VS Code，開啟終端機（`` Ctrl+` ``），依序輸入以下指令：

### 1. 確認 Git 已安裝

```bash
git --version
```

預期輸出（版本號可能不同）：

```
git version 2.47.1
```

### 2. 確認 Git 使用者名稱

```bash
git config --global user.name
```

預期輸出：你在 Step 2 設定的名字。

### 3. 確認 Git email

```bash
git config --global user.email
```

預期輸出：你在 Step 2 設定的 email。

### 4. 確認預設分支名稱

```bash
git config --global init.defaultBranch
```

預期輸出：

```
main
```

> 如果這裡顯示空白或 `master`，請回到 Step 2 執行 `git config --global init.defaultBranch main`。

**如果以上四項都有正確的輸出，恭喜你，課前準備完成了！**

---

## 常見問題（FAQ）

### Q：Windows 安裝 Git 時選項太多，不知道怎麼選？

全部用預設值按 Next 就好。如果你不確定自己改過什麼，可以解除安裝後重新安裝一次，全程只按 Next。唯一建議額外注意的是把 default editor 改成 VS Code 以及把 default branch name 改成 `main`（詳見 Step 1）。

### Q：macOS 跳出「要安裝 Xcode 嗎？」的提示

`xcode-select --install` 安裝的是 **Command Line Tools**，只有幾百 MB，不是完整的 Xcode（好幾 GB）。安裝時間約 5–10 分鐘，請耐心等待。

### Q：輸入 `git --version` 顯示「不是內部或外部命令」或「command not found」

- **Windows**：關閉目前的終端機視窗，重新打開一個新的（或重新啟動 VS Code）。如果還是不行，嘗試打開「開始」選單搜尋 **Git Bash**，在 Git Bash 裡輸入 `git --version`。如果 Git Bash 可以用，代表 Git 已安裝但 PATH 沒設好，建議重新安裝 Git 並確認選擇了「Git from the command line and also from 3rd-party software」。
- **macOS**：關閉終端機再重新打開試試。如果還是不行，再跑一次 `xcode-select --install`。

### Q：GitHub 帳號的 Username 可以改嗎？

可以，在 GitHub Settings → Account → Change username。但 **不建議頻繁更改**，因為你的舊連結會失效、別人 fork 的 URL 也會受影響。

### Q：我的電腦很舊 / 跑很慢，可以用嗎？

可以！Git 是命令列工具，幾乎不吃資源。VS Code 的硬體需求也很低（1.6 GHz 以上的處理器、1 GB 記憶體即可）。即使是比較舊的電腦，這兩套工具都能正常運作。

### Q：在 Windows 檔案總管看不到 `.git` 資料夾？

`.git` 是隱藏資料夾。要看到它：

1. 打開檔案總管
2. 點上方的 **檢視** 選項
3. 勾選 **隱藏的項目**

Windows 11 的路徑：檔案總管 → 上方工具列 → **檢視** → **顯示** → 勾選 **隱藏的項目**。

### Q：macOS Finder 看不到 `.git` 資料夾？

在 Finder 中按 `Cmd + Shift + .`（句號鍵），就可以切換顯示 / 隱藏以 `.` 開頭的檔案和資料夾。再按一次可以切換回來。

### Q：`git config` 的 email 一定要跟 GitHub 一樣嗎？

**強烈建議一致。** GitHub 透過 email 來辨認 commit 的作者。如果 Git config 的 email 跟 GitHub 帳號的 email 不一樣，你的 commit 在 GitHub 上就不會顯示你的頭像和連結到你的 GitHub 個人頁面。

如果你想確認 GitHub 帳號用的 email：登入 GitHub → 點頭像 → **Settings** → 左側 **Emails**。

### Q：VS Code 的介面是英文，可以改成中文嗎？

可以。打開 VS Code → 按 `Ctrl+Shift+P`（macOS: `Cmd+Shift+P`）→ 輸入 `display language` → 選 **Configure Display Language** → 安裝 **Chinese (Traditional) Language Pack** → 重新啟動 VS Code。

不過活動中講師的畫面會是英文介面，建議你也用英文，方便對照。

### Q：我用 Linux 可以嗎？

可以！大部分 Linux 發行版自帶 Git，如果沒有可以用套件管理器安裝（例如 `sudo apt install git`）。VS Code 也有 Linux 版。活動的操作流程完全適用。

---

## 完成確認清單

請逐項確認以下事項都已完成：

- [ ] 已安裝 Git，且 `git --version` 有正確輸出
- [ ] 已設定 `git config --global user.name`
- [ ] 已設定 `git config --global user.email`
- [ ] 已設定 `git config --global init.defaultBranch main`
- [ ] 已註冊 GitHub 帳號並能正常登入
- [ ] 已安裝 VS Code
- [ ] 能在 VS Code 中開啟終端機（`Ctrl+`\`）
- [ ] （選用）已安裝 Git Graph 擴充功能

**全部打勾就代表你準備好了，活動當天見！**

> 如果在準備過程中遇到任何問題，可以在活動群組中發問，或是活動當天提早到場請工作人員協助。
