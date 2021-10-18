//
//  PreviewWallPaperController+Layout.swift
//  ishangta
//
//  Created by Senyas on 2021/9/5.
//

import Foundation
import UIKit

extension PreviewWallPaperController {
    
    /// setup ui
    func setUpUI() {
        
        view.backgroundColor = .white
        
        let m_wallPaperImageView: UIImageView = getWallPaperImageView()
        view.addSubview(m_wallPaperImageView)
        
        let home_wallPaperImageView: UIImageView = getHomeWallPaperImageView()
        view.addSubview(home_wallPaperImageView)
        
        let home_gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(recoverAction))
        home_wallPaperImageView.isUserInteractionEnabled = true
        home_wallPaperImageView.addGestureRecognizer(home_gesture)
        
        let lock_wallPaperImageView: UIImageView = getLockWallPaperImageView()
        view.addSubview(lock_wallPaperImageView)
        
        let lock_gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(recoverAction))
        lock_wallPaperImageView.isUserInteractionEnabled = true
        lock_wallPaperImageView.addGestureRecognizer(lock_gesture)
        
        let backButton: UIButton = getBackButton()
        view.addSubview(backButton)
        
        let m_bottomBar: BottomBar = getBottomBar()
        m_bottomBar.delegate = self
        view.addSubview(m_bottomBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let backButton: UIButton = getBackButton()
        let b_topMargin: CGFloat = DeviceX.isIPhoneX ? 44 : 20
        backButton.snp.remakeConstraints { make in
            make.left.equalTo(view.snp.left).offset(12)
            make.top.equalTo(view.snp.top).offset(b_topMargin)
            make.size.equalTo(CGSize(width: 30, height: 44))
        }
        
        let m_bottomBar: BottomBar = getBottomBar()
        m_bottomBar.snp.remakeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.bottom.equalTo(view.snp.bottom)
            make.size.equalTo(CGSize(width: BottomBar.m_width, height: BottomBar.m_height))
        }
    }
    
    /// home action
    @objc private func recoverAction() {
        showNone()
    }
    
    /// show home
    func showHome() {
        let home_wallPaperImageView: UIImageView = getHomeWallPaperImageView()
        home_wallPaperImageView.isHidden = false
        
        let lock_wallPaperImageView: UIImageView = getLockWallPaperImageView()
        lock_wallPaperImageView.isHidden = true
        
        let backButton: UIButton = getBackButton()
        backButton.isHidden = true
        
        let m_bottomBar: BottomBar = getBottomBar()
        m_bottomBar.isHidden = true
    }
    
    /// show lock
    func showLock() {
        let home_wallPaperImageView: UIImageView = getHomeWallPaperImageView()
        home_wallPaperImageView.isHidden = true
        
        let lock_wallPaperImageView: UIImageView = getLockWallPaperImageView()
        lock_wallPaperImageView.isHidden = false
        
        let backButton: UIButton = getBackButton()
        backButton.isHidden = true
        
        let m_bottomBar: BottomBar = getBottomBar()
        m_bottomBar.isHidden = true
    }
    
    /// show none
    func showNone() {
        let home_wallPaperImageView: UIImageView = getHomeWallPaperImageView()
        home_wallPaperImageView.isHidden = true
        
        let lock_wallPaperImageView: UIImageView = getLockWallPaperImageView()
        lock_wallPaperImageView.isHidden = true
        
        let backButton: UIButton = getBackButton()
        backButton.isHidden = false
        
        let m_bottomBar: BottomBar = getBottomBar()
        m_bottomBar.isHidden = false
    }
}
