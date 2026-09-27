# Git 多人協作 Workshop — 學員指南

> 今天的目標：每個人製作一張屬於自己的卡片，透過 Git 協作把大家的卡片合併在一起，最終在網頁上看到一面精美的**卡片牆**。

---

## 開始之前

### 今天會做出什麼？

講師會在投影幕上展示最終成品——一面收集了所有人卡片的網頁。每張卡片上有你的名字、emoji、自我介紹和興趣標籤。當你的 Pull Request 被合併後，你的卡片就會出現在這面牆上。

### 確認課前準備

請確認你已經完成 [課前準備指南](pre-setup.md) 中的所有步驟：

- [ ] 已安裝 Git，且在終端機輸入 `git --version` 能看到版本號
- [ ] 已註冊 GitHub 帳號並登入
- [ ] 已安裝 VS Code
- [ ] 已設定 Git 使用者名稱與信箱

### 你會編輯的檔案長這樣

每個人的卡片就是一個 `.md` 純文字檔，格式如下：

```markdown
# 你的名字

## Emoji

🎯

## Department

TODO：填寫你的系級（例如：資工系三年級）

## Bio

TODO：用一句話介紹你自己

## Interests

TODO：列出你的興趣或技能，一行一個
- 寫程式
- 打遊戲
- 喝咖啡

## GitHub

TODO：填寫你的 GitHub 帳號
```

你只需要把 `TODO` 的部分換成你自己的內容，**不需要碰任何程式碼**。

---

## 第一階段：加入專案（CLI 指令）

> 這個階段我們用**終端機指令**來操作 Git。先學指令、理解原理，後面會再教你怎麼用 VS Code 的圖形介面做同樣的事。

### 打開 VS Code 的終端機

在 VS Code 中按 `` Ctrl+` ``（鍵盤左上角，數字 1 左邊那個按鍵），或從選單 **View → Terminal** 打開內建終端機。

後面所有指令都在這裡輸入。

---

### 任務 1：Clone 組長的 Fork

你的組長已經 fork 了一份專案到自己的 GitHub 帳號，你要把它下載到你的電腦。

```bash
git clone https://github.com/<組長帳號>/project-1151-1.git
```

> 把 `<組長帳號>` 換成組長的 GitHub 帳號名稱。組長會把網址寫在白板上或傳到群組裡。

Clone 完成後，進入專案資料夾：

```bash
cd project-1151-1
```

然後在 VS Code 開啟這個資料夾：**File → Open Folder**，選擇剛才 clone 下來的 `project-1151-1` 資料夾。

**【發生了什麼】**

`git clone` 把 GitHub 上的整個專案（包含所有歷史紀錄）下載到你的電腦。從現在起，你的電腦上有一份完整的複本，可以離線操作。

> **注意**：請確認你 clone 的是**組長 fork 的網址**，不是講師上游的原始 repo。如果搞錯了，你後面發的 PR 會跑到錯誤的地方。

---

### 任務 2：建立你自己的 Branch

在修改檔案之前，先建立一條屬於你的 branch（分支）。

```bash
git checkout -b feat/你的名字
```

例如你叫 Alice，就輸入：

```bash
git checkout -b feat/alice
```

**【發生了什麼】**

Branch 就像是**平行時空**。你在自己的 branch 上做的修改不會影響到 `main`（主線），也不會和其他人的修改打架。等你做完、確認沒問題，再合併回去。

這就是 Git 最強大的功能之一：**每個人可以同時開發，互不干擾**。

> **注意**：如果你的電腦預設主分支叫 `master` 而不是 `main`，請先執行以下指令將預設改為 `main`：
>
> ```bash
> git config --global init.defaultBranch main
> ```

---

## 第二階段：製作你的卡片（CLI 指令）

### 任務 3：建立你的個人卡片檔

**【操作步驟】**

1. 在 VS Code 的左側檔案列表中，展開 `data/members/` 資料夾
2. 對 `_template.md` 按右鍵 → **Copy**
3. 在 `members/` 資料夾上按右鍵 → **Paste**
4. 把檔名改成你的英文名字，例如 `alice.md`（**全小寫**，不要留底線開頭）
5. 打開這個檔案，填入你的資料

**命名規則：**
- 全部小寫英文
- 可用連字號 `-` 分隔，例如 `wang-ming.md`
- 不可以用中文、空格或大寫

**【修改後的範例】**

```markdown
# Alice Chen

## Emoji

🚀

## Department

資訊工程學系三年級

## Bio

熱愛開源的全端工程師，夢想是做出改變世界的產品

## Interests

- Web 開發
- 開源貢獻
- 咖啡拉花

## GitHub

alice-chen
```

> **注意**：不要修改 `##` 標題本身的文字（例如 `## Emoji`、`## Bio`），只改標題下方的內容。這些標題是系統用來辨識欄位的關鍵字。

