//
//  CellConfigurable.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import UIKit

/// 셀에 대한 기본적인 함수 및 identifier를 정의한 프로토콜
protocol CellConfigurable: AnyObject {
    associatedtype T: Decodable
    
    /// Cell에 대한 기본적인 identifier
    static var identifier: String { get }
    /// Cell과 데이터를 바인딩하기 위한 함수
    func configureCell(data: T)
}

extension CellConfigurable {
    static var identifier: String {
        return String(describing: self)
    }
    
    func configureCell(data: T) {}
}
