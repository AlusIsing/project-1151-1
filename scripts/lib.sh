#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DATA_DIR="$ROOT_DIR/data"
SITE_DIR="$ROOT_DIR/site"
DIST_DIR="$ROOT_DIR/dist"

IMAGE_EXTS="jpg jpeg png gif webp svg"

escape_html() {
  local s="$1"
  s="${s//&/&amp;}"
  s="${s//</&lt;}"
  s="${s//>/&gt;}"
  s="${s//\"/&quot;}"
  printf '%s' "$s"
}

is_todo() {
  [[ "${1:-}" =~ ^[[:space:]]*TODO ]]
}

get_title() {
  awk '/^# / { sub(/^# */, ""); sub(/ *$/, ""); print; exit }' "$1"
}

get_section() {
  local file="$1" sect="$2"
  awk -v sect="$sect" '
    /^## / {
      h = $0; sub(/^## */, "", h); sub(/ *$/, "", h)
      if (h == sect) { f=1; next }
      else if (f) exit
    }
    f
  ' "$file"
}

get_value() {
  get_section "$1" "$2" | awk 'NF { gsub(/^[[:space:]]+|[[:space:]]+$/, ""); print; exit }'
}

get_list() {
  get_section "$1" "$2" | awk '/^- / { sub(/^- */, ""); print }'
}

name_to_hue() {
  local name="$1" hash=0 i c
  for (( i=0; i<${#name}; i++ )); do
    printf -v c '%d' "'${name:i:1}"
    hash=$(( c + ((hash << 5) - hash) ))
  done
  if [ "$hash" -lt 0 ]; then hash=$(( -hash )); fi
  echo $(( hash % 360 ))
}

discover_teams() {
  local teams_dir="$DATA_DIR/teams"
  [ -d "$teams_dir" ] || return 0
  for d in "$teams_dir"/*/; do
    [ -d "$d" ] || continue
    local name
    name=$(basename "$d")
    [[ "$name" == _* ]] && continue
    echo "$name"
  done | awk '{
    n = $0; sub(/^team-/, "", n)
    printf "%03d %s %s\n", length(n), n, $0
  }' | sort | awk '{ print $3 }'
}

team_display_name() {
  local folder="$1"
  if [[ "$folder" =~ ^team-(.+)$ ]]; then
    local suffix="${BASH_REMATCH[1]}"
    printf 'Team %s' "$(echo "$suffix" | tr '[:lower:]' '[:upper:]')"
  else
    printf '%s' "$folder"
  fi
}

discover_members() {
  local members_dir="$DATA_DIR/members"
  [ -d "$members_dir" ] || return 0
  for f in "$members_dir"/*.md; do
    [ -f "$f" ] || continue
    local name
    name=$(basename "$f" .md)
    [[ "$name" == _* ]] && continue
    echo "$name"
  done
}
