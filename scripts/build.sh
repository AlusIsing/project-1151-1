#!/usr/bin/env bash
source "$(dirname "$0")/lib.sh"

find_member_photo() {
  local member="$1"
  local photos_dir="$DATA_DIR/members/photos"
  for ext in $IMAGE_EXTS; do
    if [ -f "$photos_dir/${member}.${ext}" ]; then
      echo "${member}.${ext}"
      return
    fi
  done
}

build_member_card() {
  local member_name="$1" delay="$2"
  local member_file="$DATA_DIR/members/${member_name}.md"
  local hue
  hue=$(name_to_hue "$member_name")

  if [ ! -f "$member_file" ]; then
    printf '<article class="card card--error" style="--card-hue: %d; animation-delay: %ss">\n' "$hue" "$delay"
    printf '  <div class="card__avatar">⚠️</div>\n'
    printf '  <div class="card__body">\n'
    printf '    <h3 class="card__name">%s</h3>\n' "$(escape_html "$member_name")"
    printf '    <p class="card__error">⚠ 找不到 data/members/%s.md</p>\n' "$(escape_html "$member_name")"
    printf '  </div>\n'
    printf '</article>\n'
    return
  fi

  local title name raw_emoji dept bio github photo_file
  title=$(get_title "$member_file")
  name="${title:-$member_name}"
  raw_emoji=$(get_value "$member_file" "Emoji")
  dept=$(get_value "$member_file" "Department")
  bio=$(get_value "$member_file" "Bio")
  github=$(get_value "$member_file" "GitHub")
  photo_file=$(find_member_photo "$member_name")

  local emoji="🎯"
  if [ -n "$raw_emoji" ] && ! is_todo "$raw_emoji"; then
    emoji="$raw_emoji"
  fi

  printf '<article class="card" style="--card-hue: %d; animation-delay: %ss">\n' "$hue" "$delay"

  if [ -n "$photo_file" ]; then
    printf '  <div class="card__avatar card__avatar--has-photo">\n'
    printf '    <img class="card__photo" src="./photos/%s" alt="%s">\n' "$photo_file" "$(escape_html "$name")"
    printf '    <span class="card__emoji-badge">%s</span>\n' "$emoji"
    printf '  </div>\n'
  else
    printf '  <div class="card__avatar">%s</div>\n' "$emoji"
  fi

  printf '  <div class="card__body">\n'
  printf '    <h3 class="card__name">%s</h3>\n' "$(escape_html "$name")"

  if [ -n "$dept" ] && ! is_todo "$dept"; then
    printf '    <p class="card__dept">%s</p>\n' "$(escape_html "$dept")"
  fi

  if [ -n "$bio" ] && ! is_todo "$bio"; then
    printf '    <p class="card__bio">%s</p>\n' "$(escape_html "$bio")"
  fi

  local interests_raw
  interests_raw=$(get_value "$member_file" "Interests")
  if [ -n "$interests_raw" ] && ! is_todo "$interests_raw"; then
    local tags=""
    while IFS= read -r interest; do
      [ -z "$interest" ] && continue
      tags="${tags}<span class=\"card__tag\">$(escape_html "$interest")</span>"
    done < <(get_list "$member_file" "Interests")
    if [ -n "$tags" ]; then
      printf '    <div class="card__tags">%s</div>\n' "$tags"
    fi
  fi

  if [ -n "$github" ] && ! is_todo "$github"; then
    local gh
    gh=$(printf '%s' "$github" | tr -d '[:space:]')
    printf '    <a class="card__github" href="https://github.com/%s" target="_blank" rel="noopener">@%s</a>\n' "$gh" "$(escape_html "$gh")"
  fi

  printf '  </div>\n'
  printf '  <span class="card__watermark">GDG NTUST</span>\n'
  printf '</article>\n'
}

# --- Main ---

teams=()
while IFS= read -r line; do
  [ -n "$line" ] && teams+=("$line")
done < <(discover_teams)

content_file=$(mktemp)
teams_file=$(mktemp)
trap 'rm -f "$content_file" "$teams_file"' EXIT

