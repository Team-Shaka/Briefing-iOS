//
//  TimePickViewController.swift
//  Briefing
//
//  Created by BoMin on 2023/08/28.
//

import UIKit

class TimePickViewController: UIViewController {
    
    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        // Initialize and setup date picker
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        
        datePicker.datePickerMode = .time // 시간 선택 모드 설정
        datePicker.backgroundColor = .systemPink
        
        self.view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // Setup Done button to dismiss view
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
    }
    
    @objc func doneButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
