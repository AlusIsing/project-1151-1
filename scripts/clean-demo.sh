#!/usr/bin/env bash
source "$(dirname "$0")/lib.sh"

removed_members=0
removed_photos=0
removed_teams=0

members_dir="$DATA_DIR/members"
if [ -d "$members_dir" ]; then
  for f in "$members_dir"/*.md; do
    [ -f "$f" ] || continue
    name=$(basename "$f")
    [[ "$name" == _* ]] && continue
    rm "$f"
    removed_members=$((removed_members + 1))
  done
fi

photos_dir="$members_dir/photos"
if [ -d "$photos_dir" ]; then
  for f in "$photos_dir"/*; do
    [ -f "$f" ] || continue
    name=$(basename "$f")
    [ "$name" = ".gitkeep" ] && continue
    rm "$f"
    removed_photos=$((removed_photos + 1))
  done
fi

teams_dir="$DATA_DIR/teams"
if [ -d "$teams_dir" ]; then
  for d in "$teams_dir"/*/; do
    [ -d "$d" ] || continue
    name=$(basename "$d")
    [[ "$name" == _* ]] && continue
    rm -rf "$d"
    removed_teams=$((removed_teams + 1))
  done
fi

if [ -d "$DIST_DIR" ]; then
  rm -rf "$DIST_DIR"
fi

echo ""
echo "=== 清除測試資料完成 ==="
echo ""
echo "  刪除成員卡片：${removed_members} 個"
echo "  刪除頭像圖片：${removed_photos} 個"
echo "  刪除小組資料夾：${removed_teams} 個"
echo "  刪除建置輸出：dist/"
echo ""
echo "專案已恢復為乾淨狀態（僅保留 _template 範本檔）。"
echo ""
