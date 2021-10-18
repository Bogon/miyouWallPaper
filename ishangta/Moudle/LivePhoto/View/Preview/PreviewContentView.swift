//
//  PreviewContentView.swift
//  ishangta
//
//  Created by Senyas on 2021/9/27.
//

import UIKit
import PhotosUI

protocol PreviewContentViewDelegate: NSObjectProtocol {
    func previewLivePhotoEvent(liveView view: PreviewContentView, isViewing: Bool)
}

class PreviewContentView: UIView {

    weak var delegate: PreviewContentViewDelegate?
    
    private lazy var m_livePhotoView: PHLivePhotoView = {
        let live: PHLivePhotoView = PHLivePhotoView(frame: .zero)
        return live
    }()

    @IBOutlet private weak var m_notice_label: UILabel!
    @IBOutlet private weak var pc_holder_imageview: UIImageView!
    
    var livePhoto: PHLivePhoto? {
        didSet {
            m_livePhotoView.livePhoto = livePhoto
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
                self?.m_notice_label.isHidden = true
            }
        }
    }
    
    // MARK: - create view instance
    class func instance() -> PreviewContentView? {
        let nibView = Bundle.main.loadNibNamed("PreviewContentView", owner: nil, options: nil)
        if let view = nibView?.first as? PreviewContentView {
            return view
        }
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        addSubview(m_livePhotoView)
        bringSubviewToFront(pc_holder_imageview)
        pc_holder_imageview.image = UIImage(named: PreviewHomeLockProvider.share.getLockImage())
        
        isUserInteractionEnabled = true
        pc_holder_imageview?.isUserInteractionEnabled = true
        
        let m_longGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressEvent(gesture:)))
        pc_holder_imageview.addGestureRecognizer(m_longGesture)
        
        let m_tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapEvent))
        pc_holder_imageview.addGestureRecognizer(m_tapGesture)
        
        bringSubviewToFront(m_notice_label)
        
    }
    
    @objc private func tapEvent() {
        delegate?.previewLivePhotoEvent(liveView: self, isViewing: false)
    }
    
    @objc private func longPressEvent(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .ended {
            m_livePhotoView.stopPlayback()
            delegate?.previewLivePhotoEvent(liveView: self, isViewing: false)
        } else if gesture.state == .began {
            delegate?.previewLivePhotoEvent(liveView: self, isViewing: true)
            m_livePhotoView.startPlayback(with: .full)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        m_livePhotoView.snp.remakeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.right.equalTo(self.snp.right)
            make.left.equalTo(self.snp.left)
        }
        
        pc_holder_imageview.snp.remakeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.right.equalTo(self.snp.right)
            make.left.equalTo(self.snp.left)
        }
        
        m_notice_label.snp.remakeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 120, height: 50))
        }
    }
    
    static var m_width: CGFloat {
        return UIScreen.g_width
    }
    
    static var m_height: CGFloat {
        return UIScreen.g_height
    }

}
