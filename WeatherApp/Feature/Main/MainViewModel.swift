//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/16/24.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

/// 메인화면에 대한 뷰모델
final class MainViewModel: ViewModelType {
    
    /// 사용자 Input 정보 (사용자 Action)
    struct Input {
        /// 불러올 도시
        let actionWeatherInfo = BehaviorRelay<Int>(value: Constant.initalStateCityId)
    }
    
    /// 사용자 Output 정보 (View에 사용될 데이터 값)
    struct Output {
        
        /// 날씨 정보에 대한 헤더
        let weatherHeaderBehavior = PublishRelay<WeatherHeader>()
        
        /// 날씨 리스트
        let weatherListBehavior = BehaviorRelay<[WeatherInfo]>(value: [])
        
        /// 에러 처리
        let errorPublished = PublishRelay<APIError>()
    }
    
    var input: Input
    var disposeBag = DisposeBag()
    
    /// API를 호출할 리포지토리 객체
    var repository: MainRepositoryable
    
    /// Repository를 D.I하기 위한 initalizer
    /// - Parameter repository: 리포지토리 인터페이스 (추후 다른 Interface를 사용할 수 있기 때문에 protocol값으로 선정)
    init(repository: MainRepositoryable) {
        self.repository = repository
        input = Input()
    }
    
    func transform() -> Output {
        let output = Output()
        
        /// 날씨정보가 변경되었을 때
        input.actionWeatherInfo
            .withUnretained(self)
            .flatMapLatest { (safeSelf, cityId) in
                return Observable.combineLatest(
                    safeSelf.repository.getCurrentWeather(
                        request: MainRequest(
                            currentCityId: cityId
                        )
                    ),
                    safeSelf.repository.getWeatherListIn5Days(
                        request:
                            MainRequest(
                                cityId: cityId
                            )
                    )
                )
            }
            .subscribe(onNext: { (headerResult, listResult) in
                switch headerResult {
                case .success(let info):
                    let weatherHeader = WeatherHeader(
                        cityName: info.name ?? "",
                        currentTemperature: Int(info.main.temp),
                        maxTemperature: Int(info.main.tempMax),
                        minTemperature: Int(info.main.tempMin),
                        weatherDescription: info.weather.first?.description ?? ""
                    )
                    
                    output.weatherHeaderBehavior.accept(weatherHeader)
                    
                case .failure(let error):
                    let weatherHeader = WeatherHeader(
                        cityName: "날씨를 불러올 수 없음",
                        currentTemperature: 0,
                        maxTemperature: 0,
                        minTemperature: 0,
                        weatherDescription: "날씨를 불러올 수 없음"
                    )
                    
                    output.weatherHeaderBehavior.accept(weatherHeader)
                }
                
                switch listResult {
                case .success(let weatherList):
                    let weatherInfoList = weatherList.weatherInfoList.filter { info in info.dtTxt.contains("00:00:00") }
                    output.weatherListBehavior.accept(weatherInfoList)
                    
                case .failure(let error):
                    output.errorPublished.accept(error)
                }
            })
            .disposed(by: disposeBag)
        
        return output
    }
}
