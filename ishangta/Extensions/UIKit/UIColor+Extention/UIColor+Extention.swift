//
//  UIColor+Extention.swift
//  ishangta
//
//  Created by Senyas on 2021/9/22.
//

import Foundation
import UIKit

extension UIColor {
    
    func image(_ size: CGSize = .zero) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    var image: UIImage {
        return UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size:  CGSize(width: 1, height: 1)))
        }
    }
    
    static func random() -> UIColor {
        return UIColor(
            red:   .random(in: 0...1),
            green: .random(in: 0...1),
            blue:  .random(in: 0...1),
            alpha: 1.0
        )
    }
}
