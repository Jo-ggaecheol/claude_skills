#!/usr/bin/env bash
# 사용법:
#   /path/to/claude_skill/install.sh <skill> [<skill>...]   현재 폴더의 ./.claude/skills/ 로 복사
#   /path/to/claude_skill/install.sh --list                설치 가능한 skill 목록
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CATEGORIES=(global dev web data writing _inbox)
DEST_ROOT="$PWD/.claude/skills"

usage() {
  echo "사용법: $(basename "$0") <skill> [<skill>...] | --list" >&2
  exit 1
}

# 카테고리/이름 형태로 모든 skill 나열
list_skills() {
  local cat dir
  for cat in "${CATEGORIES[@]}"; do
    for dir in "$REPO_DIR/$cat"/*/; do
      [[ -f "$dir/SKILL.md" ]] && echo "$cat/$(basename "$dir")"
    done
  done
}

[[ $# -eq 0 ]] && usage

if [[ "$1" == "--list" ]]; then
  list_skills
  exit 0
fi

if [[ "$REPO_DIR" == "$PWD" ]]; then
  echo "에러: skill 레포 안이 아니라 설치할 프로젝트 폴더에서 실행하세요." >&2
  exit 1
fi

status=0
for name in "$@"; do
  matches=()
  for cat in "${CATEGORIES[@]}"; do
    [[ -f "$REPO_DIR/$cat/$name/SKILL.md" ]] && matches+=("$cat")
  done

  if [[ ${#matches[@]} -eq 0 ]]; then
    echo "에러: '$name' 을(를) 찾을 수 없음 (--list 로 확인)" >&2
    status=1; continue
  fi
  if [[ ${#matches[@]} -gt 1 ]]; then
    echo "에러: '$name' 이(가) 여러 카테고리에 있음: ${matches[*]}" >&2
    status=1; continue
  fi

  src="$REPO_DIR/${matches[0]}/$name"
  dest="$DEST_ROOT/$name"

  if [[ -e "$dest" ]]; then
    read -r -p "'$dest' 이(가) 이미 있음. 덮어쓸까요? [y/N] " answer
    if [[ "$answer" != [yY] ]]; then
      echo "건너뜀: $name"
      continue
    fi
    rm -rf "$dest"
  fi

  mkdir -p "$DEST_ROOT"
  cp -R "$src" "$dest"
  echo "설치: ${matches[0]}/$name -> .claude/skills/$name"
done

exit $status
