//
//  Log.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/15/24.
//

import Foundation
import os.log

/// OSLog 타입 정보
extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier!
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let debug = OSLog(subsystem: subsystem, category: "Debug")
    static let info = OSLog(subsystem: subsystem, category: "Info")
    static let error = OSLog(subsystem: subsystem, category: "Error")
}

/// OSLog를 래핑한 로깅 구조체
struct Log {
    
    /// 로그 레벨 정보
    /// - debug : 디버깅 로그
    /// - info : 트러블 슈팅시 사용되는 정보, (선택적인 정보)
    /// - network : 네트워크 정보
    /// - error :  오류
    /// - custom(category: String) : 커스텀 디버깅 로그 (UI 등)
    enum Level {
        /// 디버깅 로그
        case debug
        /// 문제 해결 정보
        case info
        /// 네트워크 로그
        case network
        /// 오류 로그
        case error
        /// 커스텀 오류 (UI..등)
        case custom(category: String)
        
        /// 로깅 시 카테고리 정보
        fileprivate var category: String {
            switch self {
            case .debug:
                return "✅ DEBUG"
            case .info:
                return "ℹ️ INFO"
            case .network:
                return "🛰️ NETWORK"
            case .error:
                return "🚫 ERROR"
            case .custom(let category):
                return "✨ \(category)"
            }
        }
        
        /// `Level`값을 기준으로 OSLog값으로 가져오기위한 변수
        fileprivate var osLog: OSLog {
            switch self {
            case .debug:
                return OSLog.debug
            case .info:
                return OSLog.info
            case .network:
                return OSLog.network
            case .error:
                return OSLog.error
            case .custom:
                return OSLog.debug
            }
        }
        
        /// `Level`값을 기준으로 OSLogType값으로 가져오기위한 변수
        fileprivate var osLogType: OSLogType {
            switch self {
            case .debug:
                return .debug
            case .info:
                return .info
            case .network:
                return .default
            case .error:
                return .error
            case .custom:
                return .debug
            }
        }
    }
    
    
    /// 로깅 함수
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - arguments: 로그 객체 정보
    ///   - level: 로그 레벨 정보
    static private func log(_ message: Any, _ arguments: [Any], level: Level) {
        #if DEBUG
        let extraMessage: String = arguments.map({ String(describing: $0) }).joined(separator: " ")
        os_log("%{public}@", log: level.osLog, type: level.osLogType, "\(message) \(extraMessage)")
        #endif
    }
}

extension Log {
    
    /// 디버그 로깅함수 (개발 시 디버깅 시 사용되는 기본적인 함수)
    /// - Parameters:
    ///   - message: 메시지
    ///   - arguments: 객체 정보
    static func debug(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .debug)
    }
    
    /// 트러블 슈팅시 사용되는 로깅 함수 (필수적이진 않지만, 도움이되는 정보를 기록할 때 사용)
    /// - Parameters:
    ///   - message: 메시지
    ///   - arguments: 객체 정보
    static func info(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .info)
    }
    
    /// 네트워크 API등 네트워킹 로깅 함수
    /// - Parameters:
    ///   - message: 메시지
    ///   - arguments: 객체 정보
    static func network(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .network)
    }
    
    /// 에러 정보를 로깅하는 함수
    /// - Parameters:
    ///   - message: 메시지
    ///   - arguments: 객체 정보
    static func error(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .error)
    }
    
    /// 기존에 정의된 로깅함수 외에 커스텀으로 로그를 정의할 수 있는 함수
    /// - Parameters:
    ///   - category: 커스텀 태그 정보
    ///   - message: 메시지
    ///   - arguments: 객체 정보
    static func custom(category: String, _ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .custom(category: category))
    }
}
