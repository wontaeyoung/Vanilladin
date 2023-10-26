# Information
보안을 위해 API_Key가 제외되어있습니다. 빌드를 원하시는 분은 아래로 Plist를 요청해주세요!

<a href="mailto:hexter1994@naver.com">hexter1994@naver.com</a>

# Introduce

알라딘 API를 활용하여 책 데이터를 받아서 List / Grid 스타일로 목록 화면을 표시하고, 책 상세정보 화면으로 이동할 수 있습니다.

라이브러리를 배제하고 의도적으로 바닐라 기능만 사용하여 구현했습니다.

데이터 업데이트 시 델리게이트 패턴을 통해 UI가 업데이트됩니다.

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
    <col style="width: 34%;">
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
    <td><img src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/52eac1d6-e237-4c84-a57a-d428950dcde4" alt="Vanilladin_무한스크롤"></td>
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
    <td><img src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/34ec8214-562f-4c3f-a046-abdaa78df98e" alt="Vanilladin_최근검색어저장"></td>
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

<br>

<details>
<summary>디렉토리 설명</summary>

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

</details>

<br><br>

# Trouble Shoot

<br>

### 의존성 컨테이너의 인스턴스 고유 식별 문제

Dependency Container는 레지스트리를 통해의존성을 관리합니다. 

인스턴스 획득 시 이미 등록된 의존성을 체크해서 재사용할 수 있도록 합니다.

이 때 같은 타입의 인스턴스가 이미 등록되었는지를 판단하는 문제가 발생합니다.

이를 해결하기 위해 ObjectIdentifier를 key로 사용하는 아이디어를 채택했습니다.

ObjectIdentifier는 참조 타입의 객체의 메모리 주소를 통해 키를 생성합니다.

그래서 인스턴스의 Type으로 ObjectIdentifier를 초기화하면 Type 자체가 정의된 메타데이터를 기반으로 키를 생성하기 때문에, 해당 타입의 인스턴스가 이미 레지스트리에 등록되어 있는지를 판단할 수 있습니다.

<img width="300" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/395994ba-9283-4edf-bb5e-fecb52522ff8">

<img width="300" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/72505233-575f-4a69-a1d0-c6027bceb2c2">

<br><br>

### 레지스트리 인스턴스 미등록 예외처리

`DependencyContainer`에서 의존성을 획득할 때, 등록되어있지 않은 경우에 대한 예외처리가 필요합니다.

<br><br>

**1. Factory 패턴 적용**

<img width="500" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/fe4d5340-5d38-4baa-952c-493702535f32">

우선 적용한 해결책은 `Factory` 패턴입니다. `resolve` 호출 시, 인스턴스가 등록되어있지 않은 경우를 대비해서 새 인스턴스를 초기화하는 클로저를 전달받아서 등록했습니다.

<img width="500" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/66a08304-f078-4002-a7cb-8a4694239527">

하지만 `Factory` 패턴을 사용하면 인스턴스를 초기화할 때, 연결된 의존성에 대해 모두 `Factory` 클로저를 작성해야하는 문제가 발생했습니다.

<br><br>

**2. Lazy Register 로직 구현**

그 다음 적용한 해결책은 Lazy하게 Register 하는 방법입니다. `Containable`을 채택한 제네릭을 전달해서 인스턴스가 필요한 시점에 자동으로 초기화하여 추가한다는 장점이 있습니다. 또한, 명시적으로 모든 인스턴스의 생성을 직접 작성해주지 않아도 되는 편리함이 있습니다.

하지만 이 방식은 참조 관계를 잘못 설정할 경우 순환참조의 루프로 앱이 크래시될 수 있고, 모든 `Containable` 객체가 파라미터가 없는 `init`을 구현해야하는 큰 단점이 존재했습니다. 이런 경우 이미 구현된 앱의 상당 부분을 변경해야했습니다.

<img width="500" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/81174119-fa35-4626-83a0-4d8ed3055b5a">

<img width="500" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/66a08304-f078-4002-a7cb-8a4694239527">

<img width="500" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/52932f49-998f-4f21-a5dd-67a6598157ab">

<br><br>

**3. 컴포지션 루트 방식 채택**

최종적으로 선택한 해결책은 모든 객체와 의존성을 앱 시작지점에 구성하는 컴포지션 루트입니다.

이렇게 하면 앱 내의 모든 인스턴스를 중앙에서 관리할 수 있고, 동일한 의존성이 필요한 서로 다른 객체에 간편하게 같은 참조를 전달할 수 있는 장점이 있습니다.

`SceneDelegate`에서 앱 시작 시점에 모든 인스턴스 관계를 생성하는 `setDependency`를 호출하여 의존성을 주입하고 레지스트리에 등록하도록 했습니다.
