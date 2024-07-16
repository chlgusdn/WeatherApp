//
//  Main.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

/// 날씨에 대한 온도 및 습도, 해수면 대기압 정보
struct Main: Codable {
    /// 온도
    var temp: Double
    /// 체감온도
    var feelsLike: Double
    /// 최저온도
    var tempMin: Double
    /// 최고온도
    var tempMax: Double
    /// 기본 해수면 대기압
    var pressure:Int
    /// 해수면 대기압
    var seaLevel:Int
    /// 지상 대기압
    var grndLevel:Int
    /// 습도
    var humidity: Int
    /// 내부 값
    var tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}
