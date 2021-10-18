//
//  LiveBottomBar.swift
//  ishangta
//
//  Created by Senyas on 2021/9/25.
//

import UIKit

protocol LiveBottomBarDelegate: NSObjectProtocol {
    func preview()
    func download()
}

class LiveBottomBar: UIView {

    weak var delegate: LiveBottomBarDelegate?
    
    @IBOutlet private weak var lb_preview_btn: UIButton!
    @IBOutlet private weak var lb_dowbload_btn: UIButton!
    
    // MARK: - create view instance
    class func instance() -> LiveBottomBar? {
        let nibView = Bundle.main.loadNibNamed("LiveBottomBar", owner: nil, options: nil)
        if let view = nibView?.first as? LiveBottomBar {
            return view
        }
        return nil
    }
    
    @IBAction private func lb_preview_action(_ sender: UIButton) {
        delegate?.preview()
    }
    
    @IBAction private func lb_download_action(_ sender: Any) {
        delegate?.download()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        lb_preview_btn.setImage(Asset.livePreview.image, for: .normal)
        lb_dowbload_btn.setImage(Asset.liveSave.image, for: .normal)
        lb_preview_btn.setTitle("", for: .normal)
        lb_dowbload_btn.setTitle("", for: .normal)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        lb_preview_btn.snp.remakeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        lb_dowbload_btn.snp.remakeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(lb_preview_btn.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
    
    static var m_width: CGFloat {
        return 80
    }
    
    static var m_height: CGFloat {
        return 184
    }
    
}
