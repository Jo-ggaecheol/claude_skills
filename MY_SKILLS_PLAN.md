# claude_skill 레포 구축 계획

Claude Code용 skill을 GitHub 레포 하나에 모아 관리하고, 프로젝트마다 필요한 것만 꺼내 쓰기 위한 계획.
(2026-10-27 정리. 새 세션에서는 이 문서를 먼저 읽고 "앞으로 할 일"부터 진행)

---

## 1. 지금까지 정리한 내용

### Skill과 Plugin의 차이
- **Skill**: 작업 지침 묶음. `<이름>/SKILL.md`(+ 템플릿, 스크립트) 형태.
  - frontmatter의 `name`, `description`만 평소에 로드되고, 작업이 description과 맞을 때 본문을 읽음 → 많이 넣어도 부담이 적음.
  - Claude가 자동으로 쓰거나 `/skill-이름`으로 직접 호출.
  - 위치: `~/.claude/skills/<이름>/SKILL.md`(전역), `<프로젝트>/.claude/skills/<이름>/SKILL.md`(프로젝트).
  - **Claude Code는 `skills/` 바로 아래 한 단계만 찾음** → 카테고리 폴더 안에 넣으면 인식 안 됨.
- **Plugin**: skill, slash command, subagent, hook, MCP 서버를 묶은 배포 단위.
  - marketplace(GitHub repo 등)를 통해 `/plugin`, `/plugin marketplace add`, `/plugin install 이름@마켓` 으로 설치.
  - Skill은 내용물이고 plugin은 그걸 담는 상자. 나중에 내 레포를 marketplace로 바꿔 배포할 수도 있음.

### Skill을 찾는 곳
- `github.com/anthropics/skills` (Anthropic 공식)
- `github.com/vercel-labs/skills` (find-skills 포함 + `npx skills` CLI)
- https://skills.sh (검색 사이트)
- GitHub에서 "awesome claude skills" 검색

### find-skills 설치
```bash
npx skills add https://github.com/vercel-labs/skills --skill find-skills      # 프로젝트에 설치
npx skills add https://github.com/vercel-labs/skills --skill find-skills -g   # 전역 설치
```
설치 후 `.claude/skills/find-skills/SKILL.md`가 생겼는지 확인할 것.

---

## 2. 결정한 운영 방식

1. GitHub에 `claude_skill` 레포(**public**)를 만든다. 원본은 `~/side_project/eddie/claude_skill`, 다른 PC에서는 한 번만 clone한다(public이라 clone에 인증 불필요).
2. 어디서 본 skill은 레포에 계속 쌓는다.
3. **어디서나 쓰는 skill**(`global/`)은 `~/.claude/skills`에 심볼릭 링크로 연결해 전역으로 쓴다.
4. **프로젝트마다 다른 skill**은 새 프로젝트를 시작할 때 `install.sh`로 골라서 `./.claude/skills/`에 평평하게 복사한다.
   - clone 후 안 쓰는 걸 지우는 방식은 쓰지 않는다(실수로 삭제를 push할 위험이 있음).
   - 복사본은 프로젝트 git에 함께 커밋하고, 프로젝트에 맞게 고쳐 써도 된다.

### 레포 구조
```
claude_skill/
├── README.md        # 목록표: 이름 | 카테고리 | 한 줄 설명 | 출처
├── install.sh       # ./install.sh <skill> [<skill>...] → ./.claude/skills/ 로 복사
├── global/          # 전역용 → ~/.claude/skills 에 링크 (find-skills 등)
├── dev/             # 개발 공통 (코드 리뷰, 테스트 등)
├── web/             # 프론트엔드, 백엔드
├── data/            # 분석, 엑셀, 시각화
├── writing/         # 블로그, 문서
└── _inbox/          # 새로 수집했지만 아직 안 써 본 것
```

### 정리 규칙
- 새 skill은 **`_inbox/`부터** 넣고, 써 보고 괜찮을 때 카테고리 폴더로 옮긴다.
- 남의 skill에는 `SOURCE.md`(원본 URL, 받은 날짜, 라이선스)를 함께 둔다.
- README 목록표를 항상 최신으로 유지한다.
- 카테고리는 5~6개 이하로 유지한다.
- public 레포이므로 **재배포 가능한 라이선스(MIT, Apache-2.0 등)만 파일을 복사**하고, 원본 `LICENSE`도 함께 둔다. 라이선스가 없거나 재배포를 막는 것(예: anthropics/skills의 docx/pdf/pptx/xlsx)은 README에 링크만 적는다.
- `install.sh`는 `_inbox/`도 설치 대상에 포함한다(써 보고 옮기기 위해).
- 넣기 전에 SKILL.md와 포함된 스크립트를 읽어 보고 안전한지 확인한다.

---

## 3. 앞으로 할 일

- [ ] GitHub에 `claude_skill` public 레포 생성 (gh 미설치 → 웹에서 만들거나 gh 설치)
- [x] 이 폴더에서 `git init` 및 폴더 구조 만들기
- [x] `README.md` 목록표 템플릿 작성
- [x] `install.sh` 작성 (`--list` 지원, 더미 skill로 테스트 완료)
  - 인자로 받은 skill 이름을 카테고리 폴더 전체에서 찾아 `./.claude/skills/<이름>/`으로 복사
  - 이름이 중복되거나 못 찾으면 에러, 이미 있으면 덮어쓸지 확인
- [x] `global/`의 skill들을 `~/.claude/skills/`에 심볼릭 링크로 연결하는 스크립트(`link-global.sh`) 작성 (기존 항목은 건너뜀, 테스트 완료)
- [x] `vercel-labs/skills`에서 find-skills를 받아 `global/find-skills/`에 넣고 `SOURCE.md` 작성
- [x] `anthropics/skills` 등에서 고른 skill 7개 `_inbox/`에 넣기 (headroom은 plugin → `docs/plugins/headroom.md`)
- [ ] 첫 커밋 및 push
- [ ] 테스트: 빈 폴더에서 `install.sh`를 실행해 보고 Claude Code에서 `/` 목록에 skill이 뜨는지 확인

### 나중에 (선택)
- [ ] 직접 만든 skill 추가 (예: tech_blog용 `writing/blog-post`)
- [ ] 다른 컴퓨터나 팀원과 공유가 필요해지면 `.claude-plugin/marketplace.json`을 추가해 plugin marketplace로 전환
