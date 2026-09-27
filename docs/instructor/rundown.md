# 講師流程表（Run of Show）

總時長：50 分鐘

---

## 課前準備（上課前完成）

> ⚠ **以下步驟的順序不可顛倒。** 若組長在小組資料夾建立之前就 fork，他們的 fork 裡不會有自己的小組資料夾，現場會很混亂。

### 1. 建立小組

1. 預估到場人數，決定組數（每組 3 至 4 人）
2. 在終端機執行：
   ```bash
   node scripts/init-teams.mjs <組數>
   ```
3. 確認輸出正確，commit 並 push：
   ```bash
   git add data/teams/
   git commit -m "feat: initialize teams"
   git push origin main
   ```
4. 到 GitHub repository 的 **Actions** 分頁，確認 workflow 跑完（約 30 秒）
5. 打開 GitHub Pages 網頁，確認出現正確數量的「⏳ 等待提交」區塊

### 2. 設定 Branch Protection（建議）

到 repository 的 Settings → Rules → Rulesets，新增一條 Ruleset：

- Target: `main` branch
- 勾選 **Require a pull request before merging**

這可以防止學員（或組長）直接 push 到 `main`，強制走 PR 流程。

> 注意：Fork 後 Rulesets 不會自動繼承。如果組長也需要保護 `main`，需要在各自的 fork 裡設定。可以根據現場時間決定是否要求組長做這步。

### 3. 課前檢查清單

- [ ] 投影幕可正常顯示 GitHub Pages 網頁
- [ ] 講師電腦上已 clone 上游 repository
- [ ] `node scripts/build.mjs` 可正常執行
- [ ] 已準備好小組代號分配清單
- [ ] 已確認哪些學員適合當組長（有基礎者優先）
- [ ] 已先決定好最終成品的展示網頁（用來開場展示）

---

## 0:00–0:05（5 分鐘）開場與環境確認

**目標：** 讓所有人知道今天要做什麼、看到最終成品、確認工具就緒。

**講師要做的事：**

1. **先展示最終成品**
   - 投影一個已完成的卡片牆（可用事先準備的 demo 頁面，或本機跑 `node scripts/build.mjs` 後打開 `dist/index.html`）
   - 台詞：「今天結束的時候，你們每個人都會有一張這樣的個人卡片出現在這個網頁上。」
   - 讓大家看到 emoji、名字、自我介紹、興趣標籤——產生動力

2. **快速確認課前準備**
   - 「已經裝好 Git 的舉手？VS Code？Node.js？GitHub 帳號？」
   - 沒完成的人，請旁邊同學協助或先看 [課前準備指南](../pre-setup.md)

3. **公布組別**
   - 宣布組別代號（Team A、Team B、...）
   - 指定各組組長（挑有基礎的人）
   - 組員記下自己的 GitHub username，等一下組長要用

**投影畫面：** 卡片牆成品 demo

**預期會卡住的地方：**
- 有人沒裝好 → 讓他們一邊裝一邊聽，裝完後跟同組的人補進度
- 有人沒註冊 GitHub → 現場快速註冊（提醒：username 要記住）

---

## 0:05–0:10（5 分鐘）組長設定 Fork

**目標：** 所有組長完成 fork 並設定好協作環境。

**講師要做的事：**

投影幕上示範 fork 流程，指導組長依序完成：

1. **Fork** 上游 repository
2. **進入 fork 的 Actions 頁面**，點擊綠色按鈕「I understand my workflows, go ahead and enable them」同意啟用
   > ⚠ 這一步非常容易遺漏！沒做的話 Actions 不會觸發，後面 GitHub Pages 不會更新。請大聲提醒。
3. **Settings → Pages** → Source 選 **GitHub Actions**
4. **Settings → Collaborators** → 把組員的 GitHub username 加入

把每位組長的 fork URL 寫在白板或公用頻道上，確保組員拿到正確的 URL。

**投影畫面：** fork 流程操作示範

**講師台詞（關鍵提醒）：**
- 「Fork 完之後，第一件事是去 Actions 頁面按綠色按鈕，不然後面的自動部署不會動。」
- 「GitHub Pages 是每個 repository 各自獨立的，跟帳號無關，所以你的 fork 也會有自己的網頁。」

**預期會卡住的地方：**
- Collaborator 邀請需要組員 username → 請組員到 GitHub 個人頁面確認
- 找不到 Pages 設定 → 引導到 Settings → 左側欄 Pages
- Actions 頁面沒有綠色按鈕 → 可能已經啟用了，確認 Actions 分頁裡有 workflow 列表即可

---

## 0:10–0:25（15 分鐘）核心流程：製作你的卡片

**目標：** 每位學員完成 clone → branch → edit → add → commit → push → PR 的完整流程，使用 CLI 指令。

**講師要做的事：**

投影幕上**逐步示範**，每一步先解釋「這是在做什麼」，再敲指令。

### Step 1：Clone（2 分鐘）

```bash
git clone https://github.com/<組長帳號>/project-1151-1.git
cd project-1151-1
```

