//
//  WeatherHeader.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

/// Main화면에서 헤더에 표시할 데이터 정보 (뷰에서만 사용됩니다)
struct WeatherHeader {
    
    /// 지역 이름
    var cityName: String
    
    /// 현재 온도
    var currentTemperature: Int
    
    /// 최고 온도
    var maxTemperature: Int
    
    /// 최저 온도
    var minTemperature: Int
    
    /// 날씨 상태
    var weatherDescription: String
}
