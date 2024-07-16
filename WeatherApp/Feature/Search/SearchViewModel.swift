//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/17/24.
//

import Foundation
import RxSwift
import RxRelay

final class SearchViewModel: ViewModelType {
    struct Input {
        
        /// 초기 로딩 액션
        let actionViewDidLoad = PublishRelay<Void>()
        
        /// 사용자 검색 액션
        let actionSearchedCity = PublishRelay<String>()
        
        /// 사용자 검색 취소버튼 클릭 액션
        let actionSearchCancelButtonClicked = PublishRelay<Void>()
    }
    struct Output {
        
        /// 필터 처리된 도시 정보 (실질적으로 보여줄 리스트 정보)
        let filteredCityListBehavior = BehaviorRelay<[City]>(value: [])
    }
    
    var input: Input
    var disposeBag = DisposeBag()
    
    /// 도시에 대한 원본 리스트 정보 (이 값을 통해 필터 처리를 진행)
    private var originalCityList: [City] = []
    
    init() {
        input = Input()
    }
    
    func transform() -> Output {
        let output = Output()
        
        /// 검색바 취소 버튼 클릭 시
        input.actionSearchCancelButtonClicked
            .withUnretained(self)
            .subscribe(onNext: { (safeSelf, _) in
                output.filteredCityListBehavior.accept(safeSelf.originalCityList)
            })
            .disposed(by: disposeBag)
        
        /// 검색 시
        input.actionSearchedCity
            .debounce(.microseconds(5), scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .withUnretained(self)
            .subscribe(onNext: { (safeSelf, text) in
                let filterdList = safeSelf.originalCityList.filter { $0.name.localizedCaseInsensitiveContains(text) }
                output.filteredCityListBehavior.accept(filterdList)
            })
            .disposed(by: disposeBag)
        
        /// 초기 로딩 시
        input.actionViewDidLoad
            .withUnretained(self)
            .subscribe(onNext: { (safeSelf, _) in
                guard let localJSONFile = Bundle.main.url(forResource: "city.list", withExtension: "json") else { return }
                do {
                    let data = try Data(contentsOf: localJSONFile)
                    let response = try JSONDecoder().decode([City].self, from: data)
                    safeSelf.originalCityList = response
                    output.filteredCityListBehavior.accept(safeSelf.originalCityList)
                }
                catch {
                    Log.error("response decode error")
                }
            })
            .disposed(by: disposeBag)
        
        return output
    }
}
