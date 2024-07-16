//
//  Rain.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

/// 강수 정보
struct Rain: Codable {
    /// 지난 3시간동안 강수량 단위: mm
    var the3H: Double?
    /// 지난 1시간동안 강수량 단위: mm
    var the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
        case the1H = "1h"
    }
}
