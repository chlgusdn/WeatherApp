//
//  City.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

/// 도시 정보
struct City: Decodable {
    /// 도시 아이디
    let id: Int
    
    /// 도시 이름
    let name: String
    
    /// 위치 정보
    let coord: Coord
    
    /// 국가 코드
    let country: String
    
    /// 도시 인구
    var population: Int?
    
    /// UTC 에서 초단위로 변경한 날짜
    var timezone: Int?
    
    /// 일출시간 (UNIX, UTC)
    var sunrise: Int?
    
    /// 일몰시간 (UNIX, UTC)
    var sunset: Int?
    
    var state: String?
}
