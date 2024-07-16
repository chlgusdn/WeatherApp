//
//  String+.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation

extension String {
    
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
