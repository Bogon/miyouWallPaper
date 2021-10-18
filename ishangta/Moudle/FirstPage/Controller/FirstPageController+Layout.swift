//
//  FirstPageController+Layout.swift
//  ishangta
//
//  Created by Senyas on 2021/9/4.
//

import Foundation
import JXSegmentedView
import SnapKit

extension FirstPageController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setUpUI() {
        
        let n_imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 87, height: 46))
        n_imageView.image = Asset.titleView.image
        navigationItem.titleView = n_imageView
        
        view.backgroundColor = .white
        
        let seg_indicator: JXSegmentedIndicatorLineView = getSegmentIndicatorLine()
        let seg_datasource: JXSegmentedTitleDataSource = getSegmentedDataSource()
        
        let m_segmentView: JXSegmentedView = getSegmentedView()
        let m_listContainerView: JXSegmentedListContainerView = getListContainerView()
        
        m_segmentView.indicators = [seg_indicator]
        m_segmentView.dataSource = seg_datasource
        m_segmentView.delegate = self
        m_segmentView.listContainer = m_listContainerView
        
        view.addSubview(m_segmentView)
        view.addSubview(m_listContainerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let m_segmentView: JXSegmentedView = getSegmentedView()
        m_segmentView.snp.remakeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.height.equalTo(44)
        }
        
        let m_listContainerView: JXSegmentedListContainerView = getListContainerView()
        m_listContainerView.snp.remakeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(m_segmentView.snp.bottom)
            make.bottom.equalTo(view.snp.bottom).offset(-TabbarHeight.m_height)
        }
    }
}
