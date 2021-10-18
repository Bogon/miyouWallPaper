//
//  BottomBar.swift
//  ishangta
//
//  Created by Senyas on 2021/9/5.
//

import UIKit
import Hue

enum BottomBarType {
    case preview
    case download
    case share
}

protocol BottomBarProtocol: NSObjectProtocol {
    /// bottom bar event
    func bottomBarEvent(bottomBar view: BottomBar, type: BottomBarType, sender: UIButton)
}

class BottomBar: UIView {

    weak var delegate: BottomBarProtocol?
    
    @IBOutlet private weak var b_preview_button: UIButton!
    @IBOutlet private weak var b_download_button: UIButton!
    @IBOutlet private weak var b_share_button: UIButton!
    
    // MARK: - create view instance
    class func instance() -> BottomBar? {
        let nibView = Bundle.main.loadNibNamed("BottomBar", owner: nil, options: nil)
        if let view = nibView?.first as? BottomBar {
            return view
        }
        return nil
    }
    
    /// preview
    @IBAction func bb_previewAction(_ sender: UIButton) {
        delegate?.bottomBarEvent(bottomBar: self, type: .preview, sender: sender)
    }
    
    /// download
    @IBAction func bb_downloadAction(_ sender: UIButton) {
        delegate?.bottomBarEvent(bottomBar: self, type: .download, sender: sender)
    }
    
    /// share
    @IBAction func bb_shareAction(_ sender: UIButton) {
        delegate?.bottomBarEvent(bottomBar: self, type: .share, sender: sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(hex: "#000000").alpha(0.7)
        
        b_preview_button.contentHorizontalAlignment = .center
        b_download_button.contentHorizontalAlignment = .center
        b_share_button.contentHorizontalAlignment = .center
        
        b_preview_button.titleEdgeInsets = UIEdgeInsets(top: (b_preview_button.imageView?.frame.size.height)! + 12, left: -(b_preview_button.imageView?.frame.size.width)!, bottom: 0, right: 0)
        b_download_button.titleEdgeInsets = UIEdgeInsets(top: (b_download_button.imageView?.frame.size.height)!  + 12, left: -(b_download_button.imageView?.frame.size.width)!, bottom: 0, right: 0)
        b_share_button.titleEdgeInsets = UIEdgeInsets(top: (b_share_button.imageView?.frame.size.height)!  + 12, left: -(b_share_button.imageView?.frame.size.width)!, bottom: 0, right: 0)
        
        b_preview_button.imageEdgeInsets = UIEdgeInsets(top: -14, left: 0, bottom: 0, right: -(b_preview_button.titleLabel?.bounds.size.width)!)
        b_download_button.imageEdgeInsets = UIEdgeInsets(top: -14, left: 0, bottom: 0, right: -(b_download_button.titleLabel?.bounds.size.width)!)
        b_share_button.imageEdgeInsets = UIEdgeInsets(top: -14, left: 0, bottom: 0, right: -(b_share_button.titleLabel?.bounds.size.width)!)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let b_width: CGFloat = ScreenWidth/3.0
        b_preview_button.snp.remakeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.width.equalTo(b_width)
            make.bottom.equalTo(self.snp.bottom).offset(-BottomMarginX.margin)
        }
        
        b_download_button.snp.remakeConstraints { make in
            make.left.equalTo(b_preview_button.snp.right)
            make.top.equalTo(self.snp.top)
            make.width.equalTo(b_width)
            make.bottom.equalTo(self.snp.bottom).offset(-BottomMarginX.margin)
        }
        
        b_share_button.snp.remakeConstraints { make in
            make.left.equalTo(b_download_button.snp.right)
            make.top.equalTo(self.snp.top)
            make.width.equalTo(b_width)
            make.bottom.equalTo(self.snp.bottom).offset(-BottomMarginX.margin)
        }
    }
    
    static var m_width: CGFloat {
        return ScreenWidth
    }
    
    static var m_height: CGFloat {
        return 60 + BottomMarginX.margin
    }

}
