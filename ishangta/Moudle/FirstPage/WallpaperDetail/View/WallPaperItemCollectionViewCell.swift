//
//  WallPaperItemCollectionViewCell.swift
//  ishangta
//
//  Created by Senyas on 2021/9/4.
//

import UIKit
import Reusable
import Kingfisher

private let wp_width: CGFloat = (ScreenWidth - 36)/3.0
private let wp_height: CGFloat = 260

class WallPaperItemCollectionViewCell: UICollectionViewCell, NibReusable {

    static var reuseIdentifier: String { "WallPaperItemCollectionViewCell" }
    
    @IBOutlet private weak var m_cover_imageview: UIImageView!
    
    /// url
    var url: String = "" {
        didSet {
            if url.isEmpty {

            } else {
                let m_url: String = "\(ConfigInfoProvider.shared.getUrlPrefix())\(url)"
                let processor = DownsamplingImageProcessor(size: m_cover_imageview.bounds.size)
                m_cover_imageview.kf.indicatorType = .activity
                m_cover_imageview.kf.setImage(with: URL(string: m_url)!, placeholder: Asset.ph1.image, options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ]) { _ in
                    
                }
            }
        }
    }
    
    var holder: UIImage {
        get {
            return m_cover_imageview.image ?? Asset.ph1.image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.backgroundColor = .white
        self.backgroundColor = .white
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10.0
        
        m_cover_imageview.contentMode = .scaleAspectFill
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        m_cover_imageview.snp.remakeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    /// get imageview
    func getImageView() -> UIImageView {
        return m_cover_imageview
    }

    static var m_height: CGFloat {
        return wp_height
    }
    
    static var m_width: CGFloat {
        return wp_width
    }
}
