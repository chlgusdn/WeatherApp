//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

/// 날씨 정보
struct WeatherInfo: Decodable {
    
    /// 예측된 데이터 시간 정보 (UTC, UNIXTime)
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    
    /// 평균 가시성, 단위: m. 가시성의 최대값은 10km
    let visibility: Int
    /// 강수 확률
    let pop: Double
    let rain: Rain?
    let sys: Sys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case visibility
        case pop
        case rain
        case sys
        case dtTxt = "dt_txt"
    }
}
