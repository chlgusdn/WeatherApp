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
    
    /// 오류 정보에 대한 설명
    var errorDescription: String {
        switch self {
        case .decodeFailed:                       return "디코딩에 실패하였습니다"
        case .badRequest:                         return "잘못된 Request 입니다"
        case .manyRequest:                        return "Request가 너무 많이 실행되었습니다"
        case .serverError:                        return "서버 에러입니다"
        case .gateWayTimeOut:                     return "서버 Request 타임아웃 입니다"
        case .etcError(let statusCode):           return "\(statusCode) 에러가 발생하였습니다"
        }
    }
}
