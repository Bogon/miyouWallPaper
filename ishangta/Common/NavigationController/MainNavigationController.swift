//
//  MainNavigationController.swift
//  ishangta
//
//  Created by Senyas on 2021/9/4.
//

import UIKit
import AMScrollingNavbar

class MainNavigationController: ScrollingNavigationController, UINavigationControllerDelegate {
    
    weak var popDelegate: UIGestureRecognizerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
        
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont.systemFont(ofSize: 18, weight: .medium),.foregroundColor : UIColor.black]
        
    }
    
    @objc func goPop () {
        view.endEditing(true)
        popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer?.delegate = self.popDelegate
        } else {
            self.interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
    // change status bar style
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        /* 存在 bug 多次进入之后，会出现返回根目录出现tabbar隐藏的情况
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
         //            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.leftBackButton(image: UIImage(named: "black_back")!, target: self, action: #selector(goPop))
        }   */
        viewController.hidesBottomBarWhenPushed = !(children.isEmpty)
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
