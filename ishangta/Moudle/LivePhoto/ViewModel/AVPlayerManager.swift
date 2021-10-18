//
//  AVPlayerManager.swift
//  ishangta
//
//  Created by Senyas on 2021/9/25.
//

import UIKit
import ZFPlayer

class AVPlayerManager: ZFAVPlayerManager {
    
    override init() {
        super.init()
        scalingMode = .aspectFill
    }
}
