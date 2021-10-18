//
//  MarginX.swift
//  ishangta
//
//  Created by Senyas on 2021/9/4.
//

import DeviceKit
import Foundation
import ESTabBarController_swift

struct TopMarginX {
    static var margin: CGFloat {
        var margin: CGFloat = 64
        
        let device: Device = Device.current
        if device.isOneOf([Device.iPhoneX, Device.iPhoneXR, Device.iPhoneXS, Device.iPhoneXSMax, Device.iPhone11, Device.iPhone11Pro, Device.iPhone11ProMax, Device.iPhone12, Device.iPhone12Pro, Device.iPhone12Mini, Device.iPhone12ProMax, Device.iPhone13, Device.iPhone13Pro, Device.iPhone13Mini, Device.iPhone13ProMax]) {
            margin = 88
        } else if device.isOneOf([Device.simulator(Device.iPhoneX), Device.simulator(Device.iPhoneXR), Device.simulator(Device.iPhoneXR), Device.simulator(Device.iPhoneXSMax), Device.simulator(Device.iPhone11), Device.simulator(Device.iPhone11Pro), Device.simulator(Device.iPhone11ProMax), Device.simulator(Device.iPhone12), Device.simulator(Device.iPhone12Pro), Device.simulator(Device.iPhone12Mini), Device.simulator(Device.iPhone12ProMax), Device.simulator(Device.iPhone13), Device.simulator(Device.iPhone13Pro), Device.simulator(Device.iPhone13Mini), Device.simulator(Device.iPhone13ProMax)]) {
            margin = 88
        }
        return margin
    }
}

struct BottomMarginX {
    static var margin: CGFloat {
        var margin: CGFloat = 0
        
        let device: Device = Device.current
        if device.isOneOf([Device.iPhoneX, Device.iPhoneXR, Device.iPhoneXS, Device.iPhoneXSMax, Device.iPhone11, Device.iPhone11Pro, Device.iPhone11ProMax, Device.iPhone12, Device.iPhone12Pro, Device.iPhone12Mini, Device.iPhone12ProMax, Device.iPhone13, Device.iPhone13Pro, Device.iPhone13Mini, Device.iPhone13ProMax]) {
            margin = 27
        } else if device.isOneOf([Device.simulator(Device.iPhoneX), Device.simulator(Device.iPhoneXR), Device.simulator(Device.iPhoneXR), Device.simulator(Device.iPhoneXSMax), Device.simulator(Device.iPhone11), Device.simulator(Device.iPhone11Pro), Device.simulator(Device.iPhone11ProMax), Device.simulator(Device.iPhone12), Device.simulator(Device.iPhone12Pro), Device.simulator(Device.iPhone12Mini), Device.simulator(Device.iPhone12ProMax), Device.simulator(Device.iPhone13), Device.simulator(Device.iPhone13Pro), Device.simulator(Device.iPhone13Mini), Device.simulator(Device.iPhone13ProMax)]) {
            margin = 27
        }
        return margin
    }
}

struct TabbarHeight {
    static var m_height: CGFloat {
        return DeviceX.isIPhoneX ? 83 : 49
    }
}

struct DeviceX {
    static var isIPhoneX: Bool {
        
        var _result: Bool = false
        
        let device: Device = Device.current
        if device.isOneOf([Device.iPhoneX, Device.iPhoneXR, Device.iPhoneXS, Device.iPhoneXSMax, Device.iPhone11, Device.iPhone11Pro, Device.iPhone11ProMax, Device.iPhone12, Device.iPhone12Pro, Device.iPhone12Mini, Device.iPhone12ProMax, Device.iPhone13, Device.iPhone13Pro, Device.iPhone13Mini, Device.iPhone13ProMax]) {
            _result = true
        } else if device.isOneOf([Device.simulator(Device.iPhoneX), Device.simulator(Device.iPhoneXR), Device.simulator(Device.iPhoneXR), Device.simulator(Device.iPhoneXSMax), Device.simulator(Device.iPhone11), Device.simulator(Device.iPhone11Pro), Device.simulator(Device.iPhone11ProMax), Device.simulator(Device.iPhone12), Device.simulator(Device.iPhone12Pro), Device.simulator(Device.iPhone12Mini), Device.simulator(Device.iPhone12ProMax), Device.simulator(Device.iPhone13), Device.simulator(Device.iPhone13Pro), Device.simulator(Device.iPhone13Mini), Device.simulator(Device.iPhone13ProMax)]) {
            _result = true
        } else {
            _result = false
        }
        return _result
    }
}
