//
//  WallpaperDetailController+Delegate.swift
//  ishangta
//
//  Created by Senyas on 2021/9/4.
//

import Foundation
import JXSegmentedView
import Kingfisher
import ESTabBarController_swift

extension WallpaperDetailController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WallpaperDetailController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: WallPaperItemCollectionViewCell.m_width, height: WallPaperItemCollectionViewCell.m_height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return UIColor.clear
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12,left: 12,bottom: 12,right: 12)
    }
    
}

// MARK: - UICollectionViewDelegate
extension WallpaperDetailController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let m_dataSource: [CategoryDetailModel] = getDataSource()
        if indexPath.row < m_dataSource.count {
            let m_cell: WallPaperItemCollectionViewCell = collectionView.cellForItem(at: indexPath) as! WallPaperItemCollectionViewCell
            let m_model: CategoryDetailModel = m_dataSource[indexPath.row]
            let m_url: String = "\(ConfigInfoProvider.shared.getUrlPrefix())\(m_model.wallpaperName ?? "")"
            let m_previewController: PreviewWallPaperController = PreviewWallPaperController(url: m_url, info: m_model, holder: m_cell.holder)
            m_previewController.modalPresentationStyle = .overCurrentContext
            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let tabbarController: ESTabBarController = appdelegate.window?.rootViewController as! ESTabBarController
            tabbarController.present(m_previewController, animated: false, completion: nil)
        } else {
            MBProgressHUD.showMessage("网络异常，请稍后再试~")
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WallpaperDetailController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let m_dataSource: [CategoryDetailModel] = getDataSource()
        return m_dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WallPaperItemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        let m_dataSource: [CategoryDetailModel] = getDataSource()
        if indexPath.row < m_dataSource.count {
            let m_model: CategoryDetailModel = m_dataSource[indexPath.row]
            cell.url = m_model.wallpaperName ?? ""
        }
        
        if indexPath.row > (m_dataSource.count - 3) {
            footerRefreshAction()
        }
        
        return cell
    }

}
