//
//  PreviewWallPaperController+Delegate.swift
//  ishangta
//
//  Created by Senyas on 2021/9/17.
//

import Foundation
import Photos
import Kingfisher
import PopMenu

extension PreviewWallPaperController: BottomBarProtocol {
    
    /// bottom bar event
    func bottomBarEvent(bottomBar view: BottomBar, type: BottomBarType, sender: UIButton) {
        switch type {
        
        case .preview:
            
            // 使用管理器
            let manager = PopMenuManager.default
            manager.actions = [
                PopMenuDefaultAction(title: "🔐锁屏幕预览", image:  UIImage(named: "icon"), didSelect: { [weak self] _ in
                    self?.showLock()
                }),
                PopMenuDefaultAction(title: "📱主屏幕预览", image: UIImage(named: "icon"), didSelect: { [weak self] _ in
                    self?.showHome()
                })
            ]
            manager.popMenuAppearance.popMenuCornerRadius = 10
            manager.popMenuAppearance.popMenuColor.backgroundColor = .solid(fill: .gray) // 一个纯灰色的菜单背景色
            manager.popMenuAppearance.popMenuColor.backgroundColor = .gradient(fill: .yellow, .purple)
            manager.present(sourceView: sender)
        
        case .download:
            
            let m_actions: [PopMenuDefaultAction] = getDownloadInfo().wallpaperElements?.compactMap({ [weak self] e_info in
                return PopMenuDefaultAction(title: e_info.m_title, image:  UIImage(named: "icon"), didSelect: { action in
                    let m_filter: [WallpeperElementModel] = self?.getDownloadInfo().wallpaperElements?.filter({ $0.m_title == action.title }) ?? []
                    if !m_filter.isEmpty {
                        let w_info: WallpeperElementModel = m_filter.first!
                        let url: String = "\(ConfigInfoProvider.shared.getUrlPrefix())\(w_info.pixels ?? "")"
                        self?.download(url)
                    }
                })
            }) ?? []
            
            // 使用管理器
            let manager = PopMenuManager.default
            manager.actions = m_actions
            manager.popMenuAppearance.popMenuCornerRadius = 10
            manager.popMenuAppearance.popMenuColor.backgroundColor = .solid(fill: .gray) // 一个纯灰色的菜单背景色
            manager.popMenuAppearance.popMenuColor.backgroundColor = .gradient(fill: .yellow, .purple)
            manager.present(sourceView: sender)
            
        case .share:
            share()
            
        }
    }
    
    /// download
    private func download(_ url: String) {
        MBProgressHUD.showLoading("下载图片中…", to: view)
        KingfisherManager.shared.retrieveImage(with: URL(string: url)!) { [weak self] result in
            switch result {
            case .success(let value):
                self?.save(image: value.image)
                
            case .failure(_):
                MBProgressHUD.showError("下载图片失败，请重试")
            }
        }
        
    }
    
    /// save
    private func save(image value: UIImage) {
        MBProgressHUD.hide(view)
        /// authorization
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            saveImage(image: value)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self](status) in
                if status == .authorized {
                    self?.saveImage(image: value)
                } else {
                    MBProgressHUD.showMessage("请在设置中打开访问相册权限~")
                }
            }
            
        case .restricted, .denied, .limited:
            if let url = URL.init(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            
        @unknown default:
            break
        }
    }
    
    /// private share event
    private func share() {
        /// url
        let m_url: String = getURL()
        let m_imageView: UIImageView = getWallPaperImageView()
        let url  = URL.init(string: m_url)!
        let array: [Any] = ["分享给你一个好看的壁纸 - 来自 蜜柚壁纸", m_imageView.image as Any, url]
        let activityVC = UIActivityViewController.init(activityItems: array, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = { (type, completed, _, _) in
            if type != nil {
                if completed {
                    MBProgressHUD.showSuccess("分享成功✌🏻")
                } else {
                    MBProgressHUD.showMessage("分享失败😌")
                }
            }
        }
    }
    
    /// save image
    private func saveImage(image value: UIImage) {
        MBProgressHUD.showLoading("保存图片中", to: view)
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: value)
        }) { [weak self] (isSuccess, _) in
            DispatchQueue.main.async {
                self?.save(isSuccess: isSuccess)
            }
        }
    }
    
    /// save event
    private func save(isSuccess value: Bool) {
        MBProgressHUD.hide(view)
        if value {
            MBProgressHUD.showSuccess("保存成功✌🏻")
        } else {
            MBProgressHUD.showMessage("保存失败😌")
        }
    }
}
