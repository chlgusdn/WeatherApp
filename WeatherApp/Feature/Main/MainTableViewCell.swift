//
//  MainTableViewCell.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/16/24.
//

import UIKit

/// 메인화면  날씨 테이블 셀
final class MainTableViewCell: BaseTableViewCell {
    
    typealias T = WeatherInfo
    
    /// 위치 레이블
    private let dayLabel:UILabel = {
        let label = UILabel()
        label.text = "월"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "☁️"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.text = "23"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.text = "29"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    /// 레이블을 순서대로 담을 컨테이너 뷰
    private let containerStackView:UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    /// 구분선
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    /// 날씨 아이콘
    private enum WeatherIcon: String {
        case rain = "Rain"
        case cloud = "Clouds"
        case sunny = "Clear"
        case snow = "Snow"
        
        var icon: String {
            switch self {
            case .rain:      return "🌧️"
            case .cloud:     return "☁️"
            case .sunny:     return "☀️"
            case .snow:      return "🌨️"
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        [dayLabel,
         weatherLabel,
         minTempLabel,
         maxTempLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        addSubview(containerStackView)
        addSubview(dividerView)
        
        containerStackView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(4)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellConfigure(weather: WeatherInfo) {
        minTempLabel.text = "\(Int(weather.main.tempMin))°C"
        maxTempLabel.text = "\(Int(weather.main.tempMax))°C"
        dayLabel.text = weather.dtTxt.dateFomatDayOfWeek()
        
        if let weather = weather.weather.first?.main {
            weatherLabel.text = WeatherIcon(rawValue: weather)?.icon
        }
    }
}
@available(iOS 17.0, *)
#Preview(
    traits: .fixedLayout(
        width: 414,
        height: 40
    ),
    body: {
        MainTableViewCell(style: .default, reuseIdentifier: "")
    }
)
