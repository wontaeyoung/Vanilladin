# Introduce

UIKit으로 개발한 첫 프로젝트입니다. 알라딘 API를 활용하여 책 데이터를 받아서 List / Grid 스타일로 목록 화면을 표시하고, 책 상세정보 화면으로 이동할 수 있습니다.

라이브러리를 배제하고 의도적으로 바닐라 기능만 사용하여 구현했습니다.

프로젝트 계층은 크게 Data Layer와 Presenter Layer로 구분되어 있고, Presenter Layer는 MVVM 패턴과 Coordinator 패턴을 적용했습니다.

<br>

### 작업 기간

2023.07 ~ 2023.10 (실제 개발 기간 : 7주)

<br>

### 키워드

- UIKit (iOS 14.0)
- MVVM + Coordinator
- async-await 비동기 처리
- 무한스크롤
- UserDefault
- NSCache 이미지

<br>

### 기능 화면

## Vanilladin 앱 주요 기능

| **검색 화면** | **List ↔ Grid 전환** | **무한스크롤** |
|:----------------:|:-------------------------:|:----------------:|
| ![Vanilladin_검색](https://github.com/wontaeyoung/Vanilladin/assets/45925685/c8334f34-7362-4ac7-ad84-bd882f6fb01f) | ![Vanilladin_리스트스타일](https://github.com/wontaeyoung/Vanilladin/assets/45925685/83eae6ba-75f2-4a80-8086-07be0ed43857) | ![Vanilladin_무한스크롤](https://github.com/wontaeyoung/Vanilladin/assets/45925685/9db3f057-6707-4d4f-8b5b-3cfab0223244) |
| 검색어를 입력하면 API Endpoint를 생성해서 알라딘 API를 호출하고, 응답 데이터를 화면에 표시합니다. | UISegmentedControl를 사용하여 목록 화면 스타일을 List / Grid로 전환합니다. | 스크롤 최하단 1/3 지점을 넘어가면 다음 페이지의 데이터를 요청하여 무한스크롤로 동작합니다. |

| **상세화면 이동** | **에러 사용자 피드백** | **최근 검색어 저장** |
|:----------------:|:-------------------------:|:----------------:|
| ![Vanilladin_상세화면이동](https://github.com/wontaeyoung/Vanilladin/assets/45925685/304764b4-b15e-4205-ad67-3df334b0e1c0) | ![Vanilladin_사용자피드백팝업](https://github.com/wontaeyoung/Vanilladin/assets/45925685/9e95036d-6404-4a39-b506-ae8f41d09fe7) | ![Vanilladin_최근검색어저장](https://github.com/wontaeyoung/Vanilladin/assets/45925685/0735666b-3b7a-467d-a988-2f713f28846f) |
| Cell을 선택하면 Book Detail 정보를 서버에 요청하고, 응답 결과를 포함하는 상세 화면을 Coordinator가 표시합니다. | ISBN 데이터가 없어서 상세 화면으로 이동할 수 없는 경우, 에러를 방출하여 사용자에게 피드백 팝업을 표시합니다. | 최근 검색어를 최대 5개까지 저장합니다. UserDefault를 사용하여 로컬에 저장하고 앱이 종료되도 기록이 유지됩니다. |



# Directory

```
Vanilladin
├── Application : App / Scene Delegate
├── Config : Plist, Secret 파일
├── Data : 데이터 모델과 네트워크를 담당하는 계층
│   ├── DTO : 외부 데이터 소스와 통신하는 데이터 모델
│   │   └── Protocol
│   ├── Entity : 클라이언트에서 사용할 수 있도록 변환된 데이터 모델
│   │   └── Protocol
│   ├── Manager : 이미지 캐시, 동시성 처리, Plist
│   ├── Network : API 요청 쿼리 생성, HTTP Request
│   │   ├── APIRequest
│   │   │   ├── Endpoint
│   │   │   │   ├── Parameter
│   │   │   │   └── Protocol
│   │   │   ├── Host
│   │   │   └── Scheme
│   │   ├── Error
│   │   ├── HTTP
│   │   └── Service
│   └── Repository : Presenter 계층에서 데이터를 요청하고 반환받을 수 있는 인터페이스 객체
├── Presenter : 비즈니스 로직과 UI 표시, 그리고 사용자 인터랙션을 담당하는 계층
│   ├── Common : 상속을 위한 BaseView, Presenter 계층 관련 프로토콜과 에러 정의
│   │   ├── Base
│   │   ├── Coordinator
│   │   ├── DataSource
│   │   ├── ViewController
│   │   └── ViewModel
│   └── UI : 사용자에게 화면을 표시하고, 사용자 인터랙션에 대한 로직 호출
│       ├── Coordinator
│       ├── DataSource
│       ├── View
│       │   ├── Cell
│       │   ├── View
│       │   └── ViewController
│       └── ViewModel
└── Utility : 프로젝트 전역에 사용되는 도구
    ├── Constant : 전역 상수 관리
    ├── DependencyContainer : 의존성 주입 및 관리 중앙화 객체
    └── Extension : Swift 기존 타입에 대한 확장 메서드 정의
```# Introduce

UIKit으로 개발한 첫 프로젝트입니다. 알라딘 API를 활용하여 책 데이터를 받아서 List / Grid 스타일로 목록 화면을 표시하고, 책 상세정보 화면으로 이동할 수 있습니다.

라이브러리를 배제하고 의도적으로 바닐라 기능만 사용하여 구현했습니다.

프로젝트 계층은 크게 Data Layer와 Presenter Layer로 구분되어 있고, Presenter Layer는 MVVM 패턴과 Coordinator 패턴을 적용했습니다.

### 작업 기간

2023.07 ~ 2023.10 (7주)

### 키워드

- UIKit (iOS 14.0)
- MVVM + Coordinator
- async-await 비동기 처리
- 무한스크롤
- UserDefault
- NSCache

### 기능 화면

**검색 화면**

![검색어를 입력하면 API Endpoint를 생성해서 알라딘 API를 호출하고, 응답 데이터를 화면에 표시합니다.](https://prod-files-secure.s3.us-west-2.amazonaws.com/f738bff9-e823-40c2-afa4-21ab4de196c5/6f61dd2f-180b-4cd1-8eeb-9b843b1dc8c3/Simulator_Screen_Recording_-_iPhone_15_Pro_-_2023-10-17_at_03.52.18.gif)

검색어를 입력하면 API Endpoint를 생성해서 알라딘 API를 호출하고, 응답 데이터를 화면에 표시합니다.

**List ↔ Grid 전환**

![UISegmentedControl를 사용하여 목록 화면 스타일을 List / Grid로 전환합니다.](https://prod-files-secure.s3.us-west-2.amazonaws.com/f738bff9-e823-40c2-afa4-21ab4de196c5/218a04fc-ab2f-4329-a2b6-d045267d24dc/Simulator_Screen_Recording_-_iPhone_15_Pro_-_2023-10-17_at_03.53.07.gif)

UISegmentedControl를 사용하여 목록 화면 스타일을 List / Grid로 전환합니다.

**무한스크롤**

![스크롤 최하단 1/3 지점을 넘어가면 다음 페이지의 데이터를 요청하여 무한스크롤로 동작합니다.](https://prod-files-secure.s3.us-west-2.amazonaws.com/f738bff9-e823-40c2-afa4-21ab4de196c5/624f50fe-8094-49d3-9840-70d5bd168a49/Simulator_Screen_Recording_-_iPhone_15_Pro_-_2023-10-17_at_03.54.54.gif)

스크롤 최하단 1/3 지점을 넘어가면 다음 페이지의 데이터를 요청하여 무한스크롤로 동작합니다.

---

**상세화면 이동**

![Cell을 선택하면 Book Detail 정보를 서버에 요청하고, 응답 결과를 포함하는 상세 화면을 Coordinator가 표시합니다.](https://prod-files-secure.s3.us-west-2.amazonaws.com/f738bff9-e823-40c2-afa4-21ab4de196c5/e4c4fc1b-ed39-4811-bc2b-78a232102e12/Simulator_Screen_Recording_-_iPhone_15_Pro_-_2023-10-17_at_03.56.45.gif)

Cell을 선택하면 Book Detail 정보를 서버에 요청하고, 응답 결과를 포함하는 상세 화면을 Coordinator가 표시합니다.

**에러 사용자 피드백**

![ISBN 데이터가 없어서 상세 화면으로 이동할 수 없는 경우, 에러를 방출하여 사용자에게 피드백 팝업을 표시합니다.](https://prod-files-secure.s3.us-west-2.amazonaws.com/f738bff9-e823-40c2-afa4-21ab4de196c5/f3a21fc9-1305-4ba4-9c1a-6e9c4bc6ee60/Simulator_Screen_Recording_-_iPhone_15_Pro_-_2023-10-17_at_03.58.30.gif)

ISBN 데이터가 없어서 상세 화면으로 이동할 수 없는 경우, 에러를 방출하여 사용자에게 피드백 팝업을 표시합니다.

**최근 검색어 저장**

![최근 검색어를 최대 5개까지 저장합니다. UserDefault를 사용하여 로컬에 저장하고 앱이 종료되도 기록이 유지됩니다.](https://prod-files-secure.s3.us-west-2.amazonaws.com/f738bff9-e823-40c2-afa4-21ab4de196c5/cf70240e-9454-4f2b-950a-0581b3d1f097/Simulator_Screen_Recording_-_iPhone_15_Pro_-_2023-10-17_at_04.01.44.gif)

최근 검색어를 최대 5개까지 저장합니다. UserDefault를 사용하여 로컬에 저장하고 앱이 종료되도 기록이 유지됩니다.

# Directory

```
Vanilladin
├── Application : App / Scene Delegate
├── Config : Plist, Secret 파일
├── Data : 데이터 모델과 네트워크를 담당하는 계층
│   ├── DTO : 외부 데이터 소스와 통신하는 데이터 모델
│   │   └── Protocol
│   ├── Entity : 클라이언트에서 사용할 수 있도록 변환된 데이터 모델
│   │   └── Protocol
│   ├── Manager : 이미지 캐시, 동시성 처리, Plist
│   ├── Network : API 요청 쿼리 생성, HTTP Request
│   │   ├── APIRequest
│   │   │   ├── Endpoint
│   │   │   │   ├── Parameter
│   │   │   │   └── Protocol
│   │   │   ├── Host
│   │   │   └── Scheme
│   │   ├── Error
│   │   ├── HTTP
│   │   └── Service
│   └── Repository : Presenter 계층에서 데이터를 요청하고 반환받을 수 있는 인터페이스 객체
├── Presenter : 비즈니스 로직과 UI 표시, 그리고 사용자 인터랙션을 담당하는 계층
│   ├── Common : 상속을 위한 BaseView, Presenter 계층 관련 프로토콜과 에러 정의
│   │   ├── Base
│   │   ├── Coordinator
│   │   ├── DataSource
│   │   ├── ViewController
│   │   └── ViewModel
│   └── UI : 사용자에게 화면을 표시하고, 사용자 인터랙션에 대한 로직 호출
│       ├── Coordinator
│       ├── DataSource
│       ├── View
│       │   ├── Cell
│       │   ├── View
│       │   └── ViewController
│       └── ViewModel
└── Utility : 프로젝트 전역에 사용되는 도구
    ├── Constant : 전역 상수 관리
    ├── DependencyContainer : 의존성 주입 및 관리 중앙화 객체
    └── Extension : Swift 기존 타입에 대한 확장 메서드 정의
```
