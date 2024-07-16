//
//  UINavigationItem+.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//


import UIKit

extension UINavigationItem {
    
    /// searchController 설정함수
    /// - Parameters:
    ///   - title: 네비게이션 제목
    ///   - placeholder: placeholder 값
    func setupSearchController(title: String, placeholder: String) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = placeholder
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController = searchController
        self.title = title
        self.hidesSearchBarWhenScrolling = false
        
    }
}
