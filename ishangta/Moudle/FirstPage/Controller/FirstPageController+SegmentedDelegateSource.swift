//
//  FirstPageController+SegmentedDelegateSource.swift
//  ishangta
//
//  Created by Senyas on 2021/9/4.
//

import Foundation
import JXSegmentedView

extension FirstPageController: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
        if let dotDataSource = getSegmentedDataSource() as? JXSegmentedDotDataSource {
            dotDataSource.dotStates[index] = false
            segmentedView.reloadItem(at: index)
        }
    }
}

extension FirstPageController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        let m_segmentView: JXSegmentedView = getSegmentedView()
        if let titleDataSource = m_segmentView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        let m_categorys: [CategoryModel] = getCategorys()
        var m_category: CategoryModel?
        
        if index < m_categorys.count {
            m_category = m_categorys[index]
        }
        let m_wallpaperDetailController: WallpaperDetailController = WallpaperDetailController(category_info: m_category)
        var m_segControllers: [Int: WallpaperDetailController] = getSegmentControllers()
        m_segControllers[index] = m_wallpaperDetailController
        setSegmentControllers(seg_controllers: m_segControllers)
        
        return m_wallpaperDetailController as JXSegmentedListContainerViewListDelegate
    }
    
}
