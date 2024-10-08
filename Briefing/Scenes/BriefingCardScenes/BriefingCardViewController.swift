//
//  BriefingCardViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 2023/09/19.
//

import UIKit
import SnapKit
import GoogleMobileAds
import RxSwift

class BriefingCardViewController: UIViewController {
    private let networkManager = BriefingNetworkManager.shared
    let contentParagraphStyle = NSMutableParagraphStyle()
    var id: Int
    var briefingData: BriefingData? = nil
    var isScrap: Bool = false
    
    private let disposeBag = DisposeBag()
    
    private var navigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.backIconBlackImage, for: .normal)
        button.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(goBackToHomeViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var othersButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.othersIconBlackImage, for: .normal)
        button.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .right
        button.isHidden = true
//        button.addTarget(self, action: #selector(othersButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var cardScrollView: UIView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var cardView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var topicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .productSans(size: 30, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private var informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingLightGray
        label.textAlignment = .left
        label.font = .productSans(size: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private var dateInformationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingLightGray
        label.textAlignment = .left
        label.font = .productSans(size: 13)
        return label
    }()
    
    private var categoryInformationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingLightGray
        label.textAlignment = .left
        label.font = .productSans(size: 13)
        return label
    }()
    
    private var generateInformationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingLightGray
        label.textAlignment = .left
        label.font = .productSans(size: 13)
        return label
    }()
    
    private var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        
        return stackView
    }()
    
    private var scrapNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingLightGray
        label.textAlignment = .center
        label.font = .productSans(size: 13)
