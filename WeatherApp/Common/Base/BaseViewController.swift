//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by NUNU:D on 7/15/24.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

/// Feature개발 시 기본적으로 사용될 베이스 컨트롤러
class BaseViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Log.debug("init class in \(String(describing: self))")
        setUpUI()
        
    }
    
    /// 뷰 컨트롤러에 사용될 프로퍼티를 정의할 함수입니다
    func setProperty() {}
    /// 뷰 컨트롤러에 사용될 서브뷰를 정의할 함수입니다.
    /// ```
    /// func setLayout() {
    ///     view.addSubView(etcView)
    /// }
    /// ```
    func setLayout() {}
    
    /// 뷰 컨트롤러에 사용될 서브뷰의 제약조건을 정의할 함수입니다.
    func setConstraint() {}
    
    /// ViewModel과 바인딩할 함수입니다.
    func bindUI() {}
    
    /// Property, Layout, bindUI 함수를 한번에 불러올 함수입니다.
    private func setUpUI() {
        setProperty()
        setLayout()
        setConstraint()
        bindUI()
    }
    
    deinit {
        Log.debug("deinit class in \(String(describing: self))")
    }
}
