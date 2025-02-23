//
//  MainRequest.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/16/24.
//

import Foundation
import Alamofire


/// 메인화면에 대한 API Request 정보
struct MainRequest: BaseRequestable {
    var method: HTTPMethod
    var params: Parameters
    var endPoint: String
    
    /// 도시아이디 값을 기본으로 API 호출할 때 사용할 initalizer
    /// - Parameter id: 도시 아이디 정보
    init(cityId: Int) {
        method = .get
        params = [
            "id": cityId
        ]
        endPoint = "forecast"
    }
    
    /// 도시아이디 값을 기본으로 API 호출할 때 사용할 initalizer
    /// - Parameter currentCityId: 도시 아이디 정보
    init(currentCityId: Int) {
        method = .get
        params = [
            "id": currentCityId
        ]
        endPoint = "weather"
    }
}
