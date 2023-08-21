//
//  BriefingTab.swift
//  Briefing
//
//  Created by BoMin on 2023/08/19.
//

import UIKit

class BriefingTab: UIViewController {
    let network = Network()
    
    var rank_counts = 0
    var update_timestamp = ""
    
    let layout_nav = UIView()
    let layout_dates = UIView()
    let layout_mid = UIView()
    let layout_main = UIView()
    
    let label_descrip = UILabel()
    
    var ranks = [""]
    var topics: [String] = [""]
    var descrips: [String] = [""]
    
    let layout_table = UITableView()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .secondBlue
        
        getKeywordsData()
        
//        tabBarController?.tabBar.isHidden = false
        
        self.view.addSubviews(layout_nav, layout_dates, layout_mid, layout_main)
        
        setNav()
        setMid()
        setDates()
        setMain()
        
        layout_table.register(BriefingTableViewCell.self, forCellReuseIdentifier: BriefingTableViewCell.cellID)
        layout_table.reloadData()
        
        layout_table.dataSource = self
        layout_table.delegate = self
        
    }
    
    private func setNav() {
        let label_title = UILabel()
        let button_storage = UIButton()
        let button_setting = UIButton()
        
        layout_nav.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.141)
        }
        
        layout_nav.addSubviews(label_title, button_storage, button_setting)
        
        label_title.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().inset(self.view.frame.height * 0.02)
            make.leading.equalTo(self.view.frame.width * 0.076)
        }
        
        label_title.text = "Breifing"
        label_title.textColor = .white
        label_title.font = UIFont(name: "ProductSans-Regular", size: 24)
        label_title.textAlignment = .left
        label_title.numberOfLines = 1
        
        button_setting.snp.makeConstraints{ make in
            make.centerY.equalTo(label_title)
            make.trailing.equalToSuperview().inset(self.view.frame.width * 0.06)
            make.width.height.equalTo(25)
        }
        
        button_setting.setImage(UIImage(named: "setting"), for: .normal)
        button_setting.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        
        button_storage.snp.makeConstraints{ make in
            make.centerY.equalTo(label_title)
            make.trailing.equalTo(button_setting).inset(47)
            make.width.height.equalTo(25)
        }
        
        button_storage.setImage(UIImage(named: "storage"), for: .normal)
        button_storage.addTarget(self, action: #selector(scrapbookButtonTapped), for: .touchUpInside)
    }
    
    private func setDates() {
        layout_dates.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(layout_nav.snp.bottom)
            make.height.equalTo(self.view.frame.height * 0.058)
        }
        
        let dateSelectionView = CustomDateSelectionView(dates: ["00.00.01", "00.00.02", "00.00.03", "00.00.04", "00.00.05", "00.00.06", "00.00.07", "", ""])
        dateSelectionView.delegate = self
        
        layout_dates.addSubview(dateSelectionView)
        
        dateSelectionView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func setMid() {
        let label_today = UILabel()
        
        layout_mid.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(layout_dates.snp.bottom)
            make.height.equalTo(self.view.frame.height * 0.105)
        }
        
        layout_mid.addSubviews(label_today, label_descrip)
        
        label_today.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        label_today.text = "2023년 8월 7일"
        label_today.textColor = .white
        label_today.font = UIFont(name: "ProductSans-Bold", size: 15)
        label_today.textAlignment = .center
        label_today.numberOfLines = 1
        
        label_descrip.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label_today.snp.bottom).offset(5)
        }
        
        label_descrip.text = "오늘의 키워드 브리핑"
        label_descrip.textColor = .white
        label_descrip.font = UIFont(name: "ProductSans-Bold", size: 25)
        label_descrip.textAlignment = .center
        label_descrip.numberOfLines = 1
    }
    
    private func setMain() {
        let layout_info = UIView()
        
        layout_main.snp.makeConstraints{ make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(layout_mid.snp.bottom).offset(25)
        }
        
        layout_main.backgroundColor = .mainGray
        layout_main.layer.masksToBounds = true
        layout_main.layer.cornerRadius = 25
        layout_main.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        layout_main.addSubviews(layout_info, layout_table)
        
        layout_info.snp.makeConstraints{ make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.067)
        }
                
        let button_toggle = CustomToggleButton(onTitle: "Korea", offTitle: "Global")
        
        layout_info.addSubview(button_toggle)
        
        button_toggle.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(17)
            make.width.equalTo(150)
            make.height.equalTo(35)
        }
        
        button_toggle.layer.masksToBounds = true
        button_toggle.layer.cornerRadius = 17.5
        button_toggle.backgroundColor = .white
        button_toggle.addShadow(offset: CGSize(width: 0, height: 4),
                                color: .black,
                                radius: 5,
                                opacity: 0.1)
        
        let label_update = UILabel()
        
        layout_info.addSubview(label_update)
        
        label_update.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().inset(self.view.frame.width * 0.076)
            make.trailing.equalToSuperview().inset(17)
        }
        
        label_update.text = "Updated: \(update_timestamp)"
        label_update.font = UIFont(name: "ProductSans-Regular", size: 11)
        label_update.textColor = .thirdBlue
        label_update.textAlignment = .left
        
        layout_table.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(self.view.frame.height * 0.123)
            make.top.equalTo(layout_info.snp.bottom)
        }
        
        layout_table.rowHeight = 80
        layout_table.separatorStyle = .none
        layout_table.backgroundColor = .mainGray
        
    }
}

extension BriefingTab {
    @objc func scrapbookButtonTapped() {
        
        print("scrapbook tapped")
        let nextVC = Scrapbook()
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func settingButtonTapped() {
        print("setting tapped")
        let nextVC = Setting()
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension BriefingTab: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ranks.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BriefingTableViewCell.cellID, for: indexPath) as! BriefingTableViewCell
        
        cell.delegate = self
        
        cell.label_order.text = ranks[indexPath.row+1]
        cell.label_topic.text = topics[indexPath.row+1]
        cell.label_descript.text = descrips[indexPath.row+1]
        
        cell.configureOrderLabel(forIndex: indexPath.row)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}

extension BriefingTab: BriefingTableViewCellDelegate {
    func didTapLayoutMain(in cell: BriefingTableViewCell) {
        let nextVC = BriefingCard()
        
        if let indexPath = layout_table.indexPath(for: cell) {
            nextVC.order_num = indexPath.row + 1
        }
        
        nextVC.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension BriefingTab: CustomDateSelectionViewDelegate {
    func dateSelectionView(_ view: CustomDateSelectionView, didSelectDateAtIndex index: Int) {
        // 가장 최근 날짜가 아닌 경우
        if index != view.dates.count - 3 {
            label_descrip.text = "그날의 키워드 브리핑"
        } else {
            label_descrip.text = "오늘의 키워드 브리핑"
        }
    }
}

//MARK: - Extension for Network
extension BriefingTab {
    
    
    func getKeywordsData() {
        network.getKeywords(date: "2023-08-21", type: "korea", completion: { response in
            switch response {
            case .success(let data):
                guard let keywords = (data as? KeywordsData), let briefing = (data as? KeywordsData)?.briefings else { return }
                
                self.rank_counts = briefing.count
                self.update_timestamp = keywords.createdAt
                
                print("created at : ", keywords.createdAt)
                
                briefing.forEach{ item in
                    self.ranks.append(String(item.rank))
                    self.topics.append(item.title)
                    self.descrips.append(item.subtitle)
                }
                
            default:
                print("failed get keywords data")
            }
            
            self.layout_table.reloadData()
        })
    }
}

