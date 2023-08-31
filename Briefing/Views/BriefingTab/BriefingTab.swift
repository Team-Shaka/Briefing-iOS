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
    
    let pickBarView = UIView()
    
    let label_update = UILabel()
    let label_descrip = UILabel()
    let label_today = UILabel()
    
    let dateSelectionView = CustomDateSelectionView(dates: getLastWeekDates())
    let button_toggle = CustomToggleButton(onTitle: "Korea", offTitle: "Global")
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var ranks = ["", "", "", "", "", "", "", "", "", ""]
    var IDs = ["", "", "", "", "", "", "", "", "", "", ""]
    var topics: [String] = ["", "", "", "", "", "", "", "", "", ""]
    var descrips: [String] = ["", "", "", "", "", "", "", "", "", ""]
    
    let layout_table = UITableView()
    
    override func viewDidLoad() {
        self.view.setGradient(color1: .secondBlue, color2: .mainBlue)
        
        //MARK: GET Keywords Call
        getKeywordsDataKorea(date: currentDateToYMD())
//        if (self.button_toggle.isOn) {
//            getKeywordsDataGlobal(date: currentDateToYMD())
//        } else {
//            getKeywordsDataKorea(date: currentDateToYMD())
//        }
        
//        tabBarController?.tabBar.isHidden = false
        
        activityIndicator.center = self.view.center
        
        self.view.addSubviews(layout_nav, layout_dates, layout_mid, layout_main)
        
        setNav()
        setMid()
        setDates()
        setMain()
        
        layout_table.register(BriefingTableViewCell.self, forCellReuseIdentifier: BriefingTableViewCell.cellID)
        layout_table.reloadData()
        
        layout_table.dataSource = self
        layout_table.delegate = self
        
        button_toggle.delegate = self
        
        print(currentDateToYMD())
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dateSelectionView.setInitialPosition()
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
        
        dateSelectionView.delegate = self
        
        layout_dates.addSubviews(dateSelectionView, pickBarView)
        
        dateSelectionView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        pickBarView.snp.makeConstraints{ make in
            make.bottom.equalTo(dateSelectionView).inset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(2)
            make.width.equalTo(65)
        }
        
        pickBarView.backgroundColor = .white
    }
    
    private func setMid() {
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
        
        label_today.text = getCurrentDateinKor()
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
        
//        cell.label_order.text = ranks[indexPath.row+1]
//        cell.label_topic.text = topics[indexPath.row+1]
//        cell.label_descript.text = descrips[indexPath.row+1]
        
        cell.label_order.text = ranks[indexPath.row]
        cell.label_topic.text = topics[indexPath.row]
        cell.label_descript.text = descrips[indexPath.row]
        
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
//            nextVC.order_num = indexPath.row + 1
//            nextVC.brief_rank = ranks[indexPath.row + 1]
//            nextVC.brief_date = slashToDotWithOutTime(date: self.update_timestamp) ?? "Invalid date format"
//            nextVC.brief_id = IDs[indexPath.row + 1]
//            nextVC.brief_title = topics[indexPath.row + 1]
//            nextVC.brief_sub = descrips[indexPath.row + 1]
            
            nextVC.order_num = indexPath.row+1
            nextVC.brief_rank = ranks[indexPath.row]
            nextVC.brief_date = slashToDotWithOutTime(date: self.update_timestamp) ?? "Invalid date format"
            nextVC.brief_id = IDs[indexPath.row]
            nextVC.brief_title = topics[indexPath.row]
            nextVC.brief_sub = descrips[indexPath.row]
        }
        
        // 파일 존재 여부 확인
        print("Finding : \(dotToSlash(dotDate: nextVC.brief_date))#\(nextVC.brief_rank).txt")
        
        let fileName = "\(dotToSlash(dotDate: nextVC.brief_date))#\(nextVC.brief_rank).txt"
        print(fileExists(withName: fileName))
        if fileExists(withName: fileName) {
            nextVC.isScrapped = true
        } else {
            nextVC.isScrapped = false
        }
        
        nextVC.hidesBottomBarWhenPushed = true
        
