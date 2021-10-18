//
//  SettingController.swift
//  ishangta
//
//  Created by Senyas on 2021/10/9.
//

import AMScrollingNavbar
import MJRefresh
import Reusable
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class SettingController: AppearanceViewController {
    let bag = DisposeBag()

    private var viewModel: SettingViewModel?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    lazy var settingTableView: UITableView = {
        var contentTableView = UITableView()
        contentTableView.backgroundColor = .clear
        contentTableView.separatorStyle = .none
        return contentTableView
    }()
    
    let header: SettingHeader = SettingHeader.instance()!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        navigationItem.title = "设置"

        setupSubviews()
        
        viewModel = SettingViewModel(dependency: (disposeBag: bag, networkService: SettingNetworkService()))

        load()

        settingTableView.rx.itemSelected.bind { [weak self] indexPath in
            self?.settingTableView.deselectRow(at: indexPath, animated: true)
            let settingListSection: SettingListSection = (self?.viewModel!.tableData.value[indexPath.section])!
            let itemInfoModel: SettingItemInfoModel = settingListSection.items[indexPath.row] as SettingItemInfoModel
            self?.dealWithSettingType(settingType: itemInfoModel.type!)
        }.disposed(by: bag)
    }

}

private extension SettingController {

    /// 处理设置点击事件信息
    func dealWithSettingType(settingType value: SettingType) {
        switch value {
        case .protocols:
            // 展示协议
            let procotolController = ProcotolController(url: "https://xuebaonline.com/%E8%9C%9C%E6%9F%9A%E7%94%A8%E6%88%B7%E5%8D%8F%E8%AE%AE%E4%B8%8E%E9%9A%90%E7%A7%81%E6%94%BF%E7%AD%96/", title: "用户协议")
            procotolController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(procotolController, animated: true)

        case .version:
            MBProgressHUD.showMessage("当前已是最新版本", to: view)

        case .clear:
            ClearCache.share.clear()
            viewModel?.reload()
            MBProgressHUD.showMessage("缓存已清除", to: view)
            
        case .privacy:
            // 展示协议
            let procotolController = ProcotolController(url: "https://xuebaonline.com/%E8%9C%9C%E6%9F%9A%E9%9A%90%E7%A7%81%E6%94%BF%E7%AD%96/", title: "隐私协议")
            procotolController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(procotolController, animated: true)
        }
    }

    /// 1.保证网络正常的情况下加载骨架动画和请求数据
    func load() {
        /// 设置 DataSource
        let dataSource = RxTableViewSectionedReloadDataSource<SettingListSection>(configureCell: { _, tv, ip, item in
            let cell: SettingTableViewCell = tv.dequeueReusableCell(for: ip)
            cell.selectionStyle = .none
            cell.type = item.type!
            return cell
        })

        _ = viewModel!.tableData.asObservable().bind(to: settingTableView.rx.items(dataSource: dataSource))
    }
}

extension SettingController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return SettingTableViewCell.layoutHeight
    }
}
