//
//  AppearanceViewController.swift
//  ishangta
//
//  Created by Senyas on 2021/9/22.
//

import UIKit

enum AppearanceBarStyle {
    case nb_white
    case nb_transparent
}

class AppearanceViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch navigationBarStyle {
        case .nb_transparent:
            return .lightContent
            
        case .nb_white:
            return .default
        }
    }
    
    @available(iOS 11.0, *)
    open var navigationBarStyle: AppearanceBarStyle { return .nb_white }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetting(barStyle: navigationBarStyle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// navigationbar setting
    private func navigationBarSetting(barStyle value: AppearanceBarStyle) {

        if #available(iOS 15, *) {
            var nb_backgroundColor: UIColor = .white
            var nb_shadowImage: UIImage = UIColor.clear.image
            var nb_textColor: UIColor = .black
            
            switch navigationBarStyle {
            case .nb_white:
                nb_backgroundColor = .white
                nb_shadowImage = UIColor.clear.image
                nb_textColor = .black
                navigationController?.navigationBar.isTranslucent = false

            case .nb_transparent:
                nb_backgroundColor = UIColor.clear
                nb_shadowImage = UIColor.clear.image(CGSize(width: ScreenWidth, height: 1))
                nb_textColor = .white
                navigationController?.navigationBar.isTranslucent = true
            }
            
            let app = UINavigationBarAppearance.init()
            app.configureWithOpaqueBackground()  // 重置背景和阴影颜色
            app.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                NSAttributedString.Key.foregroundColor: nb_textColor
            ]
            app.backgroundColor = nb_backgroundColor    // 设置导航栏背景色
            app.shadowImage = nb_shadowImage            // 设置导航栏下边界分割线透明
            navigationController?.navigationBar.scrollEdgeAppearance = app  // 带scroll滑动的页面
            navigationController?.navigationBar.standardAppearance = app // 常规页面
            navigationController?.navigationBar.tintColor = nb_textColor
            navigationController?.navigationBar.backItem?.backButtonTitle = ""
        } else {
            var nb_backgroundColor: UIColor = .white
            var nb_shadowImage: UIImage = UIColor.clear.image
            var nb_textColor: UIColor = .black
            switch navigationBarStyle {
            case .nb_white:
                nb_backgroundColor = .white
                nb_shadowImage = UIColor.clear.image
                nb_textColor = .black
                navigationController?.navigationBar.isTranslucent = false
                
                navigationController?.navigationBar.barTintColor = nb_backgroundColor       /// 设置导航栏
                navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .medium), NSAttributedString.Key.foregroundColor: nb_textColor]
                navigationController?.navigationBar.shadowImage = nb_shadowImage

            case .nb_transparent:
                navigationController?.navigationBar.isTranslucent = true
                navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationController?.navigationBar.shadowImage = UIImage()
                navigationController?.view.backgroundColor = .clear
            }
        }
        
    }

}
