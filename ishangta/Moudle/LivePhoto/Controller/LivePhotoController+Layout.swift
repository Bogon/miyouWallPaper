//
//  LivePhotoController+Layout.swift
//  ishangta
//
//  Created by Senyas on 2021/9/24.
//

import Foundation
import MJRefresh
import ZFPlayer

extension LivePhotoController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let m_collection: UICollectionView = getCollectionView()
        m_collection.snp.remakeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        let m_bootomBar: LiveBottomBar = getBottomBar()
        m_bootomBar.snp.remakeConstraints { make in
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom).offset(-TabbarHeight.m_height)
            make.size.equalTo(CGSize(width: LiveBottomBar.m_width, height: LiveBottomBar.m_height))
        }
        
        let m_liveView: PreviewContentView = getLivePhotoView()
        m_liveView.snp.remakeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    /// init subviews
    func setupUI() {
        let m_collection: UICollectionView = getCollectionView()
        view.addSubview(m_collection)
        
        // 设置头部刷新控件
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefreshAction))
        header.lastUpdatedTimeLabel?.isHidden = true
        header.arrowView?.image = Asset.xiala.image
        m_collection.mj_header = header
        m_collection.mj_header?.beginRefreshing()
        // 设置尾部刷新控件
        let footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefreshAction))
        footer.arrowView?.image = Asset.xiala.image
        m_collection.mj_footer = footer
        
        let m_player: ZFPlayerController = getPlyer()
        let tap_gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hiddenTabbar))
        m_player.currentPlayerManager.view.addGestureRecognizer(tap_gesture)
        
        /// bottom bar
        let m_bootomBar: LiveBottomBar = getBottomBar()
        m_bootomBar.delegate = self
        view.addSubview(m_bootomBar)
        view.bringSubviewToFront(m_bootomBar)
        
        /// PreviewContentView
        let m_liveView: PreviewContentView = getLivePhotoView()
        m_liveView.isHidden = true
        m_liveView.delegate = self
        view.addSubview(m_liveView)
    }
    
    @objc private func hiddenTabbar() {
        guard let window: UIWindow = (UIApplication.shared.delegate?.window)! else { return }
        let m_tabbarController: MainTabbarController = window.rootViewController as! MainTabbarController
        let isHidden: Bool = m_tabbarController.hiddenTabbarEvent()
        let m_bootomBar: LiveBottomBar = getBottomBar()
        m_bootomBar.isHidden = isHidden
        
    }
    
    @objc private func headerRefreshAction() {
        var m_liveVM: LiveViewModel = getLiveVM()
        m_liveVM.load().done { [weak self] lives in
            self?.setData(lives: lives ?? [])
            self?.updateCollections()
        }.catch { [weak self] _ in
            self?.updateCollections()
        }
    }
    
    @objc func footerRefreshAction() {
        var m_liveVM: LiveViewModel = getLiveVM()
        m_liveVM.more().done { [weak self] lives in
            self?.appends(lives: lives ?? [])
            self?.updateCollections()
        }.catch { [weak self] _ in
            self?.updateCollections()
        }
    }
    /// update colloctionview
    private func updateCollections() {
        let m_collection: UICollectionView = getCollectionView()
        OperationQueue.main.addOperation { [weak self] in
            m_collection.reloadData()
            if m_collection.mj_header?.isRefreshing ?? true {
                m_collection.mj_header?.endRefreshing(completionBlock: {
                    self?.scrollViewDidEndDecelerating(m_collection)
                })
            }
            
            if m_collection.mj_footer?.isRefreshing ?? true {
                m_collection.mj_footer?.endRefreshing()
            }
        }
    }
}
