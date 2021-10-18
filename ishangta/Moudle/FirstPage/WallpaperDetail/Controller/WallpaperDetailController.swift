//
//  WallpaperDetailController.swift
//  ishangta
//
//  Created by Senyas on 2021/9/4.
//

import UIKit

class WallpaperDetailController: UIViewController {

    /****************************************************************/
    private var m_contentCollectionView: UICollectionView = {
        let _lay_out: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: _lay_out)
        collectionView.keyboardDismissMode = .onDrag
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()

    private let biz_categoryVM: CategoryViewModel = CategoryViewModel()
    
    private var m_category_info: CategoryModel?
    private var m_dataSource: [CategoryDetailModel] = []
    private var page: Int = 0
    
    init(category_info info: CategoryModel?) {
        super.init(nibName: nil, bundle: nil)
        m_category_info = info
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpUI()
        
        if m_category_info != nil {
            initailzeSourceData()
        } else {
            
        }
        
    }
    
    /// first initailze source data
    private func initailzeSourceData() {
        /// 首次进入刷新
        m_contentCollectionView.mj_header?.beginRefreshing()
    }
    
    /// headerRefresh
    @objc func headerRefreshAction() {
        page = 0
        let params: [String: Any] = ["wallpaperClassifyId": m_category_info!.id as Any, "pageNum": page, "pageSize": 9]
        biz_categoryVM.detail(params: params).done { [weak self] (response) in
            self?.setDataSource(details: response?.m_data ?? [])
            self?.m_contentCollectionView.reloadData()
            self?.m_contentCollectionView.mj_header?.endRefreshing()
            self?.m_contentCollectionView.mj_footer?.resetNoMoreData()
        }.catch { [weak self] (_) in
            self?.m_contentCollectionView.mj_header?.endRefreshing()
            self?.m_contentCollectionView.mj_footer?.resetNoMoreData()
        }
    }
    
    /// footerRefresh
    @objc func footerRefreshAction() {
        page += 1
        let params: [String: Any] = ["wallpaperClassifyId": m_category_info!.id as Any, "pageNum": page, "pageSize": 9]
        biz_categoryVM.detail(params: params).done { [weak self] (response) in
            let s_dataSource: [CategoryDetailModel] = response?.m_data ?? []
            if s_dataSource.isEmpty {
                self?.m_contentCollectionView.mj_footer?.endRefreshingWithNoMoreData()
            } else {
                var ss_dataSource: [CategoryDetailModel] = self?.getDataSource() ?? []
                ss_dataSource.append(contentsOf: s_dataSource)
                self?.setDataSource(details: ss_dataSource)
                self?.m_contentCollectionView.reloadData()
                self?.m_contentCollectionView.mj_footer?.endRefreshing()
            }
            
        }.catch { [weak self] (_) in
            self?.m_contentCollectionView.mj_footer?.endRefreshing()
        }
    }
    
    /// set data source
    func setDataSource(details value: [CategoryDetailModel]) {
        m_dataSource = value
    }
    
    /// get data source
    func getDataSource() -> [CategoryDetailModel] {
        return m_dataSource
    }
    
    /// get content collecitonview
    func getContentCollectionView() -> UICollectionView {
        return m_contentCollectionView
    }
    
}
