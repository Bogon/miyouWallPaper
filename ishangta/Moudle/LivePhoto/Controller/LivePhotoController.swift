//
//  LivePhotoController.swift
//  ishangta
//
//  Created by Senyas on 2021/9/24.
//

import UIKit
import ZFPlayer

let kPlayerViewTag: Int = 100

class LivePhotoController: AppearanceViewController {

    override var navigationBarStyle: AppearanceBarStyle { return .nb_transparent }
    override var shouldAutorotate: Bool { return false }
    override var prefersStatusBarHidden: Bool { return false }
    
    private lazy var m_player: ZFPlayerController = {
        let playerManager: AVPlayerManager = AVPlayerManager()
        playerManager.isMuted = true
        let player: ZFPlayerController = ZFPlayerController(scrollView: contentCollectionView, playerManager: playerManager, containerViewTag: kPlayerViewTag)
        player.shouldAutoPlay = true
        player.allowOrentitaionRotation = false
        player.playerDisapperaPercent = 1.0
        player.disablePanMovingDirection = .all
        return player
    }()
    
    private lazy var contentCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.g_width, height: UIScreen.g_height)
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let m_collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        m_collectionView.delegate = self
        m_collectionView.dataSource = self
        m_collectionView.backgroundColor = .white
        m_collectionView.isPagingEnabled = true
        m_collectionView.showsVerticalScrollIndicator = false
        m_collectionView.showsHorizontalScrollIndicator = false
        m_collectionView.scrollsToTop = false
        m_collectionView.contentInsetAdjustmentBehavior = .never
        m_collectionView.register(cellType: LivePhotoCollectionViewCell.self)
        return m_collectionView
    }()
    
    private let m_bootomBar: LiveBottomBar = LiveBottomBar.instance()!
    private let m_liveContentView: PreviewContentView = PreviewContentView.instance()!
    
    private var liveVM: LiveViewModel = LiveViewModel()
    /// datas
    private var datas: [LiveModel] = [LiveModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        m_player.playerDidToEnd = { [weak self] _ in
            self?.m_player.currentPlayerManager.replay()
        }
    }
    
    /// get PreviewContentView
    func getLivePhotoView() -> PreviewContentView {
        return m_liveContentView
    }
    
    /// get bottom bar
    func getBottomBar() -> LiveBottomBar {
        return m_bootomBar
    }
    
    /// get player
    func getPlyer() -> ZFPlayerController {
        return m_player
    }
    
    /// add datas
    func appends(lives values: [LiveModel]) {
        datas += values
    }
    
    /// set datas
    func setData(lives values: [LiveModel]) {
        datas = values
    }
    
    /// get datas
    func getDatas() -> [LiveModel] {
        return datas
    }
    
    /// get live viewmodel
    func getLiveVM() -> LiveViewModel {
        return liveVM
    }
    
    /// get collection view
    func getCollectionView() -> UICollectionView {
        return contentCollectionView
    }
}

extension LivePhotoController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let m_cell: LivePhotoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath, cellType: LivePhotoCollectionViewCell.self)
        let live: LiveModel = datas[indexPath.row]
        m_cell.m_url = live.imageUrl ?? ""
        if indexPath.row > (datas.count - 2) {
            footerRefreshAction()
        }
        return m_cell
    }
    
}

extension LivePhotoController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let live: LiveModel = datas[indexPath.row]
        let m_cell: LivePhotoCollectionViewCell = collectionView.cellForItem(at: indexPath) as! LivePhotoCollectionViewCell
        m_player.currentPlayerManager.view.coverImageView.setImageWithURLString(live.videoUrl ?? "", placeholder: m_cell.image)
        m_player.playTheIndexPath(indexPath, assetURL: URL(string: live.videoUrl ?? "")!)
    }
}

extension LivePhotoController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidEndDecelerating()
        let row: Int = Int(ceil((scrollView.contentOffset.y)/UIScreen.g_height))
        let indexPath: IndexPath = IndexPath(row: row, section: 0)
        let m_collection: UICollectionView = getCollectionView()
        guard let m_cell: LivePhotoCollectionViewCell = m_collection.cellForItem(at: indexPath) as? LivePhotoCollectionViewCell else { return }
        let live: LiveModel = datas[indexPath.row]
        m_player.currentPlayerManager.view.coverImageView.setImageWithURLString(live.videoUrl ?? "", placeholder: m_cell.image)
        m_player.playTheIndexPath(indexPath, assetURL: URL(string: live.videoUrl ?? "")!)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.zf_scrollViewDidEndDraggingWillDecelerate(decelerate)
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidScrollToTop()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidScroll()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewWillBeginDragging()
    }
}
