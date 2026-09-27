# 模擬衝突的教學劇本（選用）

> **本腳本為選用進階練習**，需要額外 15–20 分鐘。50 分鐘的核心 Workshop 不包含此環節。
> 如果時間充裕（例如安排 70 分鐘以上的場次），可以在核心流程結束後加入此練習。

本腳本刻意讓學員在同一個檔案的相同位置做出不同的修改，藉此製造 Git 衝突，讓他們體驗衝突解決的完整流程。

---

## 事前準備：擴充 team.md

由於目前的 `team.md` 只有 `## Team Name` 和 `## Members` 兩個區段，不足以讓多人分頭修改不同區段。

講師需要先在目標小組的 `team.md` 中加入 `## Slogan` 和 `## Introduction` 區段：

```markdown
# Team A

## Team Name

超級程式戰隊

## Slogan

我們的口號在這裡

## Introduction

我們是一群熱愛程式的學生

## Members

- alice
- bob
- carol
```

確認修改已 commit 並 push 到該組長 fork 的 `main`。

---

## 角色分配

| 角色 | 負責修改的區段 | 目的 |
|------|--------------|------|
| 角色 1 | `## Slogan` | 與角色 2 衝突（同一個區段） |
| 角色 2 | `## Slogan` | 與角色 1 衝突（同一個區段） |
| 角色 3 | `## Team Name` | 不同區段，Git 自動合併 |
| 角色 4 | `## Introduction` | 不同區段，Git 自動合併 |

### 三人組的處理方式

省略角色 4。由角色 3 同時修改 `## Team Name` 和 `## Introduction`。衝突仍然發生在角色 1 與角色 2 之間，核心體驗不受影響。

---

## 執行步驟

### Step 1：所有人同步到最新狀態

請所有角色在 VS Code 終端機中執行（Ctrl+` 開啟終端機）：

```bash
git checkout main
git pull origin main
```

確認所有人的 `team.md` 內容一致。

### Step 2：所有人同時建立新 branch

```bash
# 角色 1
git checkout -b feat/slogan-v1

# 角色 2
git checkout -b feat/slogan-v2

# 角色 3
git checkout -b feat/team-name

# 角色 4（四人組才有）
git checkout -b feat/intro
```

### Step 3：分頭修改

**講師宣讀以下指令：**

> **角色 1：** 打開 `team.md`，把 `## Slogan` 底下的內容改成你想到的第一句口號，然後 commit 並 push。

> **角色 2：** 打開 `team.md`，把 `## Slogan` 底下的內容改成**不一樣的**口號，然後 commit 並 push。

> **角色 3：** 打開 `team.md`，把 `## Team Name` 底下的內容改成新的組名，然後 commit 並 push。

> **角色 4：** 打開 `team.md`，把 `## Introduction` 底下的內容改成新的小組介紹，然後 commit 並 push。

每位角色的 commit + push 流程：

```bash
git add data/teams/team-<代號>/team.md
git commit -m "feat: update <區段名>"
git push origin feat/<branch 名稱>
```

然後到 GitHub 發 PR 給組長。

### Step 4：依序合併，製造衝突

請組長按照以下順序在 GitHub 上操作：

1. **先 merge 角色 1 的 PR** → 順利合併
2. **再 merge 角色 3 的 PR** → 順利合併（不同區段，Git 自動處理）
3. **再 merge 角色 4 的 PR**（如果有）→ 順利合併
4. **最後 merge 角色 2 的 PR** → **衝突！** GitHub 會顯示「This branch has conflicts that must be resolved」

> 講師在此暫停，引導全場觀察。

### Step 5：教學時刻

**講師台詞（建議）：**

「大家看到了嗎？角色 3 改了 Team Name、角色 4 改了 Introduction，跟角色 1 改的 Slogan 是不同區段——Git 看得出它們互不干擾，所以自動合併成功了。

但是角色 1 和角色 2 都改了 Slogan——Git 不知道該保留哪一句。這不是 Git 的 bug，而是 Git 的設計。**Git 能處理技術上的合併，但不能替團隊做產品決策。** 到底要用哪句口號？只有你們自己能決定。」

### Step 6：在 VS Code 中解決衝突

由角色 2（或組長）操作：

1. 確保在 `main` branch 上，並 pull 最新的修改：
   ```bash
   git checkout main
   git pull origin main
   git checkout feat/slogan-v2
   git merge main
   ```
2. VS Code 會在衝突的檔案中顯示標記，並在每個衝突區段上方提供按鈕：
   - **Accept Current Change**：保留你的版本（角色 2 的口號）
   - **Accept Incoming Change**：保留對方的版本（角色 1 的口號）
   - **Accept Both Changes**：兩邊都保留
   - **手動編輯**：直接在檔案中改成想要的最終版本
3. 跟隊友討論後，選擇或編輯出最終版本
4. 存檔後：
   ```bash
   git add data/teams/team-<代號>/team.md
   git commit -m "fix: resolve slogan merge conflict"
   git push origin feat/slogan-v2
   ```
5. 回到 GitHub，角色 2 的 PR 現在可以順利 merge 了

---

## 衝突解決後的驗證

```bash
node scripts/validate.mjs
```

確認沒有殘留衝突標記（`<<<<<<<`、`=======`、`>>>>>>>`）。學員把衝突標記直接 commit 上去是最常見的問題。

---

## 角色指令卡

以下內容可直接列印或投影，發給每位學員。

---

### 角色 1 指令卡

```
你的任務：修改 Slogan

1. 確認你在 main branch 上，執行 git pull origin main
2. 建立新 branch：git checkout -b feat/slogan-v1
3. 用 VS Code 打開 data/teams/team-<代號>/team.md
4. 把「## Slogan」底下的內容改成你想到的一句口號
5. git add + git commit -m "feat: update slogan"
6. git push origin feat/slogan-v1
7. 到 GitHub 發 PR 給組長
```

---

### 角色 2 指令卡

```
你的任務：修改 Slogan（會跟角色 1 衝突！）

1. 確認你在 main branch 上，執行 git pull origin main
2. 建立新 branch：git checkout -b feat/slogan-v2
3. 用 VS Code 打開 data/teams/team-<代號>/team.md
4. 把「## Slogan」底下的內容改成【不一樣的】一句口號
5. git add + git commit -m "feat: update slogan"
6. git push origin feat/slogan-v2
7. 到 GitHub 發 PR 給組長
8. ⚠ 你的 PR 會有衝突——這是故意的！等講師指示再處理。
```

---

### 角色 3 指令卡

```
你的任務：修改 Team Name

1. 確認你在 main branch 上，執行 git pull origin main
2. 建立新 branch：git checkout -b feat/team-name
3. 用 VS Code 打開 data/teams/team-<代號>/team.md
4. 把「## Team Name」底下的內容改成新的組名
5. git add + git commit -m "feat: update team name"
6. git push origin feat/team-name
7. 到 GitHub 發 PR 給組長
```

---

### 角色 4 指令卡（四人組專用）

```
你的任務：修改 Introduction

1. 確認你在 main branch 上，執行 git pull origin main
2. 建立新 branch：git checkout -b feat/intro
3. 用 VS Code 打開 data/teams/team-<代號>/team.md
4. 把「## Introduction」底下的內容改成新的小組介紹
5. git add + git commit -m "feat: update introduction"
6. git push origin feat/intro
7. 到 GitHub 發 PR 給組長
```
