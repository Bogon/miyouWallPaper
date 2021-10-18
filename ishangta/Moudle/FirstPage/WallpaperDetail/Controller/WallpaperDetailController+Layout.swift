//
//  WallpaperDetailController+Layout.swift
//  ishangta
//
//  Created by Senyas on 2021/9/4.
//

import Foundation
import MJRefresh

extension WallpaperDetailController {
    
    func setUpUI() {
        view.backgroundColor = .white
        
        let m_contentCollectionView: UICollectionView = getContentCollectionView()
        m_contentCollectionView.delegate = self
        m_contentCollectionView.dataSource = self
        m_contentCollectionView.register(cellType: WallPaperItemCollectionViewCell.self)
        view.addSubview(m_contentCollectionView)
        
        // 设置头部刷新控件
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefreshAction))
        header.lastUpdatedTimeLabel?.isHidden = true
        header.arrowView?.image = Asset.xiala.image
        m_contentCollectionView.mj_header = header
        // 设置尾部刷新控件
        let footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefreshAction))
        footer.arrowView?.image = Asset.xiala.image
        m_contentCollectionView.mj_footer = footer
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let m_contentCollectionView: UICollectionView = getContentCollectionView()
        m_contentCollectionView.snp.remakeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
}
