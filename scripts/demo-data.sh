#!/usr/bin/env bash
source "$(dirname "$0")/lib.sh"

write_avatar() {
  local id="$1" initial="$2" color="$3"
  cat > "$DATA_DIR/members/photos/${id}.svg" <<SVG
<svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" viewBox="0 0 400 400">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:${color};stop-opacity:1" />
      <stop offset="100%" style="stop-color:${color};stop-opacity:0.6" />
    </linearGradient>
  </defs>
  <rect width="400" height="400" fill="url(#bg)" />
  <text x="200" y="230" text-anchor="middle" fill="white" font-size="180" font-family="Arial, sans-serif" font-weight="bold">${initial}</text>
</svg>
SVG
  echo "  ✓ 建立頭像圖片：data/members/photos/${id}.svg"
}

echo ""
echo "=== 產生展示用測試資料 ==="
echo ""

mkdir -p "$DATA_DIR/members/photos"

# --- Members ---

cat > "$DATA_DIR/members/alice.md" <<'EOF'
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
EOF
echo "  ✓ 建立成員卡片：data/members/alice.md"
write_avatar alice A "#4285F4"

cat > "$DATA_DIR/members/bob.md" <<'EOF'
# Bob Wang

## Emoji

🎮

## Department

電機工程學系二年級

## Bio

白天焊電路，晚上寫程式，假日打電動

## Interests

- 嵌入式系統
- 遊戲開發
- 籃球

## GitHub

bob-wang
EOF
echo "  ✓ 建立成員卡片：data/members/bob.md"
write_avatar bob B "#EA4335"

cat > "$DATA_DIR/members/carol.md" <<'EOF'
# Carol Lin

## Emoji

🎨

## Department

設計學系四年級

## Bio

用設計思考解決問題，偶爾也會寫寫 code

## Interests

- UI/UX 設計
- 插畫
- 攝影

## GitHub

carol-lin
EOF
echo "  ✓ 建立成員卡片：data/members/carol.md"
write_avatar carol C "#34A853"

cat > "$DATA_DIR/members/dave.md" <<'EOF'
# Dave Liu

## Emoji

☕

## Department

資訊管理學系一年級

## Bio

剛開始學程式，每天都有新發現

## Interests

- Python
- 資料分析
- 咖啡

## GitHub

dave-liu
EOF
echo "  ✓ 建立成員卡片：data/members/dave.md"
write_avatar dave D "#FBBC04"

cat > "$DATA_DIR/members/eve.md" <<'EOF'
# Eve Zhang

## Emoji

🎵

## Department

應用外語學系三年級

## Bio

文組也能學寫程式！正在自學 JavaScript

## Interests

- 前端開發
- 翻譯
- 彈吉他

## GitHub

eve-zhang
EOF
echo "  ✓ 建立成員卡片：data/members/eve.md"
write_avatar eve E "#A142F4"

cat > "$DATA_DIR/members/frank.md" <<'EOF'
# Frank Wu

## Emoji

🔧

## Department

機械工程學系四年級

## Bio

機械系的斜槓仔，同時玩軟體和硬體

## Interests

- 3D 列印
- Arduino
- 機器人

## GitHub

frank-wu
EOF
echo "  ✓ 建立成員卡片：data/members/frank.md"
write_avatar frank F "#00ACC1"

cat > "$DATA_DIR/members/grace.md" <<'EOF'
# Grace Huang

## Emoji

🌟

## Department

數位媒體設計學系二年級

## Bio

創意是我的超能力，Figma 是我的武器

## Interests

- 動態設計
- Figma
- 追劇

## GitHub

grace-huang
EOF
echo "  ✓ 建立成員卡片：data/members/grace.md"
write_avatar grace G "#FF7043"

cat > "$DATA_DIR/members/henry.md" <<'EOF'
# Henry Tsai

## Emoji

🐧

## Department

資訊工程學系碩士班一年級

## Bio

Linux 愛好者，打不贏 bug 就加入它

## Interests

- Linux
- 雲端運算
- 開源社群

## GitHub

henry-tsai
EOF
echo "  ✓ 建立成員卡片：data/members/henry.md"
write_avatar henry H "#E91E8B"

# --- Teams ---

mkdir -p "$DATA_DIR/teams/team-a"
cat > "$DATA_DIR/teams/team-a/team.md" <<'EOF'
# Team A

## Team Name

超級程式戰隊

## Members

- alice
- bob
- carol
EOF
echo "  ✓ 建立小組資料：data/teams/team-a/team.md"

mkdir -p "$DATA_DIR/teams/team-b"
cat > "$DATA_DIR/teams/team-b/team.md" <<'EOF'
# Team B

## Team Name

深夜 Debug 組

## Members

- dave
- eve
- frank
EOF
echo "  ✓ 建立小組資料：data/teams/team-b/team.md"

mkdir -p "$DATA_DIR/teams/team-c"
cat > "$DATA_DIR/teams/team-c/team.md" <<'EOF'
# Team C

## Team Name

全端魔法師

## Members

- grace
- henry
EOF
echo "  ✓ 建立小組資料：data/teams/team-c/team.md"

echo ""
echo "共建立 8 位成員、3 個小組"
echo ""
echo "下一步："
echo "  scripts\\build                   # Windows"
echo "  bash scripts/build.sh           # macOS / Linux"
echo "  瀏覽器打開 dist/index.html      # 預覽成果"
echo ""
echo "完成展示後，執行以下指令清除測試資料："
echo "  scripts\\clean-demo              # Windows"
echo "  bash scripts/clean-demo.sh      # macOS / Linux"
echo ""
