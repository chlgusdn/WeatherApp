//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import UIKit

/// 검색화면에 대한 델리게이트
protocol SearchViewControllerDelegate: AnyObject {
    
    /// 셀 클릭 시 날씨 화면 리프레시 함수
    /// - Parameter city: 도시 정보
    func refreshCurrentWeatherInCity(city: City)
}

/// 검색 화면
final class SearchViewController: BaseViewController {
    
    /// 검색화면을 그릴 테이블 뷰
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.layer.cornerRadius = 25
        tableView.separatorStyle = .none
        tableView.rowHeight = 40
        tableView.register(
            SearchViewTableViewCell.self,
            forCellReuseIdentifier: SearchViewTableViewCell.identifier
        )
        return tableView
    }()
    
    private let viewModel: SearchViewModel
    
    weak var delegate: SearchViewControllerDelegate?
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input.actionViewDidLoad.accept(())
    }
    
    override func setProperty() {
        navigationItem.setupSearchController(
            title: "도시 검색",
            placeholder: "도시이름을 검색하세요"
        )
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.searchController?.searchBar.delegate = self
    }
    
    override func setLayout() {
        view.addSubview(tableView)
    }
    
    override func setConstraint() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func bindUI() {
        let output = viewModel.transform()
        
        tableView.rx
            .modelSelected(City.self)
            .withUnretained(self)
            .subscribe(onNext: { (safeSelf, city) in
                safeSelf.delegate?.refreshCurrentWeatherInCity(city: city)
            })
            .disposed(by: disposeBag)
        
        output.filteredCityListBehavior.bind(to: tableView.rx.items(cellIdentifier: SearchViewTableViewCell.identifier, cellType: SearchViewTableViewCell.self)) { index, item, cell in
            cell.configureCell(data: item)
        }
        .disposed(by: disposeBag)
        
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.input.actionSearchCancelButtonClicked.accept(())
    }
}

//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.input.actionSearchedCity.accept(searchController.searchBar.text ?? "")
    }
}
