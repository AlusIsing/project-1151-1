#!/usr/bin/env bash
source "$(dirname "$0")/lib.sh"

errors=()
warnings=()

checked_files=""

check_conflict_markers() {
  local file="$1"
  case "$checked_files" in
    *"|$file|"*) return ;;
  esac
  checked_files="${checked_files}|$file|"

  [ -f "$file" ] || return 0

  local matches
  matches=$(grep -nE '^(<{7} |={7}$|>{7} )' "$file" 2>/dev/null) || true
  if [ -n "$matches" ]; then
    while IFS= read -r match; do
      local linenum
      linenum=$(echo "$match" | cut -d: -f1)
      errors+=("$file 第 $linenum 行：殘留 Git 衝突標記，請先解決衝突再 commit")
    done <<< "$matches"
  fi
}

member_name_pattern='^[a-z][a-z0-9]*(-[a-z0-9]+)*$'

teams=()
while IFS= read -r line; do
  [ -n "$line" ] && teams+=("$line")
done < <(discover_teams)

referenced_members=""
assignments_file=$(mktemp)
trap 'rm -f "$assignments_file"' EXIT

for team_folder in "${teams[@]}"; do
  file="$DATA_DIR/teams/$team_folder/team.md"
  display=$(team_display_name "$team_folder")

  check_conflict_markers "$file"

  if [ ! -f "$file" ]; then
    errors+=("$file：無法讀取檔案")
    continue
  fi

  for sec in "Team Name" "Members"; do
    if ! get_section "$file" "$sec" | grep -q .; then
      errors+=("$file：缺少必要區段「## $sec」")
    fi
  done

  members_raw=$(get_value "$file" "Members")
  if [ -n "$members_raw" ] && ! is_todo "$members_raw"; then
    member_list=()
    while IFS= read -r m; do
      [ -n "$m" ] && member_list+=("$m")
    done < <(get_list "$file" "Members")

    count=${#member_list[@]}
    if [ "$count" -gt 0 ] && ([ "$count" -lt 2 ] || [ "$count" -gt 5 ]); then
      warnings+=("$file（$display）：目前有 $count 位組員，建議每組 2 至 5 人，請確認是否正確")
    fi

    for name in "${member_list[@]}"; do
      if ! [[ "$name" =~ $member_name_pattern ]]; then
        errors+=("$file（$display）：成員名稱「$name」不符合命名規則（僅限小寫英文字母、數字與連字號，且必須以字母開頭）")
        continue
      fi

      referenced_members="${referenced_members}|${name}|"

      member_file="$DATA_DIR/members/${name}.md"
      if [ ! -f "$member_file" ]; then
        errors+=("$file（$display）：成員「$name」的檔案 data/members/${name}.md 不存在")
        continue
      fi

      check_conflict_markers "$member_file"

      printf '%s\t%s\n' "$name" "$display" >> "$assignments_file"
    done
  fi
done

# Check for duplicate members
if [ -s "$assignments_file" ]; then
  dup_names=$(cut -f1 "$assignments_file" | sort | uniq -d)
  if [ -n "$dup_names" ]; then
    while IFS= read -r dup_name; do
      dup_teams=$(grep "^${dup_name}	" "$assignments_file" | cut -f2 | awk '{ if (NR>1) printf " 與 "; printf "%s", $0 }')
      errors+=("成員「$dup_name」同時被列在 ${dup_teams} 中，每位成員只能屬於一個小組")
    done <<< "$dup_names"
  fi
fi

# Check orphaned member files and naming
while IFS= read -r name; do
  [ -z "$name" ] && continue
  if ! [[ "$name" =~ $member_name_pattern ]]; then
    errors+=("data/members/${name}.md：檔案名稱不符合命名規則（僅限小寫英文字母、數字與連字號，且必須以字母開頭）")
  fi
  if [[ "$referenced_members" != *"|${name}|"* ]]; then
    warnings+=("data/members/${name}.md：此成員檔案沒有被任何小組的 team.md 引用")
  fi
  check_conflict_markers "$DATA_DIR/members/${name}.md"
done < <(discover_members)

# Output results
echo ""
echo "=== 資料驗證結果 ==="
echo ""

if [ ${#errors[@]} -eq 0 ] && [ ${#warnings[@]} -eq 0 ]; then
  echo "全部通過，沒有發現任何問題。"
else
  if [ ${#errors[@]} -gt 0 ]; then
    echo "發現 ${#errors[@]} 個錯誤："
    echo ""
    for e in "${errors[@]}"; do
      echo "  ✗ $e"
    done
    echo ""
  fi
  if [ ${#warnings[@]} -gt 0 ]; then
    echo "${#warnings[@]} 個警告（不影響通過）："
    echo ""
    for w in "${warnings[@]}"; do
      echo "  ⚠ $w"
    done
    echo ""
  fi
fi

if [ ${#errors[@]} -gt 0 ]; then
  echo "驗證未通過，請修正以上錯誤後重新提交。"
  exit 1
else
  echo "驗證通過。"
fi
