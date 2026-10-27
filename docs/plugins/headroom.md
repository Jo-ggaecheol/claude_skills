# headroom

- 원본: https://github.com/chopratejas/headroom (Apache-2.0)
- 문서: https://docs.headroomlabs.ai
- 정리한 날짜: 2026-10-27 (v0.42.0 기준)

## 무엇인가

Claude가 **읽는 것**(도구 출력, 로그, 파일, 대화 기록)을 LLM에 보내기 전에 로컬에서 압축해서 토큰을 줄여 주는 도구.
압축은 내 컴퓨터에서 돌고, 원본은 로컬에 캐시해 두었다가 Claude가 필요하면 `headroom_retrieve`로 다시 꺼내 본다.

skill이 아니다. 실제로 일하는 건 **`headroom` CLI(Python)가 띄우는 로컬 프록시**이고, Claude Code용 plugin은 그 프록시를 자동으로 켜 주거나 절약량을 보여 주는 보조 장치일 뿐이다. 그래서 이 레포의 `install.sh`로는 설치하지 않는다.

## 언제 쓰면 좋은가

- **좋음**: 로그 분석, 장애 디버깅, 큰 JSON/API 응답, 코드 검색 결과, MCP 도구 출력처럼 **반복이 많은 입력**이 컨텍스트를 채우는 작업. 원본 벤치마크 기준 30~57% 절약, 반복 JSON/로그는 90% 이상.
- **효과 적음**: 산문 위주 대화, 이미 압축된 짧은 출력. 거의 줄지 않는다.
- **판단 기준**: 긴 세션에서 컨텍스트가 금방 차거나 사용량 한도에 자주 걸릴 때 써 볼 만하다. 짧은 작업 위주면 굳이 필요 없다.

## 설치

```bash
# 1. CLI 설치 (택1)
uv tool install --python 3.13 "headroom-ai[all]"
pip install "headroom-ai[all]"

# 2. Claude Code를 headroom 경유로 실행
headroom wrap claude

# 3. 확인
headroom doctor       # 라우팅 점검
headroom dashboard    # 절약량 실시간 확인 (프록시 실행 중일 때)
```

npm의 `headroom-ai`는 TypeScript 라이브러리일 뿐 `headroom` 명령이 없다. CLI는 PyPI 패키지로만 설치된다.

### Claude Code plugin (선택)

CLI를 설치한 뒤에 쓰는 보조 plugin. Claude Code 안에서:

```
/plugin marketplace add chopratejas/headroom
/plugin install headroom@headroom-marketplace        # 세션 시작 시 프록시 자동 실행 hook
/plugin install headroom-snip@headroom-marketplace   # 요청마다 줄어든 토큰을 보여 주는 표시줄, /headroom
```

## 알아둘 점

- **익명 텔레메트리가 기본으로 켜져 있다.** 압축률, 모델 ID, OS 같은 통계만 보내고 프롬프트나 코드는 보내지 않는다고 되어 있다. 끄려면 셸 설정에 `export HEADROOM_TELEMETRY=off`(또는 `DO_NOT_TRACK=1`).
- `headroom wrap claude`는 코드 탐색용 **Serena MCP 서버도 함께 설치**해서 `~/.claude.json`에 그 프로젝트 한정으로 등록한다. 원치 않으면 `--code-memory none`.
- 출력 토큰 줄이기(`HEADROOM_OUTPUT_SHAPER=1`)는 기본으로 꺼져 있다. 켜면 시스템 프롬프트 끝에 "짧게 답하라"는 문구를 덧붙인다.
- 되돌리기: `headroom unwrap claude`.
