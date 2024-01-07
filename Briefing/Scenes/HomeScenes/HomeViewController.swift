//
//  HomeViewController.swift
//  Briefing
//
//  Created by 이전희 on 2023/09/16.
//

import UIKit
import RxSwift
import RxRelay
import GoogleMobileAds

final class HomeViewController: UIViewController {
    let tabBarIcon: UIImage = BriefingImageCollection.briefingTabBarNormalIconImage
    let tabBarSelectedIcon: UIImage = BriefingImageCollection.briefingTabBarSelectedIconImage
    
    let categories: [BriefingCategory] = [
        .social,
        .global,
        .economy,
        .science
    ]
    let disposeBag: DisposeBag = DisposeBag()
    
    lazy var selectedCategoryRelay: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    private var navigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var titleLabel: UIView = {
        let label = UILabel()
        label.text = BriefingStringCollection.appName
        label.font = .productSans(size: 24, weight: .bold)
        label.textColor = .bfPrimaryBlue
        return label
    }()
    
    private lazy var scrapButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.scrapImage, for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(showScrapBookViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.settingImage, for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(showSettingViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var categorySelectionView: CategorySelectionView = {
        let categorySelectionView = CategorySelectionView(categories: categories,
                                                          selectedCategoryRelay: selectedCategoryRelay)
        return categorySelectionView
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal)
        return pageViewController
    }()
    
    lazy var pageChildViewControllers: [UIViewController] = {
        categories.map { category in
            HomeBriefingViewController(category: category)
        }
    }()
    
    private lazy var bannerView = {
        let bannerView = addBannerAdView()
        bannerView.delegate = self
        return bannerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraints()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configure() {
        view.backgroundColor = .bfWhite
        navigationItem.title = BriefingStringCollection.appName
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        addChild(pageViewController)
        pageViewController.setViewControllers([pageChildViewControllers[0]],
                                              direction: .forward,
                                              animated: true)
    }
    
    private func addSubviews() {
        let navigationSubviews: [UIView] = [titleLabel,
                                            scrapButton,
                                            settingButton]
        navigationSubviews.forEach { subView in
            navigationView.addSubview(subView)
        }
        
        let subViews: [UIView] = [navigationView,
                                  categorySelectionView,
                                  pageViewController.view,
                                  bannerView]
        subViews.forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(titleLabel).offset(6)
            make.leading.trailing.equalTo(view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView).offset(6)
            make.centerY.equalTo(navigationView)
            make.leading.equalTo(navigationView).inset(28)
            make.trailing.lessThanOrEqualTo(scrapButton)
        }
        
        scrapButton.snp.makeConstraints { make in
            make.height.equalTo(navigationView)
            make.width.equalTo(scrapButton.snp.height)
            make.trailing.equalTo(settingButton.snp.leading).offset(-2)
            make.centerY.equalTo(navigationView)
        }
        
        settingButton.snp.makeConstraints { make in
            make.height.equalTo(navigationView)
            make.width.equalTo(settingButton.snp.height)
            make.trailing.equalTo(navigationView).inset(18)
            make.centerY.equalTo(navigationView)
        }
        
        categorySelectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(28)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(categorySelectionView.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(bannerView.snp.top)
        }
        
        bannerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
        }
    }
    
    func bind() {
        selectedCategoryRelay
            .subscribe(onNext:  { [weak self] categoryIndex in
                guard let self = self else { return }
                if let prevSelectedViewCategory = (pageViewController.viewControllers?.first
                                                   as? HomeBriefingViewController)?.category {
                    let prevCategoryIndex: Int = categories.firstIndex(of: prevSelectedViewCategory) ?? 0
                    if prevSelectedViewCategory != categories[categoryIndex] {
                        let direction: UIPageViewController.NavigationDirection = categoryIndex > prevCategoryIndex ? .forward : .reverse
                        pageViewController.setViewControllers([pageChildViewControllers[categoryIndex]],
                                                              direction: direction,
                                                              animated: true)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc func showScrapBookViewController() {
        if let _ = BriefingAuthManager.shared.member {
            self.navigationController?.pushViewController(ScrapbookViewController(), animated: true)
        } else {
            let title = BriefingStringCollection.Popup.signInRequired.localized
            let description = BriefingStringCollection.Popup.signInRequiredDescription.localized
            let cancel = BriefingStringCollection.cancel
            let confirm = BriefingStringCollection.Setting.signIn.localized
            let popupViewController = BriefingPopUpViewController(index: 0,
                                                                  title: title,
                                                                  description: description,
                                                                  buttonTitles:[cancel, confirm],
                                                                  style: .twoButtonsDefault)
            popupViewController.modalPresentationStyle = .overFullScreen
            popupViewController.delegate = self
            self.present(popupViewController, animated: false)
        }
    }
    
    @objc func showSettingViewController() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
}

extension HomeViewController: BriefingPopUpDelegate {
    func cancelButtonTapped(_ popupViewController: BriefingPopUpViewController) { }
    
    func confirmButtonTapped(_ popupViewController: BriefingPopUpViewController) {
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }
}

extension  HomeViewController: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
}