---

### 任務 4：把修改存成一個版本（Commit）

你剛剛新增了一個檔案，但 Git 還不知道要追蹤它。我們需要兩個步驟：先**加入暫存區**，再**提交版本**。

**Step 1：加入暫存區（Stage）**

```bash
git add data/members/alice.md
```

> 把 `alice.md` 換成你自己的檔名。

**Step 2：提交版本（Commit）**

```bash
git commit -m "feat: add Alice's profile card"
```

> 把 `Alice` 換成你自己的名字。

**【發生了什麼】**

想像一下：`git add` 是把你要存檔的東西放到「待存清單」裡，`git commit` 則是按下「存檔」按鈕，並附上一段備忘錄。

這個備忘錄就是 **commit message**。好的 commit message 要能讓別人不看程式碼就知道你做了什麼。

**Commit Message 小知識：**

我們採用 [Conventional Commits](https://www.conventionalcommits.org/zh-hant/v1.0.0/) 格式：

```
<類型>: <描述>
```

- `feat`: 新增內容（例如新增卡片）
- `fix`: 修正錯誤
- `docs`: 修改文件

例如：`feat: add Alice's profile card`

---

### 任務 5：把 Commit 推上 GitHub

你的 commit 目前只存在你的電腦上。要讓組長看到，必須把它**推送（push）**到 GitHub。

```bash
git push origin feat/alice
```

> 把 `feat/alice` 換成你在任務 2 建立的 branch 名稱。

如果 Git 問你帳號密碼，依照畫面提示登入你的 GitHub 帳號。

**【發生了什麼】**

`git push` 把你本機的 branch 和上面的 commit 上傳到 GitHub 的伺服器。`origin` 是 GitHub 遠端 repo 的代稱（clone 的時候自動設定的）。

推上去之後，你在 GitHub 頁面上就能看到你的 branch 和修改了。

---

## 第三階段：Pull Request 與合併

### 任務 6：在 GitHub 發送 Pull Request

Push 之後，你需要正式向組長提出「請合併我的修改」的請求——這就是 **Pull Request**（簡稱 PR）。

**【什麼是 Pull Request？】**

PR 就是在說：「我改好了，請幫我看一下，沒問題的話就合併到 main 吧。」它不只是一個合併按鈕，更是一個**程式碼審查（Code Review）**的流程：組長可以看你改了什麼、留言提問、要求修改。

在業界，幾乎所有的程式碼修改都要經過 PR + Review 才能進入主線。

**【GitHub 網頁操作】**

1. 打開組長 fork 的 GitHub 頁面
2. 你應該會看到上方出現一條黃色提示：`feat/alice had recent pushes — Compare & pull request`
3. 點擊 **Compare & pull request**
4. 確認：
   - **base** 是 `main`（合併目標）
   - **compare** 是你的 branch（你的修改）
5. 填寫 PR 標題（例如 `feat: add Alice's profile card`）
6. 根據檢查清單確認每一項
7. 按 **Create pull request**

> **注意**：如果看不到黃色提示，點 **Pull requests** 分頁 → **New pull request** → 手動選擇你的 branch。

**【發生了什麼】**

你發出了一個正式的合併請求。組長會收到通知，可以在 GitHub 上看到你改了哪些檔案、新增了哪些內容，確認沒問題後按下 Merge。

---

### 任務 7：組長 Review 和 Merge

> 這個步驟由**組長**操作，其他組員可以在旁邊觀察。

1. 組長在 GitHub 的 **Pull requests** 分頁，打開組員的 PR
2. 查看 **Files changed** 確認修改內容沒問題
3. 點 **Merge pull request** → **Confirm merge**

合併完成後，如果組長的 fork 有啟用 GitHub Pages，重新整理網頁就能看到卡片出現了！

> **注意**：PR 被合併不代表你的修改出現在講師的上游 repo。這只是合併到組長的 fork。最後會由組長統一向上游發 PR。

---

## 第四階段：VS Code 圖形化介面

> 「剛才那些指令，其實用 VS Code 點幾下滑鼠就能完成。」

### 任務 8：用 Source Control 面板操作 Git

VS Code 左側有一個像 Y 字分叉的圖示（或按 `Ctrl+Shift+G`），那就是 **Source Control** 面板。

**【用圖形介面做 commit + push】**

假設你現在要修改卡片的某個欄位：

1. 修改完檔案後，Source Control 面板會顯示有修改的檔案
2. 把滑鼠移到檔案上，點 **+**（加號）→ 等同於 `git add`
3. 在上方的輸入框打 commit message，例如 `feat: update bio`
4. 按 **Commit** 按鈕 → 等同於 `git commit`
5. 按旁邊的 **...** 選 **Push** → 等同於 `git push`

**【CLI vs. 圖形介面 對照】**

| 你想做的事 | CLI 指令 | VS Code 操作 |
|-----------|----------|-------------|
| 加入暫存區 | `git add <檔案>` | Source Control 面板點 **+** |
| 提交版本 | `git commit -m "訊息"` | 寫訊息後按 **Commit** |
| 推送到 GitHub | `git push` | 點 **...** → **Push** |
| 看修改了什麼 | `git status` / `git diff` | Source Control 面板直接看 |
| 切換 branch | `git checkout <branch>` | 左下角點 branch 名稱切換 |
| 建立新 branch | `git checkout -b <名稱>` | 左下角 → **Create new branch** |
| 拉取最新修改 | `git pull` | 點 **...** → **Pull** |

> 看！指令背後做的事情是一樣的，圖形介面只是把操作視覺化了。兩種方式都會用，就是最靈活的開發者。

---

### 任務 9：用 Git Graph 看分支圖

Git Graph 是一個 VS Code 擴充功能，可以把 Git 的歷史紀錄用**樹狀圖**畫出來。

1. 如果你還沒安裝，在 VS Code 左側點擊 **Extensions**（方塊圖示）搜尋 `Git Graph` 並安裝
2. 安裝後，在 Source Control 面板上方會出現一個 **Git Graph** 的圖示按鈕，點擊打開
3. 你會看到一張像捷運路線圖的分支圖

**【你可以觀察到什麼】**

- 每個圓點是一個 commit
- 不同顏色的線代表不同的 branch
- 可以看到誰從哪裡切出 branch、在哪裡合併回來
- 合併後的 commit 會有兩條線匯入

這就是 Git 版本控制的核心視覺呈現。你對著分支圖，就能清楚掌握每個人的工作進度和修改歷史。

---

## 第五階段：提交到上游

### 任務 10：組長向上游發送 Pull Request

> 這個步驟由**組長**操作。

所有組員的修改都合併到組長 fork 的 `main` 之後，組長要把成果送到講師的上游 repository。

1. 打開組長自己的 fork GitHub 頁面
2. 點擊 **Contribute** → **Open pull request**
3. 確認：
   - base repository: `<講師帳號>/project-1151-1`，branch: `main`
   - head repository: `<你的帳號>/project-1151-1`，branch: `main`
4. 填寫標題和說明
5. 按 **Create pull request**

**【發生了什麼】**

組長代表你們整組，向講師的上游 repo 發出合併請求。講師會在投影幕上一組一組 merge，每合併一組就重新整理網頁——你會看到卡片牆上多出了你們整組的卡片！

---

### 回顧今天學到的東西

恭喜你完成了一次完整的 Git 協作流程！讓我們回顧一下今天經歷的步驟：

```
clone → branch → 編輯檔案 → add → commit → push → PR → review → merge
```

這不只是今天的練習流程，也是業界每天在用的**標準協作流程**。無論你以後是做軟體開發、寫論文、做專案，Git 都是團隊協作最重要的基礎工具。

---

## 補充：組長操作指南

如果你是組長，除了上面的學員流程，你還需要做以下事情：

### 1. Fork 上游 Repository

1. 打開講師的 repository 頁面
2. 點右上角 **Fork** → **Create fork**

### 2. 啟用 GitHub Actions

> **這一步很重要！** Fork 後 Actions 預設是關閉的。

1. 在你 fork 的 repo 中，點擊上方的 **Actions** 分頁
2. 你會看到一個提示，點擊綠色按鈕同意啟用

如果漏掉這一步，合併後網頁不會自動更新。

### 3. 啟用 GitHub Pages

1. 進入 fork 的 **Settings → Pages**
2. Source 選擇 **GitHub Actions**

### 4. 加入組員為 Collaborator

1. 進入 fork 的 **Settings → Collaborators**
2. 點 **Add people**，輸入組員的 GitHub 帳號，逐一邀請
3. 組員收到邀請後需要**接受**才能 push

### 5. Review 和 Merge 組員的 PR

1. 打開 **Pull requests** 分頁
2. 逐一打開組員的 PR
3. 查看 **Files changed** 確認內容
4. 點 **Merge pull request** → **Confirm merge**

> **注意**：請確認組員的 PR 是發到**你 fork 的 repo**，不是講師的上游 repo。否則卡片不會出現在你的 fork 網頁上。

### 6. 填寫小組資料

在所有組員的卡片合併後，組長需要編輯 `data/teams/team-<代號>/team.md`：

```markdown
# Team A

## Team Name

你們的組名

## Members

- alice
- bob
- carol
```

`## Members` 底下列出所有組員的**檔案名稱**（不含 `.md`），一行一個。

### 7. 向上游發 PR

所有修改完成後，從你的 fork 向講師的上游 repo 發 Pull Request（見任務 10）。
