//
//  PreviewWallPaperController.swift
//  ishangta
//
//  Created by Senyas on 2021/9/4.
//

import UIKit
import Kingfisher

class PreviewWallPaperController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private lazy var m_wallPaperImageView: UIImageView = {
        let m_imageview: UIImageView = UIImageView(frame: UIScreen.main.bounds)
        m_imageview.contentMode = .scaleAspectFill
        return m_imageview
    }()
    
    private lazy var home_wallPaperImageView: UIImageView = {
        let m_imageview: UIImageView = UIImageView(frame: UIScreen.main.bounds)
        m_imageview.image = UIImage(named: PreviewHomeLockProvider.share.getHomeImage())
        m_imageview.contentMode = .scaleAspectFill
        m_imageview.isHidden = true
        return m_imageview
    }()
    
    private lazy var lock_wallPaperImageView: UIImageView = {
        let m_imageview: UIImageView = UIImageView(frame: UIScreen.main.bounds)
        m_imageview.contentMode = .scaleAspectFill
        m_imageview.image = UIImage(named: PreviewHomeLockProvider.share.getLockImage())
        m_imageview.isHidden = true
        return m_imageview
    }()
    
    private lazy var m_backButton: UIButton = {
        let backBtn: UIButton = UIButton()
        backBtn.contentMode = .left
        backBtn.setImage(Asset.pBack.image, for: .normal)
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return backBtn
    }()
    
    private var m_bottomBar: BottomBar = BottomBar.instance()!
    
    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    private var m_url: String!
    private var m_info: CategoryDetailModel!
    private var m_holder: UIImage!
    init(url value: String, info: CategoryDetailModel, holder: UIImage) {
        super.init(nibName: nil, bundle: nil)
        m_url = value
        m_info = info
        m_holder = holder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        
        let processor = DownsamplingImageProcessor(size: m_wallPaperImageView.bounds.size)
        m_wallPaperImageView.kf.indicatorType = .activity
        m_wallPaperImageView.kf.setImage(with: URL(string: m_url)!, placeholder: m_holder, options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ]) { _ in }
        
    }
    
    @objc func backAction() {
        dismiss(animated: false, completion: nil)
    }
    
    /// get download info
    func getDownloadInfo() -> CategoryDetailModel {
        return m_info
    }
    
    /// get url
    func getURL() -> String {
        return m_url
    }
    
    /// get bootom bar
    func getBottomBar() -> BottomBar {
        return m_bottomBar
    }
    
    /// get back button
    func getBackButton() -> UIButton {
        return m_backButton
    }
    
    /// get lock wallpaper imageview
    func getLockWallPaperImageView() -> UIImageView {
        return lock_wallPaperImageView
    }
    
    /// get home wallpaper imageview
    func getHomeWallPaperImageView() -> UIImageView {
        return home_wallPaperImageView
    }

    /// get wallpaper imageview
    func getWallPaperImageView() -> UIImageView {
        return m_wallPaperImageView
    }

}
