//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

/// 현재 날씨 정보 엔티티
struct CurrentWeather: Decodable {
    var base: String
    var id: Int
    var dt: Int
    var main: Main
    var coord: Coord
    var wind: Wind
    var sys: Sys
    var weather: [Weather]
    
    /// 가시성
    var visibility: Int
    var clouds: Clouds
    
    /// 타임스탬프 in UTC
    var timezone: Int
    var cod: Int
    /// 도시이름
    var name: String
    var rain: Rain
}
