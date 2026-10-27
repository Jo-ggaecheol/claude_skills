# claude_skills

Claude Code skill 모음. 프로젝트마다 필요한 skill만 골라서 설치해 씁니다.

## 사용법

```bash
# 한 번만 clone
git clone https://github.com/Jo-ggaecheol/claude_skills.git ~/claude_skills

# 전역 skill(global/) 연결 → ~/.claude/skills/
~/claude_skills/link-global.sh

# 프로젝트에 skill 설치 (프로젝트 폴더에서 실행)
~/claude_skills/install.sh --list
~/claude_skills/install.sh <skill> [<skill>...]
```

## 폴더

| 폴더 | 용도 |
|---|---|
| `global/` | 어디서나 쓰는 skill. `link-global.sh`로 전역에 연결 |
| `dev/` | 개발 공통 (코드 리뷰, 테스트 등) |
| `web/` | 프론트엔드, 백엔드 |
| `data/` | 분석, 엑셀, 시각화 |
| `writing/` | 블로그, 문서 |
| `_inbox/` | 새로 수집했지만 아직 안 써 본 것 |

## 규칙

- 새 skill은 `_inbox/`부터 넣고, 써 보고 괜찮으면 카테고리 폴더로 옮긴다.
- 남의 skill에는 `SOURCE.md`(원본 URL, 받은 날짜, 라이선스)와 원본 `LICENSE`를 함께 둔다.
- **재배포 가능한 라이선스(MIT, Apache-2.0 등)만 파일을 복사한다.** 라이선스가 없거나 재배포를 막는 것은 아래 "링크만" 표에 적는다.
- 넣기 전에 SKILL.md와 포함된 스크립트를 읽어 보고 안전한지 확인한다.
- skill 이름은 카테고리가 달라도 겹치지 않게 한다.

## 목록

| 이름 | 카테고리 | 한 줄 설명 | 출처 | 라이선스 |
|---|---|---|---|---|
| find-skills | global | 필요한 skill을 skills.sh / `npx skills`로 검색·추천 | [vercel-labs/skills](https://github.com/vercel-labs/skills/tree/main/skills/find-skills) | MIT |
| design-taste-frontend | _inbox | 뻔한 AI 디자인을 피하도록 디자인 방향을 정하고 검사 (Node 22+, Chrome) | [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | MIT |
| hallmark | _inbox | anti-AI-slop 웹 디자인: 테마, 레이아웃, lint (Node 18+, puppeteer-core 선택) | [Nutlope/hallmark](https://github.com/Nutlope/hallmark) | MIT |
| ui-ux-pro-max | _inbox | UI 스타일, 팔레트, 폰트 DB 검색과 디자인 시스템 생성 (Python 3) | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | MIT |
| frontend-design | _inbox | UI 디자인 방향, 타이포그래피 가이드 | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/frontend-design) | Apache-2.0 |
| emil-design-eng | _inbox | Emil Kowalski의 UI 디테일, 애니메이션 원칙 | [emilkowalski/skills](https://github.com/emilkowalski/skills) | MIT |
| web-design-guidelines | _inbox | Vercel Web Interface Guidelines로 UI 코드 리뷰 (쓸 때마다 규칙 fetch) | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills/tree/main/skills/web-design-guidelines) | MIT |
| huashu-design | _inbox | 한 문장으로 HTML 프로토타입, 슬라이드, 애니메이션 시안 제작 (용량 축소판, 중국어 문서) | [alchaincyf/huashu-design](https://github.com/alchaincyf/huashu-design) | MIT |

## 링크만 (재배포 불가)

| 이름 | 한 줄 설명 | 링크 | 라이선스 |
|---|---|---|---|
| docx | Word 문서 생성·편집 | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/docx) | Proprietary (source-available) |
| pdf | PDF 읽기·병합·생성 등 | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/pdf) | Proprietary (source-available) |
| pptx | PowerPoint 생성·편집 | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/pptx) | Proprietary (source-available) |
| xlsx | 엑셀 생성·편집 | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/xlsx) | Proprietary (source-available) |

## 추천 plugin

skill이 아니라 `/plugin`이나 별도 CLI로 설치하는 것. 이 레포의 `install.sh`로는 설치하지 않는다. 자세한 내용은 각 문서 참고.

| 이름 | 한 줄 설명 | 언제 | 문서 |
|---|---|---|---|
| headroom | Claude가 읽는 입력(로그, JSON, 도구 출력)을 로컬 프록시에서 압축해 토큰 절약 | 긴 디버깅·로그 분석 세션, 사용량 한도에 자주 걸릴 때 | [docs/plugins/headroom.md](docs/plugins/headroom.md) |
