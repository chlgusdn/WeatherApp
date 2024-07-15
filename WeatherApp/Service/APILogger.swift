//
//  APILogger.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/15/24.
//

import Foundation
import Alamofire

/// API Request 시 로깅하기 위한 EventMonitor
final class APILogger: EventMonitor {
    
    /// Queue 설정
    let queue = DispatchQueue(label: "Network Logger in Weather Apps")
    
    /// Request 시 로깅할 함수
    /// - Parameter request: Request 정보
    func requestDidFinish(_ request: Request) {
        Log.network("""
        - ******** [Request] ********
        - [URL] : \(request.request?.url?.absoluteString ?? "__none__")
        - [METHOD] : \(request.request?.method?.rawValue ?? "__none__")
        - [PARAM] : \(request.request?.httpBody?.toPrettyPrintedString ?? "__none__")
        """)
    }
    
    /// Request 완료 후 Response 를 로깅할 함수
    /// - Parameters:
    ///   - request: Request 정보
    ///   - response: Response 정보
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        Log.network("""
        - ******** [Response] ********
        - [URL] : \(request.request?.url?.absoluteString ?? "__none__")
        - [STATUS CODE] : \(response.response?.statusCode ?? -1)
        - [RESULT] : \(response.data?.toPrettyPrintedString ?? "__none__")
        """)
    }
    
}

fileprivate extension Data {
    
    /// API 로깅 시 데이터를 표시하기 위한 변수
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString as String
    }
}