台詞：「`git clone` 是把 GitHub 上的專案完整複製一份到你的電腦。現在你的電腦裡有一份跟組長 fork 一模一樣的專案。」

> ⚠ 提醒學員：URL 要用**組長 fork** 的，不是上游原始 repo 的！

### Step 2：建立 Branch（1 分鐘）

```bash
git checkout -b feat/<你的英文名>
```

台詞：「在改任何東西之前，先開一條自己的分支。這就像是在平行宇宙裡做事——你的修改不會影響到別人，也不會被別人影響。」

### Step 3：製作你的卡片（5 分鐘）

1. 用 VS Code 打開專案：`code .`（或從 VS Code 選 File → Open Folder）
2. 複製 `data/members/_template.md`，改名為 `<你的英文名>.md`
   - **在 VS Code 側邊欄**：右鍵 `_template.md` → Copy → 右鍵 `members/` 資料夾 → Paste → 輸入新檔名
   - **或用 CLI**：
     ```bash
     cp data/members/_template.md data/members/<你的英文名>.md
     ```
3. 打開這個檔案，把所有 TODO 改成你自己的資料
4. 注意：不要動 `#` 和 `##` 標題的文字，只改標題底下的內容

> 留 3-4 分鐘讓大家自由發揮，填寫 emoji、自我介紹、興趣等。這是最有趣的環節，不要催太急。

### Step 4：Add + Commit（2 分鐘）

```bash
git add data/members/<你的英文名>.md
git status
git commit -m "feat: add <你的名字>'s profile card"
```

台詞：
- 「`git add` 是告訴 Git：這個檔案我要放進下一次的存檔點。」
- 「`git status` 讓你確認哪些檔案被選中了。」
- 「`git commit` 就是存檔。`-m` 後面的訊息是給未來的你（和隊友）看的——說清楚你做了什麼。」
- 順便簡介 Conventional Commits：`feat:` 表示新功能，`fix:` 表示修正錯誤。

### Step 5：Push（1 分鐘）

```bash
git push origin feat/<你的英文名>
```

台詞：「`push` 是把你電腦裡的存檔同步上傳到 GitHub。在這之前，你的 commit 只存在你自己的電腦上。」

### Step 6：發 PR（2 分鐘）

1. 打開組長 fork 的 GitHub 頁面
2. 會看到黃色提示條：「`feat/xxx` had recent pushes — Compare & pull request」
3. 點擊 **Compare & pull request**
4. **確認 base 是組長 fork 的 `main`**（不是上游 repo！）
5. 填寫標題，按 **Create pull request**

台詞：「Pull Request 是在跟組長說：我的東西做好了，請你看一下再合併。這就是團隊協作的核心——改東西之前先讓人看過。」

> ⚠ 提醒：base repository 要選**組長自己的 fork**，不是上游。如果選錯會 PR 到上游。

**投影畫面：** 依序展示每一步的 CLI 輸出和 GitHub 網頁操作

**預期會卡住的地方：**
- Clone URL 打錯 → 確認是組長 fork 的 URL
- 忘記 `cd project-1151-1` → 提醒 clone 後要進入資料夾
- Branch 名稱打錯 → 用 `git branch` 確認現在在哪個 branch
- Commit 之後忘記 Push → 提醒 commit 只存本機
- PR 的 base repository 選錯 → 確認是組長 fork 而不是上游

**里程碑：** 每位學員都成功發出至少一個 PR。巡視教室確認。

**進度追蹤：** 在白板或共享文件上記錄每位學員的狀態（✓ 表示已發 PR）。

---

## 0:25–0:35（10 分鐘）合併與 VS Code GUI

**目標：** 組長練習 merge PR；所有人體驗 VS Code 圖形化 Git 介面。

### 前半：組長 Merge（5 分鐘）

**講師要做的事：**
- 投影示範如何在 GitHub 上 review 和 merge PR
  - 看 diff（「你可以看到每一行的修改」）
  - 按 **Merge pull request** → **Confirm merge**
- 指導組長把所有組員的 PR merge 完
- 組長編輯 `data/teams/team-<代號>/team.md`，填入組名和 Members 清單，commit 並 push 到 main

### 後半：VS Code GUI 體驗（5 分鐘）

**講師要做的事：**

台詞：「剛剛我們全部都用指令操作。現在讓大家看看 VS Code 的圖形化介面——同樣的事情，點點滑鼠就能做到。」

1. **Source Control 面板**（Ctrl+Shift+G / ⌘⇧G）
   - 示範：修改一個檔案後，面板會自動顯示變更
   - 點 `+` 就是 `git add`
   - 輸入訊息按 ✓ 就是 `git commit`
   - 點 ··· 選 Push 就是 `git push`

2. **Git Graph 擴充套件**（如果已安裝）
   - 示範：打開 Git Graph 面板
   - 「你可以看到每個人從哪裡切出分支、做了哪些 commit、怎麼 merge 回 main」
   - 「不同顏色的線代表不同的 branch」

