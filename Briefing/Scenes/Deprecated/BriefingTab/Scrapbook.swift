//
//  Scrapbook.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import UIKit

class Scrapbook: UIViewController {
    var sectionDates: [String] = []
    var scraps: [Scrap] = []
    var scrapsByDate: [String: [Scrap]] = [:]
    var scrapsByDateList: [(String, [Scrap])] = []
    
    let layout_nav = UIView()
    
    lazy var layout_table: UITableView = {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
            
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
            
        let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight), style: .insetGrouped)
            
        tableView.register(ScrapDetailCell.self, forCellReuseIdentifier: ScrapDetailCell.cellID)
            
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
                    
        return tableView
    }()
      
    override func viewDidLoad() {
        self.view.backgroundColor = .mainGray
        
        self.scraps = readAllScraps()
        classifyScrapsByDate()
        
        self.view.addSubviews(layout_nav, layout_table)
        
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
        layout_table.register(ScrapDetailCell.self, forCellReuseIdentifier: ScrapDetailCell.cellID)
        layout_table.reloadData()

        layout_table.dataSource = self
        layout_table.delegate = self
        
        setNav()
        setSections()
        
        addSwipeGestureToDismiss()
    }
    
    private func setNav() {
        let label_title = UILabel()
        let button_back = UIButton()
        
        layout_nav.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.159)
        }
        
        layout_nav.addSubviews(label_title, button_back)
        
        label_title.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(15)
        }
        
        label_title.text = "스크랩북"
        label_title.textColor = .mainBlue
        label_title.font = UIFont(name: "ProductSans-Regular", size: 24)
        label_title.textAlignment = .center
        label_title.numberOfLines = 1
        
        button_back.snp.makeConstraints{ make in
            make.centerY.equalTo(label_title)
            make.leading.equalToSuperview().offset(self.view.frame.width * 0.076)
            make.width.height.equalTo(25)
        }
        
        button_back.setImage(UIImage(named: "arrow_blue"), for: .normal)
        button_back.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setSections() {
        layout_table.snp.makeConstraints{ make in
            make.top.equalTo(layout_nav.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        layout_table.backgroundColor = .mainGray
        layout_table.separatorStyle = .none
        
        layout_table.isUserInteractionEnabled = true
    }
}

extension Scrapbook {
    private func classifyScrapsByDate() {
        scrapsByDateList.removeAll()
        for scrap in scraps {
            let date = scrap.date
            if scrapsByDate[date] == nil {
                scrapsByDate[date] = []
            }
            sectionDates.append(date)
            scrapsByDate[date]?.append(scrap)
            print("array append check:", scrapsByDate)
        }
                
        print("\n\n", sectionDates, "\n\n")
        
        let sectionDatesSet = Array(Set(sectionDates))
        
        print("\n\n", sectionDatesSet, "\n\n")
        
        for date in sectionDatesSet {
            if let scrapsForDate = scrapsByDate[date] {
                scrapsByDateList.append((date, scrapsForDate))
                print("appending check:", scrapsByDateList)
            }
        }
        
        scrapsByDateList.sort { $0.0 < $1.0 }
        
        sectionDates = sectionDatesSet
        sectionDates.sort()
        
        print("\n\n", sectionDates, "\n\n")
    }
    
}

extension Scrapbook {
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension Scrapbook: UITableViewDelegate, UITableViewDataSource, ScrapDetailCellDelegate {
    func didTapScrapDetail(in cell: ScrapDetailCell) {
        print("Tapped")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionDates[section]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return scrapsByDateList.count
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scrapsByDateList[section].1.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScrapDetailCell.cellID, for: indexPath) as! ScrapDetailCell

        cell.delegate = self
        cell.tag = indexPath.section

        let date = scrapsByDateList[indexPath.section].0
        let rank = scrapsByDateList[indexPath.section].1[indexPath.row].rank
        let topics = scrapsByDateList[indexPath.section].1[indexPath.row].title
        let subtopic = scrapsByDateList[indexPath.section].1[indexPath.row].subtitle

        cell.label_topic.text = topics
        cell.label_sub.text = subtopic
        cell.label_date_info.text = "\(date) #\(rank)"

        cell.isUserInteractionEnabled = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = BriefingCard()
        
        nextVC.brief_rank = scrapsByDateList[indexPath.section].1[indexPath.row].rank
        nextVC.brief_date = scrapsByDateList[indexPath.section].0
        nextVC.brief_id = scrapsByDateList[indexPath.section].1[indexPath.row].id
        nextVC.brief_title = scrapsByDateList[indexPath.section].1[indexPath.row].title
        nextVC.brief_sub = scrapsByDateList[indexPath.section].1[indexPath.row].subtitle
        
        print("Finding : \(dotToSlash(dotDate: nextVC.brief_date))#\(nextVC.brief_rank).txt")
        
        let fileName = "\(dotToSlash(dotDate: nextVC.brief_date))#\(nextVC.brief_rank).txt"
        print(fileExists(withName: fileName))
        if fileExists(withName: fileName) {
            nextVC.isScrapped = true
        } else {
            nextVC.isScrapped = false
        }
        
        nextVC.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
