//
//  Coord.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation
/// 위치 정보
struct Coord: Decodable {
    /// 위도
    var lat: Double?
    /// 경도
    var lon: Double?
}
