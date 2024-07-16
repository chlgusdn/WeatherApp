//
//  SearchViewTableViewCell.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import UIKit

final class SearchViewTableViewCell: UITableViewCell, CellConfigurable {
    typealias T = City

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: City) {
        titleLabel.text = data.name
    }
}
