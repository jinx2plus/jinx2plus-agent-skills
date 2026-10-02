# Gajae Code 사용자 지정 모델 프로필

Gajae Code를 실행하는 WSL 계정의 `~/.gjc/agent/models.yml`에서 확인한 역할별 모델 라우팅 설정입니다.

- 확인일: 2026-10-02
- 자격 증명, 토큰, 계정 식별자는 포함하지 않음
- 모델 ID와 추론 수준만 기록함

## 역할 의미

| 역할 | 용도 |
| --- | --- |
| `default` | 기본 라우팅 및 일반 대화 |
| `executor` | 실제 코드 수정 |
| `planner` | 작업 분해 및 실행 계획 수립 |
| `architect` | 여러 파일에 걸친 구조 검토 |
| `critic` | 독립적인 검토 및 오류 지적 |

## 프로필 요약

| 프로필 ID | 표시 이름 | 공급자 | default | executor | planner | architect | critic |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `custom` | Grok 4.7 | xai | Grok 4.7 · medium | Grok 4.7 · medium | Grok 4.7 · medium | Grok 4.20 Reasoning · medium | Grok 4.20 Reasoning · medium |
| `normal` | Normal | xai, openai-codex | Grok 4.7 · medium | GPT-5.6 Terra · medium | Grok 4.7 · high | GPT-6 Sol · high | Grok 4.7 · high |
| `runoppa` | RUNOPPA GPT 리셋 | openai-codex | GPT-6 Luna · medium | GPT-6 Astra · high | GPT-6 Sol · high | GPT-6.1 Sol · high | GPT-5.6 Terra · high |
| `ksafer-split` | KSAFER 분할 구성 | google-antigravity, xai, openai-codex | Claude Sonnet 4.6 · medium | GPT-6.1 Sol · high | Grok 4.7 · medium | Claude Opus 4.6 Thinking · medium | Grok 4.20 Reasoning · medium |

## 바로 복사할 수 있는 `models.yml`

아래 YAML을 기존 설정에 추가할 때는 관련 없는 프로필이나 스킬 설정을 덮어쓰지 마십시오.

```yaml
profiles:
  custom:
    required_providers:
      - xai
    display_name: Grok 4.7
    model_mapping:
      default: xai/grok-4.7:medium
      executor: xai/grok-4.7:medium
      planner: xai/grok-4.7:medium
      architect: xai/grok-4.20-0309-reasoning:medium
      critic: xai/grok-4.20-0309-reasoning:medium
  normal:
    required_providers:
      - xai
      - openai-codex
    display_name: Normal
    model_mapping:
      default: xai/grok-4.7:medium
      executor: openai-codex/gpt-5.6-terra:medium
      planner: xai/grok-4.7:high
      architect: openai-codex/gpt-6-sol:high
      critic: xai/grok-4.7:high
  runoppa:
    required_providers:
      - openai-codex
    display_name: RUNOPPA GPT리셋
    model_mapping:
      default: openai-codex/gpt-6-luna:medium
      executor: openai-codex/gpt-6-astra:high
      planner: openai-codex/gpt-6-sol:high
      architect: openai-codex/gpt-6.1-sol:high
      critic: openai-codex/gpt-5.6-terra:high
  ksafer-split:
    required_providers:
      - google-antigravity
      - xai
      - openai-codex
    display_name: KSAFER Split
    model_mapping:
      default: google-antigravity/claude-sonnet-4-6:medium
      executor: openai-codex/gpt-6.1-sol:high
      planner: xai/grok-4.7:medium
      architect: google-antigravity/claude-opus-4-6-thinking:medium
      critic: xai/grok-4.20-0309-reasoning:medium
```

## 업로드 및 보안 지침

이 프로필은 `jinx2plus/jinx2plus-agent-skills`의 `skills/gajae-model-profiles/`에 독립된 스킬 문서로 추가되었습니다.

- API 키, OAuth 토큰 또는 `config.yml`을 저장소에 업로드하지 마십시오.
- 모델 ID는 설정과 정확히 일치하도록 유지하십시오.
- 특히 `grok-4.20-0309-reasoning`, `gpt-6.1-sol`, `claude-opus-4-6-thinking`의 이름을 변경하지 마십시오.
- 다른 스킬의 파일이나 설정을 병합하거나 덮어쓰지 마십시오.
