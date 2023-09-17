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
        
        updateTableViewHeight()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.backgroundColor = .mainGray
        self.contentView.addSubview(layout_main)
        
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
            make.height.equalTo(500)
        }
        
        layout_scraps_table.layer.masksToBounds = true
        layout_scraps_table.layer.cornerRadius = 5
        
        layout_scraps_table.backgroundColor = .mainGray
        layout_scraps_table.separatorColor = .mainGray
        layout_scraps_table.separatorStyle = .singleLine
        
//        layout_scraps_table.rowHeight = UITableView.automaticDimension
//        layout_scraps_table.rowHeight = 55
    }
    
    func updateTableViewHeight() {
        let rows = delegate?.numberOfItems(for: self) ?? 0
        let height = (CGFloat(rows) * 55) - 1
        layout_scraps_table.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    func configure(withDelegate delegate: ScrapSectionCellDelegate?) {
        self.delegate = delegate
        layout_scraps_table.reloadData()
        updateTableViewHeight()
    }

}

extension ScrapSectionCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let rowCount = (delegate?.numberOfItems(for: self) ?? 0) + 1
        let rowCount = (delegate?.numberOfItems(for: self) ?? 0)
        updateTableViewHeight()
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let totalRows = delegate?.numberOfItems(for: self) ?? 0
        
        // 가짜의 셀을 반환
        if indexPath.row == totalRows {
            let cell = UITableViewCell()
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
            cell.backgroundColor = .clear
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ScrapDetailCell.cellID, for: indexPath) as! ScrapDetailCell
        
        if let scrap = delegate?.scrapItem(for: self, at: indexPath.row) {
            cell.label_topic.text = scrap.title
            cell.label_sub.text = scrap.subtitle
            cell.label_date_info.text = "\(scrap.date) #\(scrap.rank)"
        }
        
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
    func scrapItem(for cell: ScrapSectionCell, at index: Int) -> Scrap?
}

