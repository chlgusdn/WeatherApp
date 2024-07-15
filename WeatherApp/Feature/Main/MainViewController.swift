//
//  MainViewController.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/15/24.
//

import UIKit

/// 메인 화면에 대한 피처 클래스
final class MainViewController: BaseViewController {
    
    /// 나의 위치 레이블
    private let currentMyLocationTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "나의 위치"
        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    
    /// 내 위치 표시 데이터 레이블
    private let currentMyLocationLabel:UILabel = {
        let label = UILabel()
        label.text = "대한민국 서울시"
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    
    /// 온도 표시 레이블
    private let temperatureLabel:UILabel = {
        let label = UILabel()
        label.text = "12도"
        label.font = UIFont.systemFont(ofSize: 75, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    
    /// 날씨 표시 레이블
    private let weatherLabel:UILabel = {
        let label = UILabel()
        label.text = "부분적으로 흐림"
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    
    /// 최고, 최저 기온 표시 레이블
    private let temperatureAreaLabel:UILabel = {
        let label = UILabel()
        label.text = "최고: 17 최저 11"
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    
    /// 레이블을 순서대로 담을 컨테이너 뷰
    private let containerStackView:UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 8
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setProperty() {
        
        let rightButtonItem = UIBarButtonItem(
            systemItem: .search,
            primaryAction: UIAction(
                handler: { _ in
                    
                }
            )
        )
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    override func setLayout() {
        [currentMyLocationTitleLabel,
         currentMyLocationLabel,
         temperatureLabel,
         weatherLabel,
         temperatureAreaLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        view.addSubview(containerStackView)
    }
    
    override func setConstraint() {
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
    }
    
}

@available(iOS 17.0, *)
#Preview("Main화면") {
    UINavigationController(
        rootViewController: MainViewController()
    )
}

