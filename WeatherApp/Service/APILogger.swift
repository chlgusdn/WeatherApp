//
//  APILogger.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/15/24.
//

import Foundation
import Alamofire

final class APILogger: EventMonitor {
    
    let queue = DispatchQueue(label: "Network Logger in Weather Apps")
    
    func requestDidFinish(_ request: Request) {
        Log.network("""
        - ******** [Request] ********
        - [URL] : \(request.request?.url?.absoluteString ?? "__none__")
        - [METHOD] : \(request.request?.method?.rawValue ?? "__none__")
        - [PARAM] : \(request.request?.httpBody?.toPrettyPrintedString ?? "__none__")
        """)
    }
    
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
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString as String
    }
}