//        label.text = "1352"
        
        return label
    }()
    
    private lazy var scrapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "scrap_normal"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(scrappButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private var lineSeparatorView1: UIView = {
        let view = UIView()
        view.backgroundColor = .briefingGray
        view.isHidden = true

        return view
    }()
    
    private var subtopicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .productSans(size: 17, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private var contextLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .left
        label.font = .productSans(size: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    private var lineSeparatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = .briefingGray
        view.isHidden = true
        return view
    }()
    
    private var relatedLabel: UILabel = {
        let label = UILabel()
//        label.text = BriefingStringCollection.Card.relatedArticles.localized
        label.textColor = .black
        label.textAlignment = .left
        label.font = .productSans(size: 20, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private var firstArticleView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        
        return view
    }()
    
    private var firstArticlePressLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 13, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private var firstArticleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 15)
        label.numberOfLines = 1
        label.textColor = .black
        
        return label
    }()
    
    private var firstArticleDetailButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.nextIconImage, for: .normal)
        return button
    }()
    
    private var secondArticleView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        
        return view
    }()
    
    private var secondArticlePressLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 13, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private var secondArticleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 15)
        label.numberOfLines = 1
        label.textColor = .black
        
        return label
    }()
    
    private var secondArticleDetailButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.nextIconImage, for: .normal)
        return button
    }()
    
    private var thirdArticleView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        
        return view
    }()
    
    private var thirdArticlePressLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 13, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private var thirdArticleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 15)
        label.numberOfLines = 1
        label.textColor = .black
        
        return label
    }()
    
    private var thirdArticleDetailButton: UIButton = {
        let button = UIButton()
        button.setImage(BriefingImageCollection.nextIconImage, for: .normal)
        return button
    }()
    
    private lazy var bannerView: GADBannerView = {
        let bannerView = addBannerAdView()
        bannerView.delegate = self
        return bannerView
    }()
    
    private var articleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        return stackView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        makeConstraint()
        fetchBriefingCard()
    }
    
    init(id: Int){
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        addSwipeGestureToDismiss()
    }
    
    private func addSubviews() {
        self.view.addSubviews(navigationView, cardScrollView, bannerView)
        
        self.navigationView.addSubviews(backButton, othersButton)
        
//        [self.dateInformationLabel, self.categoryInformationLabel, self.generateInformationLabel].forEach { informationStackView.addArrangedSubview($0) }
        
        self.cardScrollView.addSubviews(cardView)
        
        self.cardView.addSubviews(topicLabel, informationLabel, scrapButton, scrapNumberLabel, lineSeparatorView1, subtopicLabel, contextLabel, lineSeparatorView2, relatedLabel, articleStackView)
        
    }
    
    private func makeConstraint() {
        navigationView.snp.makeConstraints{ make in
            make.top.equalTo(view)
//            make.bottom.equalTo(backButton).offset(4)
            make.height.equalTo(90)
            make.leading.trailing.equalTo(view)
        }
        
        backButton.snp.makeConstraints{ make in
            make.bottom.equalTo(navigationView).inset(4)
            make.height.equalTo(33)
            make.width.equalTo(backButton.snp.height)
            make.leading.equalTo(navigationView).inset(19)
        }
        
        othersButton.snp.makeConstraints{ make in
            make.centerY.equalTo(backButton)
            make.height.equalTo(backButton)
            make.width.equalTo(othersButton.snp.height)
            make.trailing.equalTo(navigationView).inset(30)
        }
        
        cardScrollView.snp.makeConstraints{ make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            //MARK: Check bottom constraints
            make.bottom.equalTo(bannerView.snp.top)
        }
        
        cardView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().inset(31)
            make.bottom.equalToSuperview()
        }
        
        topicLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview()
            make.trailing.equalTo(scrapButton.snp.leading)
        }

        scrapButton.snp.makeConstraints{ make in
            make.centerY.equalTo(topicLabel.snp.bottom)
            make.height.equalTo(41)
            make.width.equalTo(scrapButton.snp.height)
            make.trailing.equalTo(othersButton.snp.trailing)
        }
        
        scrapNumberLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(scrapButton.snp.top)
            make.centerX.equalTo(scrapButton)
        }
        
        informationLabel.snp.makeConstraints{ make in
            make.leading.equalTo(topicLabel)
            make.trailing.equalTo(self.scrapButton.snp.leading)
            make.top.equalTo(topicLabel.snp.bottom).offset(8)
        }
        
        lineSeparatorView1.snp.makeConstraints{ make in
            make.top.equalTo(informationLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(10)
            make.height.equalTo(1)
        }
        
        subtopicLabel.snp.makeConstraints{ make in
            make.top.equalTo(lineSeparatorView1.snp.bottom).offset(20)
            make.leading.equalTo(topicLabel)
            make.trailing.equalToSuperview()
        }
        
        contextLabel.snp.makeConstraints{ make in
            make.top.equalTo(subtopicLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(subtopicLabel)
        }
        
        lineSeparatorView2.snp.makeConstraints{ make in
            make.top.equalTo(contextLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(10)
            make.height.equalTo(1)
        }
        
        relatedLabel.snp.makeConstraints{ make in
            make.top.equalTo(lineSeparatorView2.snp.bottom).offset(18)
            make.leading.trailing.equalTo(subtopicLabel)
        }
//        
        articleStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(relatedLabel.snp.bottom).offset(11)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(25)
        }
        
        bannerView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func goBackToHomeViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func scrappButtonTapped() {
        self.scrapBriefingCard()
    }
    
    @objc func openFirstArticleURL() {
        if let firstArticleURL = self.briefingData?.articles[0].url {
            openURLInSafari(firstArticleURL)
        }
    }
    
    @objc func openSecondArticleURL() {
        if let secondArticleURL = self.briefingData?.articles[1].url {
            openURLInSafari(secondArticleURL)
        }
    }
    
    @objc func openThirdArticleURL() {
        if let thirdArticleURL = self.briefingData?.articles[2].url {
            openURLInSafari(thirdArticleURL)
        }
    }
    
    private func fetchBriefingCard() {
        
        networkManager.fetchBriefingCard(id: id)
            .subscribe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, briefingData in
                owner.briefingData = briefingData
                owner.isScrap = briefingData.isScrap
                owner.setBriefingCard()
                UIView.animate(withDuration: 0.5) {
                    self.updateBriefingCard()
                    self.adjustArticles()
                    self.view.layoutIfNeeded()
                }
            } onFailure: { owner, error in
                owner.errorHandling(error)
            }
            .disposed(by: disposeBag)
    }
    
    private func scrapBriefingCard() {
        if isScrap {
            networkManager.deleteScrapBriefing(id: id)
                .subscribe(with: self) { owner, scrapResult in
                    owner.scrapResultCompletion(scrapResult)
                } onFailure: { owner, error in
                    owner.scrapResultCompletion(nil, error)
                }
                .disposed(by: disposeBag)

        } else {
            networkManager.scrapBriefing(id: id)
                .subscribe(with: self) { owner, scrapResult in
                    owner.scrapResultCompletion(scrapResult)
                } onFailure: { owner, error in
                    owner.scrapResultCompletion(nil, error)
                }
                .disposed(by: disposeBag)
        }
    }
    
    private func scrapResultCompletion(_ result: ScrapResult?, _ error: Error? = nil) {
        if let error = error {
            self.errorHandling(error)
            return
        }
        guard let isScrap = result?.isScrap else { return }
        self.isScrap = isScrap
        
        self.fetchBriefingCard()
        self.updateBriefingCard()
    }
    
    private func setBriefingCard() {
        guard let briefingData = briefingData else { return }
        
        self.topicLabel.text = briefingData.title
        
        // MARK: ToDo: id를 morning/evening으로 변경. 00을 분야명으로 변경.
        self.informationLabel.text = "\(briefingData.date) \(briefingData.timeOfDay.localize())  |  \(briefingData.type.localize()) #\(briefingData.ranks)  |  \(briefingData.gptModel)로 생성됨"
        
//        self.dateInformationLabel.text = "\(briefingData.date) #\(self.id)"
//        self.categoryInformationLabel.text = "00 #\(briefingData.ranks)"
//        self.generateInformationLabel.text = "\(briefingData.gptModel)로 생성됨"
        
        self.scrapNumberLabel.text = "\(briefingData.scrapCount)"
        
        self.lineSeparatorView1.isHidden = false
        
    }
    
    private func updateBriefingCard() {
        self.scrapButton.isHidden = false
        
//        self.lineSeparatorView1.isHidden = false
        self.lineSeparatorView2.isHidden = false
        
        self.relatedLabel.text = BriefingStringCollection.Card.relatedArticles.localized
        
        guard let briefingData = briefingData else { return }
        
//        self.topicLabel.text = briefingData.title
        
//        self.dateInformationLabel.text = "\(briefingData.date) #\(id)"
//        self.categoryInformationLabel.text = "00 #\(briefingData.ranks)"
//        self.generateInformationLabel.text = "GPT-4로 생성됨"
    
        self.subtopicLabel.text = briefingData.subTitle
        
        // Fetch Scrap
        self.scrapNumberLabel.text = "\(briefingData.scrapCount)"
        if briefingData.isScrap {
            self.scrapButton.setImage(BriefingImageCollection.scrapFilledImage, for: .normal)
        }
        else {
            self.scrapButton.setImage(BriefingImageCollection.scrapUnfilledImage, for: .normal)
        }
    
        
        self.contentParagraphStyle.lineHeightMultiple = 1.37
        let contextLabelAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.paragraphStyle: self.contentParagraphStyle
        ]
        self.contextLabel.attributedText = NSAttributedString(string: briefingData.content,
                                                              attributes: contextLabelAttributes)
    }
    
    private func adjustArticles() {
        if let articles = self.briefingData?.articles {
            firstArticleView.addSubview(firstArticleDetailButton)
            secondArticleView.addSubview(secondArticleDetailButton)
            thirdArticleView.addSubview(thirdArticleDetailButton)
            
            firstArticleDetailButton.snp.makeConstraints{ make in
                make.width.height.equalTo(27)
                make.trailing.equalToSuperview().inset(7)
                make.centerY.equalToSuperview()
            }
            
            secondArticleDetailButton.snp.makeConstraints{ make in
                make.width.height.equalTo(27)
                make.trailing.equalToSuperview().inset(7)
                make.centerY.equalToSuperview()
                
            }
            
            thirdArticleDetailButton.snp.makeConstraints{ make in
                make.width.height.equalTo(27)
                make.trailing.equalToSuperview().inset(7)
                make.centerY.equalToSuperview()
                
            }
            
            let firstArticleTapGesture = UITapGestureRecognizer(target: self, action: #selector(openFirstArticleURL))
            let secondArticleTapGesture = UITapGestureRecognizer(target: self, action: #selector(openSecondArticleURL))
            let thirdArticleTapGesture = UITapGestureRecognizer(target: self, action: #selector(openThirdArticleURL))
            
            switch articles.count {
            case 1:
                firstArticlePressLabel.text = articles[0].press
                firstArticleTitleLabel.text = articles[0].title
                
                [self.firstArticleView].forEach { articleStackView.addArrangedSubview($0) }
                
                firstArticleView.snp.makeConstraints{ make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(60)
                }
                
                firstArticleView.addSubviews(firstArticlePressLabel, firstArticleTitleLabel)
                
                firstArticlePressLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalToSuperview().offset(9)
                    make.trailing.lessThanOrEqualTo(firstArticleDetailButton.snp.leading)
                }
                
                firstArticleTitleLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalTo(firstArticlePressLabel.snp.bottom).offset(6)
                    make.trailing.lessThanOrEqualTo(firstArticleDetailButton.snp.leading)
                }
                
                firstArticleView.addGestureRecognizer(firstArticleTapGesture)
            case 2:
                firstArticlePressLabel.text = articles[0].press
                firstArticleTitleLabel.text = articles[0].title
                secondArticlePressLabel.text = articles[1].press
                secondArticleTitleLabel.text = articles[1].title
                
                [self.firstArticleView, self.secondArticleView].forEach { articleStackView.addArrangedSubview($0) }
                
                firstArticleView.snp.makeConstraints{ make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(60)
                }
                
                secondArticleView.snp.makeConstraints{ make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(60)
                }
                
                firstArticleView.addSubviews(firstArticlePressLabel, firstArticleTitleLabel)
                secondArticleView.addSubviews(secondArticlePressLabel, secondArticleTitleLabel)
                
                firstArticlePressLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalToSuperview().offset(9)
                    make.trailing.lessThanOrEqualTo(firstArticleDetailButton.snp.leading)
                }
                
                firstArticleTitleLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalTo(firstArticlePressLabel.snp.bottom).offset(6)
                    make.trailing.lessThanOrEqualTo(firstArticleDetailButton.snp.leading)
                }
                
                secondArticlePressLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalToSuperview().offset(9)
                    make.trailing.lessThanOrEqualTo(secondArticleDetailButton.snp.leading)
                }
                
                secondArticleTitleLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalTo(secondArticlePressLabel.snp.bottom).offset(6)
                    make.trailing.lessThanOrEqualTo(secondArticleDetailButton.snp.leading)
                }
                
                firstArticleView.addGestureRecognizer(firstArticleTapGesture)
                secondArticleView.addGestureRecognizer(secondArticleTapGesture)
                
            case 3:
                firstArticlePressLabel.text = articles[0].press
                firstArticleTitleLabel.text = articles[0].title
                secondArticlePressLabel.text = articles[1].press
                secondArticleTitleLabel.text = articles[1].title
                thirdArticlePressLabel.text = articles[2].press
                thirdArticleTitleLabel.text = articles[2].title
                
                [self.firstArticleView, self.secondArticleView, self.thirdArticleView].forEach { articleStackView.addArrangedSubview($0) }
                
                firstArticleView.snp.makeConstraints{ make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(60)
                }
                
                secondArticleView.snp.makeConstraints{ make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(60)
                }
                
                thirdArticleView.snp.makeConstraints{ make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(60)
                }
                
                firstArticleView.addSubviews(firstArticlePressLabel, firstArticleTitleLabel)
                secondArticleView.addSubviews(secondArticlePressLabel, secondArticleTitleLabel)
                thirdArticleView.addSubviews(thirdArticlePressLabel, thirdArticleTitleLabel)
                
                firstArticlePressLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalToSuperview().offset(9)
                    make.trailing.lessThanOrEqualTo(firstArticleDetailButton.snp.leading)
                }
                
                firstArticleTitleLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalTo(firstArticlePressLabel.snp.bottom).offset(6)
                    make.trailing.lessThanOrEqualTo(firstArticleDetailButton.snp.leading)
                }
                
                secondArticlePressLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalToSuperview().offset(9)
                    make.trailing.lessThanOrEqualTo(secondArticleDetailButton.snp.leading)
                }
                
                secondArticleTitleLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalTo(secondArticlePressLabel.snp.bottom).offset(6)
                    make.trailing.lessThanOrEqualTo(secondArticleDetailButton.snp.leading)
                }
                
                thirdArticlePressLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalToSuperview().offset(9)
                    make.trailing.lessThanOrEqualTo(thirdArticleDetailButton.snp.leading)
                }
                
                thirdArticleTitleLabel.snp.makeConstraints{ make in
                    make.leading.equalToSuperview().offset(13)
                    make.top.equalTo(thirdArticlePressLabel.snp.bottom).offset(6)
                    make.trailing.lessThanOrEqualTo(thirdArticleDetailButton.snp.leading)
                }
                
                firstArticleView.addGestureRecognizer(firstArticleTapGesture)
                secondArticleView.addGestureRecognizer(secondArticleTapGesture)
                thirdArticleView.addGestureRecognizer(thirdArticleTapGesture)
                
            default:
                print("Article count out of range.")
            }
        }
    }
    
    private func errorHandling(_ error: Error) {
        print("error: \(error)")
    }
}

extension BriefingCardViewController: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
}

