//
//  Wind.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

/// 풍량 정보
struct Wind: Codable {
    /// 풍속
    var speed: Double?
    /// 풍향
    var deg: Int?
    /// 돌풍
    var gust: Double?
}
    
