//
//  BaseTableViewCell.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import UIKit

/// 테이블 뷰 셀에 대한 기본적인 베이스 클래스
class BaseTableViewCell: UITableViewCell {
    
    /// Cell에 대한 기본적인 identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
