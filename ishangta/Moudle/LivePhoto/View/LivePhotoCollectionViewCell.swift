//
//  LivePhotoCollectionViewCell.swift
//  ishangta
//
//  Created by Senyas on 2021/9/25.
//

import UIKit
import Reusable
import Kingfisher

class LivePhotoCollectionViewCell: UICollectionViewCell, NibReusable {
    static var reuseIdentifier: String { "LivePhotoCollectionViewCell" }

    @IBOutlet private weak var bg_imageview: UIImageView!
    
    var indexPath: IndexPath!
    
    var m_url: String = "" {
        didSet {
            let processor = DownsamplingImageProcessor(size: bg_imageview.bounds.size)
            bg_imageview.kf.indicatorType = .activity
            bg_imageview.kf.setImage(with: URL(string: m_url)!, placeholder: Asset.ph1.image, options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { _ in }
        }
    }
    
    var image: UIImage {
        get {
            return bg_imageview.image ?? Asset.ph1.image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .random()
        contentView.tag = kPlayerViewTag
        
        bg_imageview.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bg_imageview.snp.remakeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }

}
