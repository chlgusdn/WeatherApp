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


/// 날씨 정보
struct WeatherInfo: Decodable {
    
    /// 예측된 데이터 시간 정보 (UTC, UNIXTime)
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    
    /// 평균 가시성, 단위: m. 가시성의 최대값은 10km
    let visibility: Int
    /// 강수 확률
    let pop: Double
    let rain: Rain?
    let sys: Sys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case visibility
        case pop
        case rain
        case sys
        case dtTxt = "dt_txt"
    }
}

/// 날씨에 대한 온도 및 습도, 해수면 대기압 정보
struct Main: Codable {
    /// 온도
    var temp: Double
    /// 체감온도
    var feelsLike: Double
    /// 최저온도
    var tempMin: Double
    /// 최고온도
    var tempMax: Double
    /// 기본 해수면 대기압
    var pressure:Int
    /// 해수면 대기압
    var seaLevel:Int
    /// 지상 대기압
    var grndLevel:Int
    /// 습도
    var humidity: Int
    /// 내부 값
    var tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

/// 풍량 정보
struct Wind: Codable {
    /// 풍속
    var speed: Double?
    /// 풍향
    var deg: Int?
    /// 돌풍
    var gust: Double?
}
    
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

/// 위치 정보
struct Coord: Decodable {
    /// 위도
    var lat: Double?
    /// 경도
    var lon: Double?
}


/// 흐림 날씨에 대한 정보
struct Clouds: Decodable {
    /// 흐림 단위: %
    var all: Int?
}


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
