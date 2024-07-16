//
//  Clouds.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

/// 흐림 날씨에 대한 정보
struct Clouds: Decodable {
    /// 흐림 단위: %
    var all: Int?
}
