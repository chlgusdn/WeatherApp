//
//  APIError.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/15/24.
//

import Foundation

/// API 에러 처리 Enum
enum APIError: Error {
    
    /// 디코딩 실패
    case decodeFailed
    
    /// API Request가 잘못되었을 때
    case badRequest
    
    /// Request가 많이 요청되었을 때
    case manyRequest
    
    /// 서버 에러
    case serverError
    
    /// 서버 Request TimeOut
    case gateWayTimeOut
    
    /// 위 케이스를 제외한 오류 케이스
    case etcError(statusCode: Int)
}
