#!/usr/bin/env bash
source "$(dirname "$0")/lib.sh"

number_to_letters() {
  local n="$1" result=""
  local alphabet="abcdefghijklmnopqrstuvwxyz"
  while [ "$n" -ge 0 ]; do
    result="${alphabet:$((n % 26)):1}${result}"
    n=$(( n / 26 - 1 ))
  done
  echo "$result"
}

args=("$@")

if [ ${#args[@]} -eq 0 ]; then
  echo "用法：scripts\\init-teams <組數>          （Windows）" >&2
  echo "      bash scripts/init-teams.sh <組數>  （macOS / Linux）" >&2
  echo "" >&2
  echo "      scripts\\init-teams a b c d e" >&2
  echo "      bash scripts/init-teams.sh a b c d e" >&2
  exit 1
fi

letters=()
if [ ${#args[@]} -eq 1 ] && [[ "${args[0]}" =~ ^[0-9]+$ ]]; then
  count="${args[0]}"
  if [ "$count" -lt 1 ]; then
    echo "組數必須至少為 1" >&2
    exit 1
  fi
  for (( i=0; i<count; i++ )); do
    letters+=("$(number_to_letters "$i")")
  done
else
  for a in "${args[@]}"; do
    letters+=("$(echo "$a" | tr '[:upper:]' '[:lower:]')")
  done
fi

template_path="$DATA_DIR/teams/_template/team.md"
template=$(cat "$template_path")

created=()
skipped=()

for letter in "${letters[@]}"; do
  folder_name="team-${letter}"
  team_dir="$DATA_DIR/teams/$folder_name"

  if [ -d "$team_dir" ]; then
    skipped+=("$folder_name")
    continue
  fi

  mkdir -p "$team_dir"
  display_letter=$(echo "$letter" | tr '[:lower:]' '[:upper:]')
  echo "$template" | sed "s/^# Team ?$/# Team ${display_letter}/" > "$team_dir/team.md"
  created+=("$folder_name")
done

all_teams=()
while IFS= read -r line; do
  [ -n "$line" ] && all_teams+=("$line")
done < <(discover_teams)

echo ""
echo "=== 小組初始化完成 ==="
echo ""

if [ ${#created[@]} -gt 0 ]; then
  echo "新建 ${#created[@]} 組：$(IFS='、'; echo "${created[*]}")"
fi
if [ ${#skipped[@]} -gt 0 ]; then
  echo "跳過 ${#skipped[@]} 組（已存在）：$(IFS='、'; echo "${skipped[*]}")"
fi
echo "目前共 ${#all_teams[@]} 組：$(IFS='、'; echo "${all_teams[*]}")"
echo ""
echo "下一步："
echo "  git add data/teams/"
echo "  git commit -m \"feat: initialize teams\""
echo "  git push origin main"
echo ""
