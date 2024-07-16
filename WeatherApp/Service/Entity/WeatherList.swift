//
//  WeatherList.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/16/24.
//

import Foundation


/// 날씨 정보 리스트
struct WeatherList: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let weatherInfoList: [WeatherInfo]
    let city: City?
 
    enum CodingKeys: String, CodingKey {
        case cod
        case message
        case cnt
        case weatherInfoList = "list"
        case city
    }
}
