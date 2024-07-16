//
//  MainViewController.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/15/24.
//

import UIKit
import RxDataSources

/// 메인 화면에 대한 피처 클래스
final class MainViewController: BaseViewController {
    
    /// 위치 레이블
    private let locationLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    /// 온도 표시 레이블
    private let temperatureLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 75, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    
    /// 날씨 표시 레이블
    private let weatherLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    /// 최고, 최저 기온 표시 레이블
    private let temperatureAreaLabel:UILabel = {
        let label = UILabel()
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
    
    /// 최근 5일에 대한 날씨를 보여주기 위한 테이블 뷰
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.layer.cornerRadius = 25
        tableView.contentInset = UIEdgeInsets(
            top: 20,
            left: 0,
            bottom: 0,
            right: 0
        )
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.rowHeight = 40
        tableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: MainTableViewCell.identifier
        )
        return tableView
    }()
    
    let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setProperty() {
        
        let rightButtonItem = UIBarButtonItem(
            systemItem: .search,
            primaryAction: UIAction(
                handler: { [weak self] _ in
                    let searchViewController = SearchViewController(
                        viewModel: SearchViewModel()
                    )
                    
                    searchViewController.delegate = self
                    
                    let navigationController = UINavigationController(
                        rootViewController: searchViewController
                    )
                    
                    self?.present(navigationController, animated: true)
                }
            )
        )
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    override func setLayout() {
        [locationLabel,
         temperatureLabel,
         weatherLabel,
         temperatureAreaLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        
        [containerStackView,
         tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraint() {
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.height.equalTo(250)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
    
    override func bindUI() {
        let output = viewModel.transform()
        
        /// 헤더
        output.weatherHeaderBehavior
            .asDriver(onErrorJustReturn: WeatherHeader(
                cityName: "날씨 정보를 불러올 수 없음",
                currentTemperature: 0,
                maxTemperature: 0,
                minTemperature: 0,
                weatherDescription: "날씨 정보를 불러올 수 없음")
            )
            .drive(onNext: { [weak self] info in
                self?.locationLabel.text = info.cityName
                self?.weatherLabel.text = info.weatherDescription
                self?.temperatureAreaLabel.text = "최저 \(info.minTemperature)°C ~ 최고 \(info.maxTemperature)°C"
                self?.temperatureLabel.text = "\(info.currentTemperature)°C"
            })
            .disposed(by: disposeBag)
        
        /// 리스트
        output.weatherListBehavior
            .bind(to: tableView.rx.items(
                cellIdentifier: MainTableViewCell.identifier,
                cellType: MainTableViewCell.self)
            ) { index, item, cell in
                cell.configureCell(data: item)
            }
            .disposed(by: disposeBag)
        
        /// 에러 처리
        output.errorPublished
            .withUnretained(self)
            .subscribe(onNext: { (safeSelf, error) in
                let alertController = UIAlertController(title: "", message: error.errorDescription, preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                    exit(0)
                }
                alertController.addAction(confirmAction)
                safeSelf.present(alertController, animated: true)
                
        })
        .disposed(by: disposeBag)
    }
}

//MARK: - SearchContorller Delegate
extension MainViewController: SearchViewControllerDelegate {
    func refreshCurrentWeatherInCity(city: City) {
        dismiss(animated: true)
        viewModel.input.actionWeatherInfo.accept(city.id)
    }
}
//MARK: - Preview
@available(iOS 17.0, *)
#Preview("Main화면") {
    UINavigationController(
        rootViewController: MainViewController(
            viewModel: MainViewModel(
                repository: MainRepository()
            )
        )
    )
}

