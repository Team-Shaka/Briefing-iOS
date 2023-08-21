//
//  Scrapbook.swift
//  Briefing
//
//  Created by BoMin on 2023/08/21.
//

import UIKit

class Scrapbook: UIViewController {
    let layout_nav = UIView()
    let layout_section_table = UITableView()
      
    override func viewDidLoad() {
        self.view.backgroundColor = .mainGray
        
        self.view.addSubviews(layout_nav, layout_section_table)
        
        layout_section_table.register(BriefingCardCell.self, forCellReuseIdentifier: BriefingCardCell.cellID)
        layout_section_table.reloadData()

        layout_section_table.dataSource = self
        layout_section_table.delegate = self
        
        setNav()
        setSections()
    }
    
    private func setNav() {
        let label_title = UILabel()
        let button_back = UIButton()
        let button_scrap = UIButton()
        
        layout_nav.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.159)
        }
        
        layout_nav.addSubviews(label_title, button_back)
        
        label_title.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
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
    }
    
    private func setSections() {
        layout_section_table.snp.makeConstraints{ make in
            make.top.equalTo(layout_nav.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        layout_section_table.backgroundColor = .mainGray
        layout_section_table.separatorStyle = .none
        //MARK: Todo: 개수에 따라 변경해야 함
        layout_section_table.rowHeight = UITableView.automaticDimension
        layout_section_table.rowHeight = 520
    }
}

extension Scrapbook: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BriefingCardCell.cellID, for: indexPath) as! BriefingCardCell
        
        cell.label_info.text = "00.00.00 Briefing #1"
        cell.label_topic.text = "배터리 혁명"
        cell.label_sub.text = "2차 전지 혁명으로 인한 놀라운 발전과 전보"
        cell.label_context.text = "배터리 혁명은 현대 산업과 일상 생활에 혁명적인 변화를 가져왔다. 전기 자동차 및 이동식 장치들은 더 큰 용량과 효율성을 가진 배터리로 긴 주행거리와 높은 성능을 실현하였다. 또한 재생 에너지 저장 시스템으로 활용되어 전력 그리드 안정성을 증진시키고 친환경 에너지 전환을 촉진하고 있다. 연구의 진보로 배터리 수명과 충전 시간이 개선되며, 이는 모바일 기기부터 심지어 대규모 에너지 저장까지 다양한 분야에서 혁신을 이뤄내고 있다."
        
        cell.label_press1.text = "BBC News"
        cell.label_news_title1.text = "스마트폰부터 전력 그리드까지 어쩌구 저쩌구 저러쿵"
        
        cell.label_press2.text = "연합뉴스"
        cell.label_news_title2.text = "배터리 기술 발전으로 인한 산업이 어쩌구 저쩌구 저러쿵"
        
        cell.label_press3.text = "동아일보"
        cell.label_news_title3.text = "지속 가능한 미래를 위한 배터리가 개발 어쩌구 저쩌구 저러쿵"
        
        return cell
    }
    
    
}
