# Information
보안을 위해 API_Key가 제외되어있습니다. 빌드를 원하시는 분은 아래로 Plist를 요청해주세요!

<a href="mailto:hexter1994@naver.com">hexter1994@naver.com</a>

<br><br>

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

<br>

**MVVM**
- `ViewContoller`(View)는 UI 코드와 화면을 그리는 로직을 가지고 있습니다.
- `ViewModel에서는` `ViewController에서` 발생하는 이벤트를 전달하고, UI에 반영할 데이터 가공을 담당합니다.
- 여러 `ViewModel에서` 공유 데이터를 활용할 수 있도록, `DataSource` 단계를 두어 데이터를 관리하고 `Repository를` 통해 데이터를 요청합니다.

<br>

**Coordinator**
- 네비게이션 및 사용자 `Alert을` 담당하고 있습니다.
- `push`, `pop`, `emptyOut` 등 네비게이션을 관리하는 인터페이스 함수를 `ViewModel에` 제공하여, 이벤트에 따라 간편하게 네비게이션 로직을 사용할 수 있도록 합니다.

<br>

**Dependency Container**
- 앱에서 사용되는 모든 객체의 의존성을 중앙에서 관리합니다.
- 레지스트리에 인스턴스를 등록하여, 참조가 필요한 다른 객체에게 쉽게 의존성을 전달할 수 있습니다.

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

# Trouble Shoot과 고민 지점

## Singleton으로 생성하는 기준?

단일 책임과 기능을 가진 클래스를 사용할 때, 필요한 시점에 인스턴스를 휘발적으로 생성해서 사용하거나 싱글톤으로 단일 인스턴스를 메모리에 올려두고 사용할 수 있습니다.

두 방법 중에 하나를 선택하는 명확한 기준이 필요한데, `DependencyContainer`나 `CacheManager`는 등록 작업을 수행한 스코프가 종료되어도 공유 데이터가 앱 생명주기동안 유지되어야 하고, 해당 데이터를 필요로하는 다른 객체가 불특정한 시점에 조회하더라도 이전에 등록된 데이터를 사용할 수 있어야합니다.

이를 기준으로 다른 객체에서 접근하는 공유 데이터가 있다면 싱글톤으로 구현하고, 단순 기능 책임만 가진 클래스는 휘발적으로 인스턴스를 생성해서 작업이 종료되면 참조 카운트에 의해 자동으로 해제되도록 했습니다.

<br>

---

<br>

## 의존성 컨테이너의 인스턴스 고유 식별 문제

`DependencyContainer`는 레지스트리를 통해 의존성을 관리합니다. 인스턴스 획득 시 이미 등록된 의존성을 체크해서 재사용할 수 있도록 합니다.

이 때 같은 타입의 인스턴스가 이미 등록되었는지를 판단하는 문제가 발생합니다.

<br>

### ObjectIdentifier

이를 해결하기 위해 `ObjectIdentifier`를 `key`로 사용하는 아이디어를 채택했습니다.

`ObjectIdentifier`는 참조 타입의 객체의 메모리 주소를 통해 키를 생성합니다.

그래서 인스턴스의 `Type`으로 `ObjectIdentifier`를 초기화하면 `Type` 자체가 정의된 메타데이터를 기반으로 키를 생성하기 때문에, 해당 타입의 인스턴스가 이미 레지스트리에 등록되어 있는지를 판단할 수 있습니다.

<br>

<img width="600" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/395994ba-9283-4edf-bb5e-fecb52522ff8">

<br>

<img width="600" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/72505233-575f-4a69-a1d0-c6027bceb2c2">

<br><br>

---

<br>

## 레지스트리 인스턴스 미등록 예외처리 문제

`DependencyContainer`에서 의존성을 획득할 때, 등록되어있지 않은 경우에 대한 예외처리가 필요합니다.

<br>

### **1. Factory 패턴 적용**

<img width="600" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/fe4d5340-5d38-4baa-952c-493702535f32">

