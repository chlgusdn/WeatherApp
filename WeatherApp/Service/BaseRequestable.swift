//
//  BaseRequestable.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/15/24.
//

import Foundation
import Alamofire

/// Request시 기본적으로 가지고 있어야할 변수 정보 프로토콜
protocol BaseRequestable {
    
    /// HTTP Method 정보
    var method: HTTPMethod { get }
    
    /// HTTP Request시 필요한 파라미터 정보
    var params: Parameters { get set }
    
    /// HTTP Request시 호출API 명
    var endPoint: String { get }
    
    /// UnitTest에 사용될 SampleResponse 값
    var sampleResponse: Data { get }
}

extension BaseRequestable {
    /// SampleResponse 값은 굳이 적지 않아도 되게끔 기본값 지정
    var sampleResponse: Data {
        return Data()
    }
}