3. **看隱藏資料夾 `.git`**
   - Windows：檔案總管 → 檢視 → 顯示 → 隱藏的項目
   - macOS：Finder 中按 ⌘⇧.（Cmd+Shift+.）
   - 台詞：「Git 的所有歷史紀錄都存在這個 `.git` 資料夾裡。只要這個資料夾在，你所有的 commit 都不會消失。」

**投影畫面：** VS Code Source Control 面板 + Git Graph

**預期會卡住的地方：**
- 組長 merge 時出現衝突 → 如果有時間可以趁機教一下，沒時間就講師協助快速解決
- Git Graph 沒裝 → 不影響核心體驗，跳過

---

## 0:35–0:45（10 分鐘）提交到上游 + 見證成果

**目標：** 每組組長把成果 PR 到上游，投影幕上看到卡片一張一張出現。

> **這是全場的高潮時刻。**

**講師要做的事：**

1. 請各組組長確認 fork 的 `main` 上所有修改已完成（team.md 已填好、組員 PR 都 merge 了）
2. 組長從 fork 發 PR 到上游 `main`
   - 在組長 fork 的頁面按 **Contribute** → **Open pull request**
   - **確認 base repository 是上游 repo，不是自己的 fork**
3. 講師在投影幕上**逐組 merge**，每 merge 一組就 reload 網頁
   - 卡片會一張一張出現——統計數字變化、進度條增長
   - 從「⏳ 等待提交」變成完整的卡片牆

**講師台詞：**
- 「看！Team A 的卡片出現了。進度從 0 / 4 變成 1 / 4 了。」
- （全部 merge 完）「🎉 全部收集完成！每個人的卡片都在上面了。」

**投影畫面：** GitHub Pages 網頁（持續 reload）

**預期會卡住的地方：**
- 組長 PR 有衝突（不太可能但有可能） → 講師協助解決
- GitHub Actions 沒有觸發 → 先確認 Actions 頁面有沒有啟用；如果已啟用但沒跑，可以到 Actions 頁面手動點 **Run workflow**（因為已加入 `workflow_dispatch`），或推一個空 commit：
  ```bash
  git commit --allow-empty -m "trigger deploy"
  git push origin main
  ```
- Pages 更新延遲 → 等待 30 秒再 reload，或先 merge 下一組

---

## 0:45–0:50（5 分鐘）收尾與回顧

**目標：** 帶大家回顧今天學了什麼，給後續學習方向。

**講師要做的事：**

1. **展示最終成品**：所有卡片都出現了！
2. **回顧今天的流程**，在投影幕上列出：
   ```
   clone → branch → 編輯卡片 → add → commit → push → PR → review → merge
   ```
3. **重點概念回顧**：
   - **Branch**：平行宇宙，互不影響
   - **Commit**：存檔點，可以隨時回去
   - **PR**：請別人 review 你的修改
   - **Merge**：把兩個分支的修改合在一起
4. **推薦後續學習資源**：
   - [Git 官方文件](https://git-scm.com/doc)
   - [GitHub Skills](https://skills.github.com/)
   - [Conventional Commits](https://www.conventionalcommits.org/zh-hant/v1.0.0/)
5. 感謝大家參與

---

## 緊急備案

### 網路斷線

- `node scripts/build.mjs` 不需要網路，可以離線建置
- 講師本機 build 後直接展示 `dist/index.html`
- Push / PR / merge 等操作暫停，等網路恢復

### GitHub Pages 沒有更新

1. 到 repository 的 **Actions** 分頁確認 workflow 有沒有在跑
2. 如果 Actions 頁面沒有任何 workflow → 沒有啟用 Actions，點綠色按鈕啟用
3. 如果 workflow 失敗 → 看 log 找原因
4. 嘗試手動觸發：Actions 頁面 → 選 Deploy to GitHub Pages → Run workflow
5. 推送空 commit 觸發：`git commit --allow-empty -m "trigger deploy" && git push`
6. 備案：講師本機 build 後直接展示

### GitHub Actions 沒有觸發

最常見原因：Fork 之後沒有到 Actions 頁面同意條款。

解決方式：
1. 到 fork 的 Actions 頁面，同意啟用
2. 重新 push 到 main（或推空 commit），觸發 workflow

### 學員電腦出問題

- 找同組已經完成的人幫忙看
- 最壞情況：兩人共用一台電腦，輪流操作
- 如果是 Git 沒裝好：讓他們先跟著看，課後再補

### 學員 PR 到錯誤的 Repo

- 如果 PR 到了上游而不是組長的 fork → 在 GitHub 上關閉那個 PR，重新發到正確的 repo
- 預防：每次提到 PR 都要強調「**發到組長的 fork**」

---

## 進度追蹤建議

在白板或共享文件上追蹤每組的進度：

```
Team A: [Alice ✓] [Bob ✓] [Carol ○] → 組長 merge ○ → 上游 PR ○
Team B: [Dave ✓] [Eve ○] [Frank ○] → 組長 merge ○ → 上游 PR ○
```

每完成一步就更新，讓大家知道自己的進度，也讓講師知道誰卡住了。
