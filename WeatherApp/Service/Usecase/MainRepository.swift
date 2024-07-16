//
//  MainRepository.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/16/24.
//

import Foundation
import RxSwift

/// 메인화면에 대한 리포지토리 인터페이스
protocol MainRepositoryable {
    /// 최근 5일에 대한 날씨정보를 가져올 API
    /// - Parameter request: API Request 정보
    /// - Returns: 최근 5일에 대한 날씨리스트 및 에러 정보
    func getWeatherListIn5Days(request: MainRequest) -> Observable<Result<WeatherList, APIError>>
}

/// 메인화면에 대한 리포지토리 구현체
final class MainRepository: MainRepositoryable {
    
    func getWeatherListIn5Days(request: MainRequest) -> Observable<Result<WeatherList, APIError>> {
        return APIService.shared.sendRequest(request).map { $0 }
    }
}
