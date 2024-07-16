//
//  Sys.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

/// 낮/밤에 대한 정보
struct Sys: Codable {
    /// 낮/밤 정보 (낮: D, 밤: N)
    var pod: String?
    var country: String?
    var sunset: Int?
    var type: Int?
    var sunrise: Int?
    var id: Int?
}
