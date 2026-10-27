#!/usr/bin/env bash
# global/ 아래 skill을 하나씩 ~/.claude/skills/<이름> 으로 심볼릭 링크.
# 같은 이름의 실제 폴더/파일이 이미 있으면 건드리지 않고 건너뜀.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

mkdir -p "$TARGET_DIR"

for dir in "$REPO_DIR/global"/*/; do
  [[ -f "$dir/SKILL.md" ]] || continue
  name="$(basename "$dir")"
  src="${dir%/}"
  link="$TARGET_DIR/$name"

  if [[ -L "$link" ]]; then
    if [[ "$(readlink "$link")" == "$src" ]]; then
      echo "이미 연결됨: $name"
    else
      echo "건너뜀: $name (다른 곳을 가리키는 링크가 있음: $(readlink "$link"))"
    fi
  elif [[ -e "$link" ]]; then
    echo "건너뜀: $name (같은 이름의 폴더/파일이 이미 있음)"
  else
    ln -s "$src" "$link"
    echo "연결: $name -> $src"
  fi
done