우선 적용한 해결책은 `Factory` 패턴입니다. `resolve` 호출 시, 인스턴스가 등록되어있지 않은 경우를 대비해서 새 인스턴스를 초기화하는 클로저를 전달받아서 등록했습니다.

<img width="600" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/66a08304-f078-4002-a7cb-8a4694239527">

하지만 `Factory` 패턴을 사용하면 인스턴스를 초기화할 때, 연결된 의존성에 대해 모두 `Factory` 클로저를 작성해야하는 문제가 발생했습니다.

<br><br>

### **2. Lazy Register 로직 구현**

그 다음 적용한 해결책은 Lazy하게 Register 하는 방법입니다. `Containable`을 채택한 제네릭을 전달해서 인스턴스가 필요한 시점에 자동으로 초기화하여 추가한다는 장점이 있습니다. 또한, 명시적으로 모든 인스턴스의 생성을 직접 작성해주지 않아도 되는 편리함이 있습니다.

하지만 이 방식은 참조 관계를 잘못 설정할 경우 순환참조의 루프로 앱이 크래시될 수 있고, 모든 `Containable` 객체가 파라미터가 없는 `init`을 구현해야하는 큰 단점이 존재했습니다. 이런 경우 이미 구현된 앱의 상당 부분을 변경해야했습니다.

<img width="600" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/81174119-fa35-4626-83a0-4d8ed3055b5a">

<br>

<img width="600" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/d87dc87d-434e-48e2-96f9-5bd65c03494c">

<br>

<img width="600" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/52932f49-998f-4f21-a5dd-67a6598157ab">

<br><br>

### **3. 컴포지션 루트 방식 채택**

최종적으로 선택한 해결책은 모든 객체와 의존성을 앱 시작지점에 구성하는 컴포지션 루트입니다.

이렇게 하면 앱 내의 모든 인스턴스를 중앙에서 관리할 수 있고, 동일한 의존성이 필요한 서로 다른 객체에 간편하게 같은 참조를 전달할 수 있는 장점이 있습니다.

`SceneDelegate`에서 앱 시작 시점에 모든 인스턴스 관계를 생성하는 `setDependency`를 호출하여 의존성을 주입하고 레지스트리에 등록하도록 했습니다.

<br>

---

<br>

## 이미지 동시 요청 순차처리 문제

Aladin API에서 응답받은 책 데이터에는 책 이미지 URL이 포함되어 있습니다. 클라이언트에서 사용하기 전에 BookDTO의 이미지 URL을 요청해서 UIImage로 변환한 Book Entity로 변환하는 과정이 필요했습니다.

이 때 응답 단위인 10개의 Image URL을 요청하면 이미지 다운로드가 순차적으로 진행되는 문제가 발생했습니다.

응답 결과가 이후 로직에 활용되는 경우에는 await으로 실행을 중단해야하지만, 각 이미지 요청은 서로에게 의존성이 없기 때문에 병렬로 작업하는 것이 더 적합하다고 판단하여 TaskGroup을 도입했습니다.

<br>

### 병렬 처리 도입 후 성능 개선

<img width="600" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/d83be037-5656-4433-b856-f897a0b22d11">

<br>

AsyncManager를 만들고 병렬로 매핑을 수행하는 mapConcurrently 함수를 구현했습니다.

외부에서 주입한 네트워크 요청 매핑 클로저를 작업으로 추가하고, 동시에 수행하여 완료되는 순서대로 결과에 담아 반환하도록 했습니다.

<br>

#### **이미지 직렬 요청**

<img width="600" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/0b01c21c-d86c-4c2a-a5c6-3fe733c30f22">

<br>

#### **이미지 병렬 요청**

<img width="600" alt="image" src="https://github.com/wontaeyoung/Vanilladin/assets/45925685/0aa9445f-1685-4a91-a32c-7101f7935053">

<br><br>

로직 변경 후 테스트를 통해 동일한 조건에서 약 3.6배 정도 응답 시간의 개선을 확인했습니다.
