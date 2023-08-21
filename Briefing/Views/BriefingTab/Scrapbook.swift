//
//  Scrapbook.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import UIKit

var scrapCounts: [Int] = [4, 5]

class Scrapbook: UIViewController {
    let layout_nav = UIView()
    let layout_section_table = UITableView()
      
    override func viewDidLoad() {
        self.view.backgroundColor = .mainGray
        
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
        //MARK: Todo: 개수에 따라 변경해야 함
//        layout_section_table.rowHeight = UITableView.automaticDimension
//        layout_section_table.rowHeight = 300
    }
}

extension Scrapbook {
    @objc func backButtonTapped() {
        print("scrapbook -> home")
        self.navigationController?.popViewController(animated: true)
    }
}

extension Scrapbook: UITableViewDelegate, UITableViewDataSource, ScrapSectionCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scrapCounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScrapSectionCell.cellID, for: indexPath) as! ScrapSectionCell
        
        cell.delegate = self
        cell.tag = indexPath.row
        cell.label_date.text = "23.08.07"
        
        return cell
    }
    
    func numberOfItems(for cell: ScrapSectionCell) -> Int {
        return scrapCounts[cell.tag]
    }
}
