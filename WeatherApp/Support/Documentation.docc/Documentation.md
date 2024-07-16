# ``WeatherApp``

## Overview
*OpenWeather API*를 이용하여 날씨를 보고자하는 리스트와 선택한 도시의 날씨를 보여주는 앱입니다.

## Architecture
아키텍쳐는 기본적으로 MVVM(Model-ViewModel-View)형식으로 구성되어있으며,
ViewModel의 경우 I.O패턴 (사용자한테 입력을 받는 Input과 실질적으로 View에 데이터를 보여줄 Output)으로 구성되어있습니다.

### Dependency Manager
해당 앱에서 의존성 관리는 SPM (Swift Package Manager)로 관리합니다.
> Tip: SPM의 경우, 빌드 시 의존성을 체크하는 과정이 존재하지 않으며, 애플 First-Party로 관리되어있기 때문에 선정하였습니다.

### Foldering 
폴더 구조는 아래와 같이 구성되어있습니다.
- App
> 앱의 라이프사이클을 담는 폴더 (AppDelegate, SceneDelegate)
- Common
> 프로젝트에서 사용되는 유틸 파일을 담는 폴더 입니다.
- Common (Base)
> Feature에 View에 사용되는 베이스 클래스 정보를 담는 폴더 입니다.
- Feature
> 앱에 대한 화면을 담는 폴더 (기본적으로 View, ViewModel, ViewController를 담습니다)
- Service
> API 혹은 네트워킹 처리에 관한 파일을 담는 폴더 입니다.
- Support
> 위 내용 외 유틸 관련된 파일 (info.plist, Asset, LaunchScreen 등)을 담는 폴더입니다.


## Library
- AlamoFire (https://github.com/Alamofire/Alamofire)
> 기본적인 Networking 통신을 위한 라이브러리 입니다.

- RxSwift (https://github.com/ReactiveX/RxSwift)
> 비동기 및 이벤트 기반 프로그램을 보다 쉽게 작성하기 위한 라이브러리 입니다.

- SnapKit (https://github.com/SnapKit/SnapKit)
> AutoLayout을 쉽게 이용하기 위한 라이브러리 입니다.

- RxDataSources (https://github.com/RxSwiftCommunity/RxDataSources)
> TableView에 Delegate, DataSource를 적용하지 않고, Rx바인딩을 사용하기 위한 라이브러리입니다.


