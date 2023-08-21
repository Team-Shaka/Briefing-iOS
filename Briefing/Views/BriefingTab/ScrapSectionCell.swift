//
//  ScrapSectionCell.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import UIKit

class ScrapSectionCell: UITableViewCell {
    static let cellID = "ScrapSectionCell"
    weak var delegate: ScrapSectionCellDelegate?
    
    let layout_main = UIView()
    
    let label_date = UILabel()
    let layout_scraps_table = UITableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        layout_scraps_table.register(ScrapDetailCell.self, forCellReuseIdentifier: ScrapDetailCell.cellID)
        layout_scraps_table.reloadData()

        layout_scraps_table.dataSource = self
        layout_scraps_table.delegate = self
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.backgroundColor = .mainGray
        self.addSubview(layout_main)
        
        layout_main.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
//            make.leading.equalToSuperview().offset(self.frame.width * 0.043)
//            make.trailing.equalToSuperview().inset(self.frame.width * 0.043)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        layout_main.backgroundColor = .mainGray
        
        layout_main.addSubviews(label_date, layout_scraps_table)
        
        label_date.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        label_date.font = UIFont(name: "ProductSans-Regular", size: 15)
        label_date.textAlignment = .left
        label_date.textColor = .mainBlue
        
        layout_scraps_table.snp.makeConstraints{ make in
            make.top.equalTo(label_date.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(25)
            make.height.equalTo(totalHeightForScrapDetails())
        }
        
        layout_scraps_table.layer.masksToBounds = true
        layout_scraps_table.layer.cornerRadius = 5
        
        layout_scraps_table.rowHeight = UITableView.automaticDimension
        layout_scraps_table.rowHeight = 55
    }
    
    func totalHeightForScrapDetails() -> CGFloat {
        let numberOfRows = self.tableView(layout_scraps_table, numberOfRowsInSection: 0)
            
        // 마지막 가짜 셀의 높이를 1로 가정
        let totalHeight = CGFloat(numberOfRows - 1) * ScrapDetailCell.cellHeight - 1
            
        return totalHeight
    }

}

extension ScrapSectionCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
//        return delegate?.numberOfItems(for: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == delegate?.numberOfItems(for: self) {  // 가짜의 셀을 반환
        if indexPath.row == 4 {
            let cell = UITableViewCell()
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
            cell.backgroundColor = .clear
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ScrapDetailCell.cellID, for: indexPath) as! ScrapDetailCell
        
        cell.label_topic.text = "잼버리 행사"
        cell.label_sub.text = "잼버리 행사 관련 논란 및 정부와의 갈등"
        cell.label_date_info.text = "23.08.07 #1"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
//        if indexPath.row == delegate?.numberOfItems(for: self) {
            return 1
        }
        
        return ScrapDetailCell.cellHeight
    }

    
    
}

protocol ScrapSectionCellDelegate: AnyObject {
    func numberOfItems(for cell: ScrapSectionCell) -> Int
}

