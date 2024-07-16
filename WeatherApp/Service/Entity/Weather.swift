//
//  Weather.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

/// 날씨 정보
struct Weather: Decodable {
    /// 날씨 상태 id
    let id: Int
    /// 날씨 값 (비, 눈, 구름)
    let main: String
    /// 날씨 상태
    let description: String
    /// 날씨
    let icon: String
}
