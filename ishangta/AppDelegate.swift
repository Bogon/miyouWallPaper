//
//  AppDelegate.swift
//  ishangta
//
//  Created by Senyas on 2021/3/4.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let configViewModel: ConfigViewModel = ConfigViewModel()
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
         
        configViewModel.config().done { (configModel) in
            guard let n_urlPrefix: String = configModel?.urlPrefix else {
                return
            }
            if !n_urlPrefix.isEmpty {
                ConfigInfoProvider.shared.setUrlPrefix(urlPrefix: n_urlPrefix)
            }
        }.catch { (_) in }
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = MainTabbarController()
        window?.makeKeyAndVisible()
        
        return true
    }

}
