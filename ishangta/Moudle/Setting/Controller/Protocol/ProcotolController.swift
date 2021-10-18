//
//  ProcotolController.swift
//  beeparttime
//
//  Created by Senyas on 2020/8/1.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import AMScrollingNavbar
import UIKit

class ProcotolController: AppearanceViewController, ScrollingNavigationControllerDelegate {
    var webView: WebView!

    override var navigationBarStyle: AppearanceBarStyle {
        return .nb_white
    }
    
    var m_title: String = ""
    var m_url: String = ""

    init(url value: String, title: String) {
        super.init(nibName: nil, bundle: nil)
        m_title = title
        m_url = value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = m_title
    }

}
