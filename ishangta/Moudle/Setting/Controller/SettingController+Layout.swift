//
//  SettingController+Layout.swift
//  ishangta
//
//  Created by Senyas on 2021/10/9.
//

import Foundation

extension SettingController {
    
    func setupSubviews() {
        navigationItem.title = "设置"
        
        settingTableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: UIScreen.main.bounds.height)
        settingTableView.delegate = self
        settingTableView.tableFooterView = UIView()
        header.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: SettingHeader.layoutHeight)
        settingTableView.tableHeaderView = header
        view.addSubview(settingTableView)
        settingTableView.register(cellType: SettingTableViewCell.self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}
