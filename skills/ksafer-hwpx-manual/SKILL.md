---
name: ksafer-hwpx-manual
description: "Edit and validate Korean KSAFER HWPX operating manuals while preserving the existing layout, tables, technical commands, and document hierarchy; apply Korean prose naturalization only to explanatory text and verify the result against the runtime contract."
---

# KSAFER HWPX 운영매뉴얼

KSAFER 운영매뉴얼의 Markdown과 HWPX를 함께 수정할 때 사용한다. 기존 HWPX의 글꼴, 표, 문서 위계, 용지 설정, 페이지 구성을 유지하면서 실제 서버 코드와 실행 명령만 정확히 반영한다.

## 작업 범위

- Markdown을 편집 가능한 원본으로 사용하고, HWPX는 최종 배포본으로 취급한다.
- 원본 HWPX를 덮어쓰지 않는다. 사용자가 버전 변경을 요청하지 않았다면 먼저 백업하고, 요청된 파일만 수정한다.
- PDF는 요청되지 않는 한 생성하지 않는다.
- 운영 DB나 파일 릴리스에 쓰기 작업을 하지 않는다. 사용자가 명시적으로 승인한 경우에도 먼저 dry-run, 격리 출력, 검증 순서를 사용한다.

## `/ponytail lite` 모드

사용자가 `/ponytail lite`를 명시하면 요청한 문서 수정만 수행하고 선택 작업은 생략한다. 기존 HWPX의 서식 보존 patch, ZIP/XML 무결성 확인, 수정 문구의 MD·HWPX 일치 확인은 유지한다. 서버 catalog·`--help` 점검과 코드 주석·파일명 정리는 기술 내용이나 서버 코드를 함께 수정할 때만 수행하며, 전체 문서 재구성·광범위한 리팩터링·불필요한 PDF 생성은 하지 않는다. 결과에는 생략한 선택 점검과 더 단순한 대안을 각각 한 줄로 적는다. `/ponytail full` 또는 일반 요청에서는 아래 전체 절차를 적용한다.

## 통합 절차

1. `kordoc`으로 기준 HWPX를 파싱하고, 기준 MD·HWPX의 제목, 섹션 순서, 표 수, 페이지 수를 기록한다.
2. 실제 서버의 catalog, entrypoint, `--help`, 입력·출력 계약을 확인한다. 문서나 과거 백업의 파일명을 실행 근거로 사용하지 않는다.
3. MD에서 실행 경로, 옵션, 환경 조건, 결과 검증 기준을 수정한다. 실제 코드에 없는 옵션이나 성공을 보장하지 않는 문구를 만들지 않는다.
4. `patina:patina` 방식의 자연화는 설명문·주의문·절차 안내에만 적용한다. 코드 블록, 파일명, 경로, 옵션명, 환경변수, 컬럼명, 표의 헤더와 값은 수정 대상에서 제외한다.
5. 코드 주석이나 파일명에 생성 도구·제공자를 암시하는 표현이 있으면 `omo:remove-ai-slops` 범위로 별도 점검한다. 실행 의미가 있는 주석과 식별자는 임의로 삭제하지 않는다.
6. `kordoc`의 서식 보존 patch 또는 HWPX XML 텍스트 런 overlay로 본문만 반영한다. Markdown 전체를 새 문서로 재생성해 기존 서식을 잃지 않는다.
7. `rhwp-cli` 또는 사용 가능한 HWPX 렌더러로 SVG를 렌더하고, 표 잘림·코드 블록 겹침·페이지 넘침·빈 페이지를 확인한다.

## 보존해야 할 계약

- `Contents/header.xml`, `hp:secPr`, 표의 행·열·ID·구조, 개체 참조와 스타일 ID를 보존한다.
- HWPX는 ZIP/XML 패키지이므로 `mimetype`가 첫 항목이며 비압축인지, 필수 파트와 XML이 정상인지 확인한다.
- 문서에 실제 서버 경로를 쓸 때는 `/data2/ksafer`, 승인된 Python runtime, catalog의 owner 경로를 기준으로 한다.
- `LINK_ID`, `NODE_ID`, `F_NODE`, `T_NODE`, `CHUNG`, CRS, 날짜·시간 단위와 자료형은 코드·스키마·기존 승인 자료와 대조한다.
- 새 입력자료는 기존 승인자료와 폴더 구조, 내부 레이어명, 컬럼명·자료형, 식별자 인코딩, 시간 범위, `CHUNG`, CRS, geometry 의미가 모두 같아야 한다. 확장자만 같다는 이유로 승인하지 않는다.
- 비밀번호, API 키, DB URL의 실제 값은 문서·코드 예시·로그·검증 결과에 쓰지 않는다. 환경변수명이나 보호된 설정 경로만 표시한다.

## 검증 기준

수정 후 다음을 모두 확인한다.

- MD와 HWPX에서 구 파일명, 생성 도구명, 제공자명, 실제 비밀값이 남아 있지 않다.
- MD의 핵심 경로·명령·옵션이 HWPX 추출문에도 존재한다.
- HWPX ZIP 무결성, `mimetype`, 필수 파트, XML well-formedness가 통과한다.
- 기준본과 비교해 글자 외의 header, page settings, 표 구조와 문서 위계가 변하지 않는다.
- 렌더링한 모든 페이지에서 텍스트와 표가 페이지 경계를 넘지 않으며, 코드와 표가 겹치지 않는다.
- 서버 작업을 확인할 때는 컴파일, `--help`, catalog dry-run, 격리된 검증 산출물을 우선한다. dry-run 성공이나 종료 코드 0만으로 데이터 생성·DB 승격 성공이라고 쓰지 않는다.

공간·PostGIS·DTG·ROADRANK103·`LINK_ID` 정합성처럼 도메인 계약을 확인해야 할 때만 `tamspython-geospatial` 지침을 추가로 읽는다. HWPX의 구조나 조판 문제가 있으면 `kordoc`과 `rhwp-cli`의 분석 결과를 근거로 수정하며, 자연스러운 문장이라는 이유로 기술 계약을 바꾸지 않는다.
