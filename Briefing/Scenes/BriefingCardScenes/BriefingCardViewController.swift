//
//  BriefingCardViewController.swift
//  Briefing
//
//  Created by BoMin Lee on 2023/09/19.
//

import UIKit
import SnapKit

class BriefingCardViewController: UIViewController {
    private let networkManager = BriefingNetworkManager.shared
    let contentParagraphStyle = NSMutableParagraphStyle()
    var id: Int
    var briefingData: BriefingData? = nil
    
    private var navigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_left"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(goBackToHomeViewController), for: .touchUpInside)
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .productSans(size: 24)
        label.textColor = .briefingWhite
        return label
    }()
    
    private var scrapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "scrap_normal"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private var cardScrollView: UIView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.addShadow(offset: CGSize(width: 0, height: 4),
                       color: .black,
                       radius: 5,
                       opacity: 0.1)
        return view
    }()
    
    private var dateInformationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .thirdBlue
        label.textAlignment = .right
        label.font = .productSans(size: 14)
        
        return label
    }()
    
    private var topicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingNavy
        label.textAlignment = .left
        label.font = .productSans(size: 35, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private var subtopicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .briefingNavy
        label.textAlignment = .left
        label.font = .productSans(size: 17, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private var contextLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .briefingNavy
        label.textAlignment = .left
        label.font = .productSans(size: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    private var chatView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.briefingNavy.cgColor
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private var chatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = BriefingImageCollection.Card.briefChatBeta
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var chatLabel: UILabel = {
        let label = UILabel()
        label.text = BriefingStringCollection.Card.askBrief.localized
        label.textColor = .briefingNavy
        label.textAlignment = .left
        label.font = .productSans(size: 15, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private var chatBetaLabel: UILabel = {
        let label = UILabel()
        label.text = BriefingStringCollection.Card.beta.localized
        label.textColor = .briefingNavy
        label.textAlignment = .left
        label.font = .productSans(size: 7)
        label.numberOfLines = 1
        
        return label
    }()
    
    private var chatDetailsButton: UIButton = {
        let button = UIButton()
        
        
        return button
    }()
    
    private var relatedLabel: UILabel = {
        let label = UILabel()
        label.text = BriefingStringCollection.Card.relatedArticles.localized
        label.textColor = .briefingNavy
        label.textAlignment = .left
        label.font = .productSans(size: 15, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private var firstArticleView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.briefingNavy.cgColor
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private var secondArticleView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.briefingNavy.cgColor
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private var thirdArticleView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.briefingNavy.cgColor
        view.layer.cornerRadius = 10
        
        return view
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
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        self.view.backgroundColor = .briefingBlue
        self.titleLabel.text = "\(BriefingStringCollection.appName) #\(self.id)"
    }
    
    private func addSubviews() {
        self.view.addSubviews(navigationView, cardScrollView)
        
        self.navigationView.addSubviews(backButton, titleLabel, scrapButton)
        
        self.cardScrollView.addSubview(cardView)
        
        self.cardView.addSubviews(dateInformationLabel, topicLabel, subtopicLabel, contextLabel, chatView, relatedLabel, articleStackView)
        
        self.chatView.addSubviews(chatImageView, chatLabel, chatBetaLabel, chatDetailsButton)
        
        [self.firstArticleView, self.secondArticleView, self.thirdArticleView].forEach { articleStackView.addArrangedSubview($0) }
    }
    
    private func makeConstraint() {
        navigationView.snp.makeConstraints{ make in
//            make.top.equalTo(view).offset(50)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(titleLabel).offset(25)
            make.leading.trailing.equalTo(view)
        }
        
        backButton.snp.makeConstraints{ make in
            make.centerY.equalTo(navigationView)
            make.height.equalTo(titleLabel)
            make.width.equalTo(backButton.snp.height)
            make.leading.equalTo(navigationView).inset(21)
        }
        
        titleLabel.snp.makeConstraints{ make in
//            make.top.equalTo(navigationView).offset(6)
            make.centerY.equalTo(navigationView)
            make.centerX.equalTo(navigationView)
            make.trailing.lessThanOrEqualTo(scrapButton)
        }
        
        scrapButton.snp.makeConstraints{ make in
            make.centerY.equalTo(navigationView)
            make.height.equalTo(titleLabel)
            make.width.equalTo(scrapButton.snp.height)
            make.trailing.equalTo(navigationView).inset(18)
        }
        
        cardScrollView.snp.makeConstraints{ make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        cardView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().inset(17)
            make.bottom.equalToSuperview()
        }
        
        dateInformationLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().inset(12)
        }
        
        topicLabel.snp.makeConstraints{ make in
            make.top.equalTo(dateInformationLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(25)
        }
        
        subtopicLabel.snp.makeConstraints{ make in
            make.top.equalTo(topicLabel.snp.bottom).offset(12)
            make.leading.equalTo(topicLabel)
            make.trailing.equalToSuperview().inset(25)
        }
        
        contextLabel.snp.makeConstraints{ make in
            make.top.equalTo(subtopicLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(subtopicLabel)
        }
        
        chatView.snp.makeConstraints{ make in
            make.top.equalTo(contextLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().inset(23)
            make.height.equalTo(60)
            
        }
        
        chatImageView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(25)
        }
        
        chatLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(chatImageView.snp.trailing).offset(10)
            
        }
        
        chatBetaLabel.snp.makeConstraints{ make in
            make.leading.equalTo(chatLabel.snp.trailing).offset(2)
            make.bottom.equalTo(chatLabel.snp.centerY)
        }
        
        chatDetailsButton.snp.makeConstraints{ make in
            
        }
        
        relatedLabel.snp.makeConstraints{ make in
            make.top.equalTo(chatView.snp.bottom).offset(30)
            make.leading.trailing.equalTo(subtopicLabel)
        }
        
        articleStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(relatedLabel.snp.bottom).offset(11)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().inset(23)
            make.bottom.equalToSuperview().inset(25)
        }
        
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
        
    }
    
    @objc func goBackToHomeViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func fetchBriefingCard() {
        networkManager.fetchBriefingCard(id: self.id) { [weak self] value, error in
            if let error = error {
                self?.errorHandling(error)
                return
            }
            
            self?.briefingData = value
                    
            
//            if let briefCardDate = value?.date {
//                let briefCardDateFormat = BriefingStringCollection.Format.dateDotShortFormat
//                let briefCardDateString = briefCardDate.
//            }
            
            self?.updateBriefingCard()
        }
    }
    
    private func updateBriefingCard() {
        if let briefCardDate = self.briefingData?.date {
            self.dateInformationLabel.text = "\(briefCardDate) #\(self.id)"
        }
        
        self.topicLabel.text = self.briefingData?.title
        self.subtopicLabel.text = self.briefingData?.subTitle
        
        contentParagraphStyle.lineHeightMultiple = 1.37
        
        if let briefCardContent = self.briefingData?.content {
            self.contextLabel.attributedText = NSAttributedString(string: briefCardContent, attributes: [NSAttributedString.Key.paragraphStyle: contentParagraphStyle])
        }
        
    }
    
    private func errorHandling(_ error: Error) {
        print("error: \(error)")
    }
}