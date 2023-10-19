# Information
보안을 위해 API_Key가 제외되어있습니다. 빌드를 원하시는 분은 아래로 Plist를 요청해주세요!

<a href="mailto:hexter1994@naver.com">Plist 요청하기</a>

# Introduce

알라딘 API를 활용하여 책 데이터를 받아서 List / Grid 스타일로 목록 화면을 표시하고, 책 상세정보 화면으로 이동할 수 있습니다.

라이브러리를 배제하고 의도적으로 바닐라 기능만 사용하여 구현했습니다.

프로젝트 계층은 크게 Data Layer와 Presenter Layer로 구분되어 있고, Presenter Layer는 MVVM 패턴과 Coordinator 패턴을 적용했습니다.

<br>

### 작업 기간

2023.07 ~ 2023.10 (실 개발 기간 : 7주)

<br>

### 키워드

- UIKit (iOS 14.0)
- MVVM + Coordinator
- async-await 비동기 처리
- TaskGroup 병렬 처리
- 무한스크롤
- UserDefault
- NSCache 이미지

<br>

### 주요 기능

<table style="width: 100%;">
  <colgroup>
    <col style="width: 33%;">
    <col style="width: 33%;">
    <col style="width: 33%;">
  </colgroup>
  <tr>
    <th>검색 화면</th>
    <th>List ↔ Grid 전환</th>
    <th>무한스크롤</th>
  </tr>
  <tr>
    <td><img src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/c8334f34-7362-4ac7-ad84-bd882f6fb01f" alt="Vanilladin_검색"></td>
    <td><img src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/83eae6ba-75f2-4a80-8086-07be0ed43857" alt="Vanilladin_리스트스타일"></td>
    <td><img src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/9db3f057-6707-4d4f-8b5b-3cfab0223244" alt="Vanilladin_무한스크롤"></td>
  </tr>
  <tr>
    <td>검색어를 입력하면 API Endpoint를 생성해서 알라딘 API를 호출하고, 응답 데이터를 화면에 표시합니다.</td>
    <td>UISegmentedControl를 사용하여 목록 화면 스타일을 List / Grid로 전환합니다.</td>
    <td>스크롤 최하단 1/3 지점을 넘어가면 다음 페이지의 데이터를 요청하여 무한스크롤로 동작합니다.</td>
  </tr>
  <tr>
    <th>상세화면 이동</th>
    <th>에러 사용자 피드백</th>
    <th>최근 검색어 저장</th>
  </tr>
  <tr>
    <td><img src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/304764b4-b15e-4205-ad67-3df334b0e1c0" alt="Vanilladin_상세화면이동"></td>
    <td><img src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/9e95036d-6404-4a39-b506-ae8f41d09fe7" alt="Vanilladin_사용자피드백팝업"></td>
    <td><img src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/0735666b-3b7a-467d-a988-2f713f28846f" alt="Vanilladin_최근검색어저장"></td>
  </tr>
  <tr>
    <td>Cell을 선택하면 Book Detail 정보를 서버에 요청하고, 응답 결과를 포함하는 상세 화면을 Coordinator가 표시합니다.</td>
    <td>ISBN 데이터가 없어서 상세 화면으로 이동할 수 없는 경우, 에러를 방출하여 사용자에게 피드백 팝업을 표시합니다.</td>
    <td>최근 검색어를 최대 5개까지 저장합니다. UserDefault를 사용하여 로컬에 저장하고 앱이 종료되도 기록이 유지됩니다.</td>
  </tr>
</table>


<br><br>

# Architecture

<img width="2500" alt="Vanilladin_Architecture" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/f56fe649-4c74-481b-990a-7a3cf035d504">

<br><br>

# Directory

```
Vanilladin
├── Application
├── Config
├── Data
│   ├── DTO
│   │   └── Protocol
│   ├── Entity
│   │   └── Protocol
│   ├── Manager
│   ├── Network
│   │   ├── APIRequest
│   │   │   ├── Endpoint
│   │   │   │   ├── Parameter
│   │   │   │   └── Protocol
│   │   │   ├── Host
│   │   │   └── Scheme
│   │   ├── Error
│   │   ├── HTTP
│   │   └── Service
│   └── Repository
├── Presenter
│   ├── Common
│   │   ├── Base
│   │   ├── Coordinator
│   │   ├── DataSource
│   │   ├── ViewController
│   │   └── ViewModel
│   └── UI
│       ├── Coordinator
│       ├── DataSource
│       ├── View
│       │   ├── Cell
│       │   ├── View
│       │   └── ViewController
│       └── ViewModel
└── Utility
    ├── Constant
    ├── DependencyContainer
    └── Extension

```

- **Application** : App / Scene Delegate
- **Config** : Plist, Secret 파일
- **Data** : 데이터 모델과 네트워크를 담당하는 계층
  - **DTO** : 외부 데이터 소스와 통신하는 데이터 모델
  - **Entity** : 클라이언트에서 사용할 수 있도록 변환된 데이터 모델
  - **Manager** : 이미지 캐시, 동시성 처리, Plist
  - **Network** : API 요청 쿼리 생성, HTTP Request
  - **Repository** : Presenter 계층에서 데이터를 요청하고 반환받을 수 있는 인터페이스 객체
- **Presenter** : 비즈니스 로직과 UI 표시, 그리고 사용자 인터랙션을 담당하는 계층
  - **Common** : 상속을 위한 BaseView, Presenter 계층 관련 프로토콜과 에러 정의
  - **UI** : 사용자에게 화면을 표시하고, 사용자 인터랙션에 대한 로직 호출
- **Utility** : 프로젝트 전역에 사용되는 도구
  - **Constant** : 전역 상수 관리
  - **DependencyContainer** : 의존성 주입 및 관리 중앙화 객체
  - **Extension** : Swift 기존 타입에 대한 확장 메서드 정의
