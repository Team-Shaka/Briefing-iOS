//
//  Scrapbook.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import UIKit

class Scrapbook: UIViewController {
    var scraps: [Scrap] = []
    var scrapsByDate: [String: [Scrap]] = [:]
    
    let layout_nav = UIView()
    let layout_section_table = UITableView()
      
    override func viewDidLoad() {
        self.view.backgroundColor = .mainGray
        
        self.scraps = readAllScraps()
        classifyScrapsByDate()
        
        print("Number of scraps: \(scraps.count)")
        print("Number of sections: \(scrapsByDate.keys.count)")

        
        self.view.addSubviews(layout_nav, layout_section_table)
        
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
        layout_section_table.register(ScrapSectionCell.self, forCellReuseIdentifier: ScrapSectionCell.cellID)
        layout_section_table.reloadData()

        layout_section_table.dataSource = self
        layout_section_table.delegate = self
        
        setNav()
        setSections()
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
        layout_section_table.snp.makeConstraints{ make in
            make.top.equalTo(layout_nav.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        layout_section_table.backgroundColor = .mainGray
        layout_section_table.separatorStyle = .none
        
        layout_section_table.isUserInteractionEnabled = true

        //MARK: Todo: 개수에 따라 변경해야 함
//        layout_section_table.rowHeight = UITableView.automaticDimension
//        layout_section_table.rowHeight = 300
    }
}

extension Scrapbook {
    private func classifyScrapsByDate() {
        for scrap in scraps {
            let date = scrap.date
            if scrapsByDate[date] == nil {
                scrapsByDate[date] = []
            }
            scrapsByDate[date]?.append(scrap)
        }
    }
}

extension Scrapbook {
    @objc func backButtonTapped() {
        print("scrapbook -> home")
        self.navigationController?.popViewController(animated: true)
    }
}

extension Scrapbook: UITableViewDelegate, UITableViewDataSource, ScrapSectionCellDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = Array(scrapsByDate.keys).count
        return count
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ScrapSectionCell.cellID, for: indexPath) as! ScrapSectionCell
//
//        cell.delegate = self
//        cell.tag = indexPath.row
//        cell.label_date.text = "23.08.07"
//
//        return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ScrapSectionCell.cellID, for: indexPath) as! ScrapSectionCell
        let dateKey = Array(scrapsByDate.keys).sorted()[indexPath.section]
        
        cell.delegate = self
        cell.tag = indexPath.section
        cell.label_date.text = dateKey
        
        cell.isUserInteractionEnabled = true
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        tableView.deselectRow(at: indexPath, animated: true)
//        
//        print("Cell Selected")
//        
//        let detailVC = BriefingCard()
//
//        let dateKey = Array(scrapsByDate.keys).sorted()[indexPath.section]
////        detailVC.selectedData = scrapsByDate[dateKey]
//        detailVC.brief_id = scrapsByDate[dateKey]?[indexPath.row].id ?? ""
//        detailVC.brief_title = scrapsByDate[dateKey]?[indexPath.row].title ?? ""
//        detailVC.brief_sub = scrapsByDate[dateKey]?[indexPath.row].subtitle ?? ""
//        detailVC.brief_date = scrapsByDate[dateKey]?[indexPath.row].date ?? ""
//
//        self.navigationController?.pushViewController(detailVC, animated: true)
//    }
    
    func numberOfItems(for cell: ScrapSectionCell) -> Int {
        let dateKey = Array(scrapsByDate.keys).sorted()[cell.tag]
        return scrapsByDate[dateKey]?.count ?? 0
    }
    
    func scrapItem(for cell: ScrapSectionCell, at index: Int) -> Scrap? {
        let dateKey = Array(scrapsByDate.keys).sorted()[cell.tag]
        return scrapsByDate[dateKey]?[index]
    }
}
