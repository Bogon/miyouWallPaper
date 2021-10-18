//
//  LivePhotoController+Delegate.swift
//  ishangta
//
//  Created by Senyas on 2021/9/25.
//

import Foundation
import UIKit
import Photos
import Kingfisher
import PromiseKit
import Alamofire

extension LivePhotoController: PreviewContentViewDelegate {
    
    func previewLivePhotoEvent(liveView view: PreviewContentView, isViewing: Bool) {
        guard let window: UIWindow = (UIApplication.shared.delegate?.window)! else { return }
        let m_tabbarController: MainTabbarController = window.rootViewController as! MainTabbarController
        m_tabbarController.setHiddenTabbar(isHidden: isViewing)
        let m_bootomBar: LiveBottomBar = getBottomBar()
        m_bootomBar.isHidden = isViewing
        view.isHidden = !isViewing
    }
}

extension LivePhotoController: LiveBottomBarDelegate {
    
    func preview() {
        let m_liveView: PreviewContentView = getLivePhotoView()
        guard let window: UIWindow = (UIApplication.shared.delegate?.window)! else { return }
        let m_tabbarController: MainTabbarController = window.rootViewController as! MainTabbarController
        processLivePhoto { [weak self] _, photo in
            DispatchQueue.main.async {
                MBProgressHUD.hide(self?.view)
                m_liveView.livePhoto = photo?.livePhoto
                m_liveView.isHidden = false
                m_tabbarController.setHiddenTabbar(isHidden: true)
            }
        }
        
    }
    
    func download() {
        processLivePhoto { [weak self] status, photo in
            self?.export(live: photo!) { done, _ in
                if done {
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(self?.view)
                        MBProgressHUD.showSuccess("保存成功"
                        )
                    }
                } else {
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(self?.view)
                        MBProgressHUD.showError("保存失败")
                    }
                }
            }
        }
    }
    
    func processLivePhoto(fulfil finished: @escaping ((_ status: Bool, _ photo: PHLivePhotoPlus?) -> Void)) {
        let m_collection: UICollectionView = getCollectionView()
        let m_datas: [LiveModel] = getDatas()
        let row: Int = Int(ceil((m_collection.contentOffset.y)/UIScreen.g_height))
        let indexPath: IndexPath = IndexPath(row: row, section: 0)
        let live: LiveModel = m_datas[indexPath.row]
        
        let filename: String = (live.videoUrl ?? "").components(separatedBy: "/").last ?? ""
        // Given
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = "\(documentsPath)/\(filename)"
        var urlString = URLRequest(url: URL(string: live.videoUrl ?? "")!)
        urlString.headers = ["UserAgent": "JKWMainProject/5 CFNetwork/1240.0.4 Darwin/20.6.0"]
        let destination: DownloadRequest.Destination = { _, _ in
            return (URL(fileURLWithPath: filePath), [[.createIntermediateDirectories, .removePreviousFile]])
        }
        
        MBProgressHUD.showLoading("生成中…", to: view)
        // When
        AF.download(urlString, to: destination)
            .response { [weak self] _ in
                self?.writeLivePhoto(videoPath: filePath, fulfil: finished)
            }
    }
    
    private func writeLivePhoto(videoPath value: String, fulfil: @escaping ((_ status: Bool, _ photo: PHLivePhotoPlus?) -> Void)) {
        
        let generator: LivePhotoGenerator? = LivePhotoGenerator()
        generator?.generate(livePhoto: URL(fileURLWithPath: value)) { [weak self] success, photo, _, _ in
            if success {
                fulfil(success, photo)
            } else {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(self?.view)
                    MBProgressHUD.showError("未知错误，请重试！")
                }
            }
        }
    }

    private func downloadFile(fileURL url: String) -> Promise<String> {
        return Promise { seal in
            let filename: String = url.components(separatedBy: "/").last ?? ""
            if !(filename.isEmpty) {
                DispatchQueue.global(qos: .background).async {
                    if let url = URL(string: url),
                       let urlData = NSData(contentsOf: url) {
                        if filename.contains("png") {
                            let ciImage: CIImage = CIImage(data: urlData as Data) ?? CIImage()
                            let context: CIContext = CIContext()
                            context.jpegRepresentation(of: ciImage, colorSpace: ciImage.colorSpace!, options: [:])
                            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                            let filePath = "\(documentsPath)/\(filename.components(separatedBy: ".").first ?? "").jpeg"
                            DispatchQueue.main.async {
                                urlData.write(toFile: filePath, atomically: true)
                                seal.fulfill(filePath)
                            }
                        }
                        
                        if filename.contains("mp4") {
                            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                            let filePath = "\(documentsPath)/\(filename)"
                            DispatchQueue.main.async {
                                urlData.write(toFile: filePath, atomically: true)
                                seal.fulfill(filePath)
                            }
                        }
                    }
                }
            }
        }
    }
    
    /**
     A method that exports a `PHLivePhotoPlus` 🎇 object to the Photo Library 📲💾.
     
     - parameter photo: A `PHLivePhotoPlus` object that can be set to the returned `PHLivePhotoPlus` object in the `livePhoto(export: Bool, _ finished:{})` method.
     
     - parameter finished: A block that will be called when the export process is complete.
     
     The block returns the following parameters:
     
     `exported`
     A boolean that returns `true` when the Live Photo is successfully exported to the Photo Library. Otherwise, it returns `false`.
     
     `permissionStatus`
     A `PHAuthorizationStatus` object that returns the current application's status for exporting media to the Photo Library.
     */
    @objc public func export(live photo: PHLivePhotoPlus, _ finished: ((_ exported: Bool, _ permissionStatus: PHAuthorizationStatus) -> Void)? = nil) {
        guard let keyPhotoPath = photo.keyPhotoPath else {
            LogAR.message("An error occurred while exporting a live photo")
            return
        }
        guard let videoPath = photo.pairedVideoPath else {
            LogAR.message("An error occurred while exporting a live photo")
            return
        }
        
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization() { status in
                // Recursive call after authorization request
                self.export(live: photo, finished)
            }
        } else if status == .authorized {
            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetCreationRequest.forAsset()
                let options = PHAssetResourceCreationOptions()
                request.addResource(with: .photo, fileURL: keyPhotoPath, options: options)
                request.addResource(with: .pairedVideo, fileURL: videoPath, options: options)
            }) { saved, error  in
                if saved {
                    LogAR.remove(from: keyPhotoPath)
                    LogAR.remove(from: videoPath)
                } else {
                    LogAR.message("An error occurred while exporting a live photo: \(error!)")
                }
                finished?(saved, status)
            }
        } else if status == .denied || status == .restricted {
            finished?(false, status)
        }
    }
}