if [ ${#teams[@]} -eq 0 ]; then
  cat > "$content_file" <<'EMPTY'

<div class="empty-state">
  <div class="empty-state__icon">👋</div>
  <h2>尚未建立任何小組</h2>
  <p>請講師執行以下指令來初始化小組：</p>
  <p>Windows：<code>scripts\init-teams &lt;組數&gt;</code></p>
  <p>macOS / Linux：<code>bash scripts/init-teams.sh &lt;組數&gt;</code></p>
  <p>例如 <code>5</code> 會建立 Team A 到 Team E。</p>
</div>
EMPTY
else
  member_offset=0
  total_teams=${#teams[@]}
  done_teams=0
  total_members=0

  for team_folder in "${teams[@]}"; do
    team_file="$DATA_DIR/teams/$team_folder/team.md"
    display=$(team_display_name "$team_folder")

    if [ ! -f "$team_file" ]; then
      cat >> "$teams_file" <<SECTION
<section class="team">
  <div class="team__header">
    <span class="team__code">$(escape_html "$display")</span>
    <span class="team__status--pending">⚠ 格式錯誤</span>
  </div>
  <div class="team__pending">
    <div class="team__pending-icon">⚠️</div>
    <p class="team__pending-text">無法讀取檔案</p>
  </div>
</section>
SECTION
      continue
    fi

    team_name=$(get_value "$team_file" "Team Name")
    members_raw=$(get_value "$team_file" "Members")
    member_list=()
    if [ -n "$members_raw" ] && ! is_todo "$members_raw"; then
      while IFS= read -r m; do
        [ -n "$m" ] && member_list+=("$m")
      done < <(get_list "$team_file" "Members")
    fi

    all_todo=false
    if is_todo "${team_name:-TODO}" && [ ${#member_list[@]} -eq 0 ]; then
      all_todo=true
    fi

    if $all_todo; then
      cat >> "$teams_file" <<SECTION
<section class="team">
  <div class="team__header">
    <span class="team__code">$(escape_html "$display")</span>
    <span class="team__status--pending">⏳ 等待提交</span>
  </div>
  <div class="team__pending">
    <div class="team__pending-icon">⏳</div>
    <p class="team__pending-text">等待小組提交卡片...</p>
  </div>
</section>
SECTION
    else
      done_teams=$((done_teams + 1))
      total_members=$((total_members + ${#member_list[@]}))

      display_name="$display"
      if [ -n "$team_name" ] && ! is_todo "$team_name"; then
        display_name="$team_name"
      fi

      printf '<section class="team">\n' >> "$teams_file"
      printf '  <div class="team__header">\n' >> "$teams_file"
      printf '    <h2 class="team__name">%s</h2>\n' "$(escape_html "$display_name")" >> "$teams_file"
      printf '    <span class="team__code">%s</span>\n' "$(escape_html "$display")" >> "$teams_file"
      printf '  </div>\n' >> "$teams_file"
      printf '  <div class="card-grid">\n' >> "$teams_file"

      for member in "${member_list[@]}"; do
        delay=$(awk -v n="$member_offset" 'BEGIN { printf "%.2f", n * 0.08 }')
        build_member_card "$member" "$delay" >> "$teams_file"
        member_offset=$((member_offset + 1))
      done

      printf '  </div>\n' >> "$teams_file"
      printf '</section>\n' >> "$teams_file"
    fi
  done

  # Build content: stats + team sections
  percent=0
  if [ "$total_teams" -gt 0 ]; then
    percent=$((done_teams * 100 / total_teams))
  fi

  hint_text="還有 $((total_teams - done_teams)) 組尚未提交"
  if [ "$done_teams" -ge "$total_teams" ]; then
    hint_text="🎉 全部收集完成！"
  fi

  {
    cat <<STATS

<div class="stats">
  <div class="stats__header">
    <span class="stats__title">📇 卡片收藏</span>
    <span class="stats__subtitle">收集中</span>
  </div>
  <div class="stats__grid">
    <div class="stats__cell">
      <span class="stats__number">${total_members}</span>
      <span class="stats__label">已收集</span>
    </div>
    <div class="stats__cell">
      <span class="stats__number">${done_teams} / ${total_teams}</span>
      <span class="stats__label">小組完成</span>
    </div>
  </div>
  <div class="stats__bar">
    <div class="stats__fill" style="width: ${percent}%"></div>
  </div>
  <p class="stats__hint">${hint_text}</p>
</div>
STATS
    cat "$teams_file"
  } > "$content_file"
fi

# Process template
build_time=$(TZ='Asia/Taipei' date '+%Y/%m/%d %H:%M:%S')

mkdir -p "$DIST_DIR"

while IFS= read -r line; do
  if [[ "$line" == *'<!-- TEAMS -->'* ]]; then
    cat "$content_file"
  elif [[ "$line" == *'<!-- BUILD_TIME -->'* ]]; then
    printf '%s\n' "${line/<!-- BUILD_TIME -->/$(escape_html "$build_time")}"
  else
    printf '%s\n' "$line"
  fi
done < "$SITE_DIR/template.html" > "$DIST_DIR/index.html"

cp "$SITE_DIR/style.css" "$DIST_DIR/style.css"

# Copy photos
photos_dir="$DATA_DIR/members/photos"
if [ -d "$photos_dir" ]; then
  photo_count=0
  for ext in $IMAGE_EXTS; do
    for f in "$photos_dir"/*."$ext"; do
      [ -f "$f" ] || continue
      mkdir -p "$DIST_DIR/photos"
      cp "$f" "$DIST_DIR/photos/"
      photo_count=$((photo_count + 1))
    done
  done
  if [ "$photo_count" -gt 0 ]; then
    echo "圖片：複製了 ${photo_count} 張"
  fi
fi

echo ""
echo "=== 建置完成 ==="
echo ""
echo "小組數：${#teams[@]}"
echo "輸出：dist/index.html"
echo "建置時間：${build_time}"
echo ""
