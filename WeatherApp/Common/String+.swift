//
//  String+.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

extension String {
    
    /// 날짜 포맷을 (요일)로 변경하는 함수
    /// - Returns: 요일로 변경한 날짜 포맷
    func dateFomatDayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let convertDate = dateFormatter.date(from: self)
                
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "EEEEE"
        myDateFormatter.locale = Locale(identifier:"ko_KR")
        let convertStr = myDateFormatter.string(from: convertDate!)
        
        return convertStr
    }
}
