//
//  SettingHeader.swift
//  ishangta
//
//  Created by Senyas on 2021/10/16.
//

import UIKit

class SettingHeader: UIView {

    @IBOutlet weak var sh_imageview: UIImageView!
    @IBOutlet weak var sh_content_label: UILabel!
    
    class func instance() -> SettingHeader? {
        let nibView = Bundle.main.loadNibNamed("SettingHeader", owner: nil, options: nil)
        if let view = nibView?.first as? SettingHeader {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.masksToBounds = true
        clipsToBounds = true

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        sh_imageview.snp.remakeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(30)
            make.size.equalTo(CGSize(width: 120, height: 120))
        }

        sh_content_label.snp.remakeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(sh_imageview.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
    }

    static var layoutHeight: CGFloat {
        let contentHeight: CGFloat = 250
        return contentHeight
    }
    
}
