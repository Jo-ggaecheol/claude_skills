# 출처

- 원본: https://github.com/alchaincyf/huashu-design (v3.0.0)
- 커밋: 4fc7bfdbd5ec3fa2d43ce7a6433de60976a5e4b1
- 받은 날짜: 2026-10-27
- 라이선스: MIT (Copyright (c) 2026 alchaincyf (花叔 · 花生))
- 수정 사항:
  - 용량 줄이기 위해 `demos/`, `assets/showcases/`, `assets/bgm-*.mp3` 제외 (41MB → 11MB).
    `scripts/add-music.sh`의 기본 mood 프리셋은 동작하지 않음 → `--music=<파일>`로 직접 지정.
  - `.last-update-check`에 `off` 기록: 원본 레포가 아닌 이 레포 안에 있으므로 SKILL.md의 30일 업데이트 확인을 끔.
  - `references/voiceover-pipeline.md` 395행: Claude가 `--yes`를 붙여 TTS(ByteDance 豆包) 동의 확인을 건너뛰라는 안내 제거.
- 참고: 쓰는 동안 `~/.huashu-design/`에 사용자 발언과 프로젝트 경로를 기록함.
  필요한 도구: ffmpeg, Node 18+ (playwright, pdf-lib, pptxgenjs, sharp), Python playwright + Chromium, Pillow.