//Simple Logging to show logs only while debugging.
class LogAR {
    class func message(_ message: String) {
        #if DEBUG
            print("ARVideoKit @ \(Date().timeIntervalSince1970):- \(message)")
        #endif
    }
    
    class func remove(from path: URL?) {
        if let file = path?.path {
            let manager = FileManager.default
            if manager.fileExists(atPath: file) {
                do {
                    try manager.removeItem(atPath: file)
                    self.message("Successfuly deleted media file from cached after exporting to Camera Roll.")
                } catch let error {
                    self.message("An error occurred while deleting cached media: \(error)")
                }
            }
        }
    }
}

/*
private func downloadFile2(fileURL url: String) -> Promise<String> {
    return Promise { seal in
        let filename: String = url.components(separatedBy: "/").last ?? ""
        if !(filename.isEmpty) {
            DispatchQueue.global(qos: .background).async {
                if let url = URL(string: url),
                   let urlData = NSData(contentsOf: url) {
                    if filename.contains("png") {
                        let ciImage: CIImage = CIImage(data: urlData as Data) ?? CIImage()
                        let context: CIContext = CIContext()
                        context.jpegRepresentation(of: ciImage, colorSpace: ciImage.colorSpace!, options: [:])
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                        let filePath = "\(documentsPath)/\(filename.components(separatedBy: ".").first ?? "").jpeg"
                        DispatchQueue.main.async {
                            urlData.write(toFile: filePath, atomically: true)
                            seal.fulfill(filePath)
                        }
                    }
                    
                    if filename.contains("mp4") {
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                        let filePath = "\(documentsPath)/\(filename)"
                        DispatchQueue.main.async {
                            urlData.write(toFile: filePath, atomically: true)
                            seal.fulfill(filePath)
                            
//                                let avAsset: AVURLAsset = AVURLAsset(url: URL(fileURLWithPath: filePath), options: [:])
//                                let compatiblePresets: [String] = AVAssetExportSession.exportPresets(compatibleWith: avAsset)
//                                if compatiblePresets.contains(AVAssetExportPresetMediumQuality) {
//                                    let exportSession: AVAssetExportSession = AVAssetExportSession.init(asset: avAsset, presetName: AVAssetExportPresetMediumQuality)!
//                                    let f_m_name: String = "movie.mov"
//                                    let m_filePath = "\(documentsPath)/\(f_m_name)"
//
//                                    if FileManager.default.fileExists(atPath:  m_filePath) {
//                                        try! FileManager.default.removeItem(atPath: m_filePath)
//                                    }
//
//                                    exportSession.outputURL = URL(fileURLWithPath: m_filePath)
//                                    exportSession.outputFileType = .mov
//                                    exportSession.shouldOptimizeForNetworkUse = true
//                                    exportSession.exportAsynchronously {
//                                        if exportSession.status == .completed {
//                                            seal.fulfill(m_filePath)
//
//                                        } else if exportSession.status == .failed {
//                                            debugPrint("mp4转mov失败: \(exportSession.error)")
//                                        }
//                                    }
//
//                                }
                        }
                    }
                }
            }
        }
    }
}
 */
