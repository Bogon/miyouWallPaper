//
//  MainTabbarController.swift
//  ishangta
//
//  Created by Senyas on 2021/9/4.
//

import UIKit
import ESTabBarController_swift
import Hue

let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height

class MainTabbarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15, *) {
            let bar = UITabBarAppearance.init()
            bar.backgroundColor = UIColor.clear
            bar.shadowImage = UIColor(hex: "#F5F5F5").alpha(0.3).image(CGSize(width: ScreenWidth, height: 0.5))
            tabBar.scrollEdgeAppearance = bar
            tabBar.standardAppearance = bar
        }
        // Do any additional setup after loading the view.
        setupViewControllers()
        
    }
    
    func setupViewControllers() {
        let momentController: UIViewController = FirstPageController()
        momentController.tabBarItem = UITabBarItem(title: "首页", image: Asset.homeSelected.image, tag: 0)
        
        let livePhotoController: UIViewController = LivePhotoController()
        livePhotoController.tabBarItem = UITabBarItem(title: "动态", image: Asset.preDynamic.image, tag: 1)
        
        let settingController: UIViewController = SettingController()
        settingController.tabBarItem = UITabBarItem(title: "设置", image: Asset.setting.image, tag: 2)

        viewControllers = [MainNavigationController(rootViewController: momentController),
                           MainNavigationController(rootViewController: livePhotoController),
                           MainNavigationController(rootViewController: settingController)]
    }
    
    func hiddenTabbarEvent() -> Bool {
        tabBar.layer.zPosition = tabBar.layer.zPosition == 0 ? -1 : 0
        return tabBar.layer.zPosition == -1
    }
    
    func setHiddenTabbar(isHidden: Bool) {
        tabBar.layer.zPosition = isHidden ? -1 : 0
    }

}
