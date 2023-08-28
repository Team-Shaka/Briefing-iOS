//
//  BriefingCard.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import UIKit

class BriefingCard: UIViewController {
    let network = Network()
    
    var isScrapped = false
    
    let layout_nav = UIView()
    let button_scrap = UIButton()
    let layout_table = UITableView()
    
    var order_num = 0
    var brief_rank = ""
    var brief_date = ""
    var brief_id = ""
    var brief_title = ""
    var brief_sub = ""
    var brief_content = ""
    var article_press = ["", "", ""]
    var article_titles = ["", "", ""]
    var article_urls = ["", "", ""]
    
    override func viewDidLoad() {
//        self.view.backgroundColor = .secondBlue
        self.view.setGradient(color1: .secondBlue, color2: .mainBlue)
        
        print(brief_id)
        
        //MARK: GET BriefingCard Call
        getBriefingCardData(id: self.brief_id)
        
        navigationController?.isNavigationBarHidden = true
//        tabBarController?.tabBar.isHidden = true
        
        self.view.addSubviews(layout_nav, layout_table)
        
        layout_table.register(BriefingCardCell.self, forCellReuseIdentifier: BriefingCardCell.cellID)
        layout_table.reloadData()
        
        layout_table.dataSource = self
        layout_table.delegate = self
                
        setNav()
        setCard()
    }
    
    private func setNav() {
        let label_title = UILabel()
        let button_back = UIButton()
        
        layout_nav.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.141)
        }
        
        layout_nav.addSubviews(label_title, button_back, button_scrap)
        
        label_title.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(15)
        }
        
        label_title.text = "Breifing #\(brief_rank)"
        label_title.textColor = .white
        label_title.font = UIFont(name: "ProductSans-Regular", size: 24)
        label_title.textAlignment = .center
        label_title.numberOfLines = 1
        
        button_back.snp.makeConstraints{ make in
            make.centerY.equalTo(label_title)
            make.leading.equalToSuperview().offset(self.view.frame.width * 0.076)
            make.width.height.equalTo(25)
        }
        
        button_back.setImage(UIImage(named: "arrow_left"), for: .normal)
        button_back.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        button_scrap.snp.makeConstraints{ make in
            make.centerY.equalTo(label_title)
            make.trailing.equalToSuperview().inset(self.view.frame.width * 0.076)
            make.width.height.equalTo(25)
        }
        
        if isScrapped {
            button_scrap.setImage(UIImage(named: "scrap_selected"), for: .normal)
        } else {
            button_scrap.setImage(UIImage(named: "scrap_normal"), for: .normal)
        }
//        button_scrap.setImage(UIImage(named: "scrap_normal"), for: .normal)
        button_scrap.addTarget(self, action: #selector(scrapButtonTapped), for: .touchUpInside)
    }
    
    private func setCard() {
        layout_table.snp.makeConstraints{ make in
            make.top.equalTo(layout_nav.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
//        layout_table.backgroundColor = .secondBlue
//        layout_table.setGradient(color1: .secondBlue, color2: .mainBlue)
        layout_table.backgroundColor = .clear
        
        layout_table.separatorStyle = .none
        //MARK: Todo: 개수에 따라 변경해야 함
        layout_table.rowHeight = UITableView.automaticDimension
//        layout_table.rowHeight = 520
    }
}

extension BriefingCard {
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func scrapButtonTapped() {
        if isScrapped {
            deleteFile(withName: "\(brief_date)#\(brief_rank).txt")
            button_scrap.setImage(UIImage(named: "scrap_normal"), for: .normal)
            isScrapped = false
        } else {
            //MARK: Text File Test
            let sampleStrings = [brief_id, brief_rank, brief_date, brief_title, brief_sub]
            createTextFile(withName: "\(brief_date)#\(brief_rank).txt", containing: sampleStrings)
            print(sampleStrings)
            button_scrap.setImage(UIImage(named: "scrap_selected"), for: .normal)
            isScrapped = true
        }
//        print(isScrapped)
//        print(brief_id)
//        print(brief_title)
//        print(brief_sub)
    }
    
    @objc func openNews1() {
        print("news 1 tapped")
        openURLInSafari(article_urls[0])
    }
    
    @objc func openNews2() {
        openURLInSafari(article_urls[1])
    }
    
    @objc func openNews3() {
        openURLInSafari(article_urls[2])
    }
}

extension BriefingCard: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BriefingCardCell.cellID, for: indexPath) as! BriefingCardCell
        
//        print("Here: ", article_titles)
        cell.newsArray = article_titles
        
        cell.controlNewsCount(news: article_titles)
        
        cell.label_info.text = "\(self.brief_date) Briefing #\(brief_rank)"
        cell.label_topic.text = self.brief_title
        cell.label_sub.text = self.brief_sub
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        
        
        cell.label_context.attributedText = NSMutableAttributedString(string: brief_content, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        
        cell.label_press1.text = self.article_press[0]
        cell.label_news_title1.text = self.article_titles[0]

        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(openNews1))
        cell.layout_news1.addGestureRecognizer(tapGesture1)
        cell.layout_news1.isUserInteractionEnabled = true

        cell.label_press2.text = self.article_press[1]
        cell.label_news_title2.text = self.article_titles[1]

        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(openNews2))
        cell.layout_news2.addGestureRecognizer(tapGesture2)
        cell.layout_news2.isUserInteractionEnabled = true

        cell.label_press3.text = self.article_press[2]
        cell.label_news_title3.text = self.article_titles[2]

        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(openNews3))
        cell.layout_news3.addGestureRecognizer(tapGesture3)
        cell.layout_news3.isUserInteractionEnabled = true
        
//        cell.layout_news2.isUserInteractionEnabled = !cell.layout_news2.isHidden
//        cell.layout_news3.isUserInteractionEnabled = !cell.layout_news3.isHidden

        
        return cell
    }
    
    
}

//MARK: - Extension for Network
extension BriefingCard {
    func getBriefingCardData(id: String) {
        network.getBriefingCard(id: id, completion: { response in
            switch response {
            case .success(let data):
                guard let card = (data as? BriefingCardData), let article = (data as? BriefingCardData)?.articles else { return }
                
                self.brief_content = card.content
                self.brief_date = card.date
                self.brief_rank = String(card.rank)
                
//                article.forEach{ item in
//                    self.article_press[$0] = item.press
//                    self.article_titles.append(item.title)
//                    self.article_urls.append(item.url)
//                    print(item.url)
//                }
                
                article.enumerated().forEach { (index, item) in
                    self.article_press[index] = item.press
                    self.article_titles[index] = item.title
                    self.article_urls[index] = item.url
                    print(item.url)
                }
                
                
            case .networkFail:
                print("network failed - keywords")
                
            case .badRequest:
                print("bad request - keywords")
                
            case .decodeFail:
                print("decode fail - keywords")
                
            default:
                print("failed to get keywords data")
            }
            
            self.layout_table.reloadData()
        })
    }
}