//        nextVC.get

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension BriefingTab: CustomDateSelectionViewDelegate {
    func dateSelectionView(_ view: CustomDateSelectionView, didSelectDateAtIndex index: Int) {
        pickBarView.blinkBackgroundColor(color: .clear, duration: 0.4)
//        self.label_today.text = getDateBeforeDaysinKor(6-index)
        
        
        let dateArray = getLastWeekDates()
        self.label_today.text = dotToKorAdd20(dotDate: dateArray[index])
        let selectedDate = dotToSlashAdd20(dotDate: dateArray[index])
        
        print("Selected: ", selectedDate)
        getKeywordsDataKorea(date: selectedDate)
        
        if index != view.dates.count - 3 {
            label_descrip.text = "그날의 키워드 브리핑"
        } else {
            label_descrip.text = "오늘의 키워드 브리핑"
        }
    }
}

extension BriefingTab: CustomToggleButtonDelegate {
    func didToggle(isOn: Bool) {
//        if isOn {
//            getKeywordsDataGlobal(date: currentDateToYMD())
//        } else {
//            getKeywordsDataKorea(date: currentDateToYMD())
//        }
        
        //MARK: Toggle Button 비활성화
        
        let alertController = UIAlertController(title: "아직 준비 중인 기능입니다.", message: "다음 업데이트를 기다려 주세요!", preferredStyle: .alert)
        
        // OK 버튼을 추가
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // 알림창을 띄우기
        self.present(alertController, animated: true, completion: nil)
    }
}


//MARK: - Extension for Network
extension BriefingTab {
    func getKeywordsDataKorea(date: String) {
        
        activityIndicator.startAnimating()
        
        self.ranks = [""]
        self.topics = [""]
        self.descrips = [""]
        self.IDs = [""]

        
        network.getKeywords(date: date, type: "Korea", completion: { response in
            switch response {
            case .success(let data):
                guard let keywords = (data as? KeywordsData), let briefing = (data as? KeywordsData)?.briefings else { return }
                
                self.rank_counts = briefing.count
                
                if self.rank_counts > 0 {
                    for _ in 0...(self.rank_counts-1) {
                        self.ranks.append("")
                        self.topics.append("")
                        self.descrips.append("")
                        self.IDs.append("")
                    }
                }
                
                self.update_timestamp = keywords.createdAt
                
//                briefing.forEach{ index, item in
//                    self.ranks.append(String(item.rank))
//                    self.topics.append(item.title)
//                    self.descrips.append(item.subtitle)
//                    self.IDs.append(String(item.id))
//                }
                
                briefing.enumerated().forEach{ index, item in
                    self.ranks[index] = String(item.rank)
                    self.topics[index] = String(item.title)
                    self.descrips[index] = String(item.subtitle)
                    self.IDs[index] = String(item.id)
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.label_update.text = "Updated: \(slashToDotAddTime(date: self.update_timestamp) ?? "Invalid date format")"
                    self.layout_table.reloadData()
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
            
        })
    }
    
    func getKeywordsDataGlobal(date: String) {
        
        self.ranks = [""]
        self.topics = [""]
        self.descrips = [""]
        self.IDs = [""]
        
        network.getKeywords(date: date, type: "Global", completion: { response in
            switch response {
            case .success(let data):
                guard let keywords = (data as? KeywordsData), let briefing = (data as? KeywordsData)?.briefings else { return }
                
                self.rank_counts = briefing.count
                self.update_timestamp = keywords.createdAt
                
                briefing.forEach{ item in
                    self.ranks.append(String(item.rank))
                    self.topics.append(item.title)
                    self.descrips.append(item.subtitle)
                    self.IDs.append(String(item.id))
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

