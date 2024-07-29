//
//  CacheJSON.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/29/24.
//

import Foundation

/// JSON 파일 캐시 클래스
final class CacheJSON {
    
    /// 캐싱 클래스의 싱글톤 객체
    static let shared = CacheJSON()
    
    private let manager = FileManager.default
    
    private init() {}
    
    
    /// 파일 캐싱 함수
    /// - Parameter fileName: 캐싱할 파일 이름, 확장자는 json이여야합니다
    func write(_ fileName: String) {
        do {
            let cacheDirectory = try manager.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            let fileURL = cacheDirectory.appendingPathComponent(fileName)
            
            guard let localJSONFile = Bundle.main.url(forResource: fileName, withExtension: "json") else { return }
            
            if !manager.fileExists(atPath: fileURL.path) {
                let data = try Data(contentsOf: localJSONFile)
                manager.createFile(atPath: fileURL.path, contents: data)
            }
            
        }
        catch {
            Log.error("Cache 저장에 실패하였습니다")
        }
    }
    
    
    /// 캐싱한 객체를 불러올 함수
    /// - Parameters:
    ///   - fileName: 파일 이름
    ///   - type: 객체 타입
    ///   - isSave: 객체를 불러오지 못했을 경우 캐싱 여부
    /// - Returns: 캐싱한 객체정보
    func load<T: Decodable>(_ fileName: String, type: T.Type, isSave: Bool = false) -> T? {
        
        do {
            let cacheDirectory = try manager.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            let fileURL = cacheDirectory.appendingPathComponent(fileName)
            
            if manager.fileExists(atPath: fileURL.path) {
                
                let data = try Data(contentsOf: fileURL)
                
                return try JSONDecoder().decode(type.self, from: data)
            }
            else if isSave {
                write(fileName)
            }
        }
        catch {
            Log.error("데이터를 가져오는데 실패하였습니다")
        }
        
        return nil
    }
    
    
    
}
