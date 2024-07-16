//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/16/24.
//

import Foundation
import RxSwift
import RxRelay


/// 메인화면에 대한 뷰모델
final class MainViewModel: ViewModelType {
    
    /// 사용자 Input 정보 (사용자 Action)
    struct Input {}
    
    /// 사용자 Output 정보 (View에 사용될 데이터 값)
    struct Output {}
    
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
    repository.getWeatherListIn5Days(request: MainRequest(lat: 44.34, lon: 10.99))
        .subscribe(onNext: { result in
            switch result {
            case .success(let weatherList):
                Log.debug(weatherList)
            case .failure(let error):
                Log.error(error)
            }
        })
        .disposed(by: disposeBag)
    return Output()
}
}
