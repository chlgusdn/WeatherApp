//
//  APIService.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/15/24.
//

import Foundation
import Alamofire
import RxSwift

/// 네트워킹 처리를 위한 클래스
final class APIService {
    
    static let shared = APIService()
    private init() {}
    
    /// API 호출을 위한 Alamofire 객체 생성
    /// 이때 타임아웃 정보 및 API Reqeust Logging 추가
    let session: Session = {
        var session = Session.default
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        session = Session(configuration: configuration, eventMonitors: [APILogger()])
        return session
    }()
    
    /// UnitTest에 사용될 Test용 Request 함수
    /// - Parameters:
    ///   - request: Request 정보
    ///   - statusCode: 테스트할 상태 코드
    /// - Returns: API Sample Response Observable 객체
    func sendRequestForUnitTest<T: Decodable>(_ request: BaseRequestable, statusCode: Int) -> Observable<Result<T, APIError>>{
        return Observable.create { [weak self] observer in
            guard let `self` = self else {
                Log.error(" API Request에 실패하였습니다. `self` is nil")
                return Disposables.create()
            }
            if 200...300 ~= statusCode {
                do {
                    let responseData = try JSONDecoder().decode(T.self, from: request.sampleResponse)
                    observer.onNext(.success(responseData))
                }
                catch {
                    observer.onNext(.failure(.decodeFailed))
                }
            }
            else {
                let error = makeStatusCodeInAPIError(statusCode)
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    
    /// API 호출시 사용될 Request 함수
    /// - Parameter request: Request 정보
    /// - Returns: API Response Observable 객체
    func sendRequest<T: Decodable>(_ request: BaseRequestable) -> Observable<Result<T, APIError>> {
        return Observable.create { [weak self] observer in
            guard let `self` = self else {
                Log.error(" API Request에 실패하였습니다. `self` is nil")
                return Disposables.create()
            }
            
            let urlRequest = makeURLRequest(request)
            session.request(urlRequest)
                .validate()
                .responseData { data in
                    
                    switch data.result {
                    case .success(let responseData):
                        do {
                            let responseData = try JSONDecoder().decode(T.self, from: responseData)
                            observer.onNext(.success(responseData))
                        }
                        catch {
                            observer.onNext(.failure(.decodeFailed))
                        }
                        
                    case .failure(let error):
                        let error = self.makeStatusCodeInAPIError(error.responseCode ?? -1)
                        observer.onNext(.failure(error))
                    }
                    
                    observer.onCompleted()
                }
                
            return Disposables.create()
        }
    }
}

private extension APIService {
    
    /// StatusCode값을 이용하여 APIError enum으로 컨버팅하는 함수
    /// - Parameter statusCode: 상태코드 정보
    /// - Returns: API Error에 대한 Enum 정보
    func makeStatusCodeInAPIError(_ statusCode: Int) -> APIError {
        switch statusCode {
        case 400:              return .badRequest
        case 429:              return .manyRequest
        case 500:              return .serverError
        case 504:              return .gateWayTimeOut
        default:               return .etcError(statusCode: statusCode)
        }
        
    }
    
    /// POST, DELTE, PUT API Request시 파라미터를 httpBody에 넣기위해 값을 변경하기 위한 함수
    /// - Parameter param: 파라미터 정보
    /// - Returns: httpBody Data객체
    func makeRequestBodyParameter(_ params: Parameters) -> Data {
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: params)
            return bodyData
        }
        catch {
            Log.error("POST 파라미터 생성에 실패하였습니다")
            return Data()
        }
    }
    
    
    /// API 송신을 위한 URLRequest 생성 메서드
    /// - Parameter request: Request 정보 (httpMethod, endpoint, parameter)
    /// - Returns: API송신 URLRequest 객체
    func makeURLRequest(_ request: BaseRequestable) -> URLRequest {
        
        // URLRequest 생성
        let apiEndPointFullURL = "\(Constant.baseURL)/\(request.endPoint)"
        var urlRequest = URLRequest(url: URL(string: "\(apiEndPointFullURL)")!)
        urlRequest.httpMethod = request.method.rawValue
        var params = request.params
        params.updateValue(Constant.apiKey, forKey: "appid")
        
        // Parameter 설정
        switch request.method {
        case .get:
            
            let queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            let queryString = urlRequest.url?.appending(queryItems: queryItems)
            urlRequest.url = queryString
            
            return urlRequest
            
        default:
            let bodyData = makeRequestBodyParameter(params)
            urlRequest.httpBody = bodyData
            
            return urlRequest
        }
    }
    
}
