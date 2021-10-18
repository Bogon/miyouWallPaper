//
//  FirstPageController.swift
//  ishangta
//
//  Created by Senyas on 2021/9/4.
//

import UIKit
import JXSegmentedView

class FirstPageController: AppearanceViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var navigationBarStyle: AppearanceBarStyle {
        return .nb_white
    }
    
    private let segmentedView = JXSegmentedView()
    
    private lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()

    /// private data source
    private lazy var seg_datasource: JXSegmentedTitleDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleSelectedColor = UIColor.black
        dataSource.titleSelectedFont = .systemFont(ofSize: 16)
        dataSource.titleNormalFont = .systemFont(ofSize: 14)
        dataSource.titleNormalColor = UIColor.black
        dataSource.titles = []
        return dataSource
    }()

    /// private indicator
    private lazy var seg_indicator: JXSegmentedIndicatorLineView = {
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 14
        indicator.lineStyle = .normal
        indicator.indicatorColor = UIColor.black
        return indicator
    }()

    /// private contains controller
    private var segmentControllers: [Int: WallpaperDetailController] = [:]

    private let biz_categoryVM: CategoryViewModel = CategoryViewModel()
    
    private var m_categorys: [CategoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpUI()

        biz_categoryVM.category().done { [weak self] (response) in
            guard let self = self else { return }
            self.setSegmentDataSourceTitles(titles: response?.biz_titles ?? [], categorys: response?.m_data ?? [])
        }.catch { (_) in }
    }
    
    /// get categorys
    func getCategorys() -> [CategoryModel] {
        return m_categorys
    }
    
    /// set categorys
    func setCategorys(categorys value: [CategoryModel]) {
        m_categorys = value
    }
    
    /// set segment datasoure titles
    func setSegmentDataSourceTitles(titles value: [String], categorys: [CategoryModel]) {
        setCategorys(categorys: categorys)
        seg_datasource.titles = value
        segmentedView.reloadData()
    }
    
    /// get segment controllers
    func getSegmentControllers() -> [Int: WallpaperDetailController] {
        return segmentControllers
    }
    
    func getSegmentIndicatorLine() -> JXSegmentedIndicatorLineView {
        return seg_indicator
    }
    
    func setSegmentControllers(seg_controllers: [Int: WallpaperDetailController]) {
        segmentControllers = seg_controllers
    }

    /// setting segmentview datasource and indicator
    func settingSegDataSourceIndicator() {
        segmentedView.indicators = [seg_indicator]
        segmentedView.dataSource = seg_datasource
        segmentedView.delegate = self
        navigationItem.titleView = segmentedView

        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
    }

    /// private get segmented datasource
    func getSegmentedDataSource() -> JXSegmentedTitleDataSource {
        return seg_datasource
    }

    /// get segmentedView
    func getSegmentedView() -> JXSegmentedView {
        return segmentedView
    }

    /// get listContainerView
    func getListContainerView() -> JXSegmentedListContainerView {
        return listContainerView
    }
    
}
