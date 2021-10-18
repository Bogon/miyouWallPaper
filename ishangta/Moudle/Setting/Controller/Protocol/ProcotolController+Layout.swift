//
//  ProcotolController+Layout.swift
//  beeparttime
//
//  Created by Senyas on 2020/8/1.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation

extension ProcotolController {
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white

        leftBarItemSeeting()
        initSubView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private func initSubView() {
        webView = WebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - TopMarginX.margin))
        view.addSubview(webView)
        // 配置webView样式
        var config = WkwebViewConfig()
        config.isShowScrollIndicator = false
        config.isProgressHidden = false
        config.progressTintColor = UIColor(hex: "#333333")
        // 加载普通URL
        webView.webConfig = config
        webView.webloadType(self, .URLString(url: m_url))
    }

    private func leftBarItemSeeting() {
        let closeItem = UIBarButtonItem(image: Asset.back.image, style: .plain, target: self, action:
            #selector(pop))
        closeItem.tintColor = UIColor(hex: "#333333")
        navigationItem.leftBarButtonItem = closeItem
    }

    @objc private func pop() {
        navigationController?.popViewController(animated: true)
    }

}
