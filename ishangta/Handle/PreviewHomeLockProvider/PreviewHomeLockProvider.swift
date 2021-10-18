//
//  PreviewHomeLockProvider.swift
//  ishangta
//
//  Created by Senyas on 2021/9/17.
//

import Foundation
import DeviceKit

struct PreviewHomeLockProvider {
    
    internal static let share = PreviewHomeLockProvider()
    private init() {}
    
    /// get lock image
    func getLockImage() -> String {
        var m_lock: String = ""
        let device: Device = Device.current
        if device.isOneOf([Device.iPhoneX, Device.iPhoneXR, Device.iPhoneXS, Device.iPhoneXSMax, Device.iPhone11, Device.iPhone11Pro, Device.iPhone11ProMax, Device.iPhone12, Device.iPhone12Pro, Device.iPhone12Mini, Device.iPhone12ProMax, Device.iPhone13, Device.iPhone13Pro, Device.iPhone13Mini, Device.iPhone13ProMax]) || device.isOneOf([Device.simulator(Device.iPhoneX), Device.simulator(Device.iPhoneXR), Device.simulator(Device.iPhoneXR), Device.simulator(Device.iPhoneXSMax), Device.simulator(Device.iPhone11), Device.simulator(Device.iPhone11Pro), Device.simulator(Device.iPhone11ProMax), Device.simulator(Device.iPhone12), Device.simulator(Device.iPhone12Pro), Device.simulator(Device.iPhone12Mini), Device.simulator(Device.iPhone12ProMax), Device.simulator(Device.iPhone13), Device.simulator(Device.iPhone13Pro), Device.simulator(Device.iPhone13Mini), Device.simulator(Device.iPhone13ProMax)]) {
            m_lock = "preview_lock7_ixp"
        } else if device.isOneOf([Device.iPhone4]) || device.isOneOf([Device.simulator(Device.iPhone4)]) {
            m_lock = "preview_lock7_i4"
        } else if device.isOneOf([Device.iPhone5, Device.iPhone5s,Device.iPhoneSE, Device.iPhoneSE2]) || device.isOneOf([Device.simulator(Device.iPhone5), Device.simulator(Device.iPhone5s), Device.simulator(Device.iPhoneSE), Device.simulator(Device.iPhoneSE2)]) {
            m_lock = "preview_lock7_i5"
        } else if device.isOneOf([Device.iPhone6, Device.iPhone6s, Device.iPhone7, Device.iPhone8]) || device.isOneOf([Device.simulator(Device.iPhone6), Device.simulator(Device.iPhone6s), Device.simulator(Device.iPhone7), Device.simulator(Device.iPhone8)]) {
            m_lock = "preview_lock7_i6"
        } else if device.isOneOf([Device.iPhone6Plus, Device.iPhone6sPlus, Device.iPhone7Plus, Device.iPhone8Plus]) || device.isOneOf([Device.simulator(Device.iPhone6Plus), Device.simulator(Device.iPhone6sPlus), Device.simulator(Device.iPhone7Plus), Device.simulator(Device.iPhone8Plus)]) {
            m_lock = "preview_lock7_i6p"
        }
        return m_lock
    }
    
    /// get home image
    func getHomeImage() -> String {
        var m_home: String = ""
        let device: Device = Device.current
        if device.isOneOf([Device.iPhoneX, Device.iPhoneXR, Device.iPhoneXS, Device.iPhoneXSMax, Device.iPhone11, Device.iPhone11Pro, Device.iPhone11ProMax, Device.iPhone12, Device.iPhone12Pro, Device.iPhone12Mini, Device.iPhone12ProMax, Device.iPhone13, Device.iPhone13Pro, Device.iPhone13Mini, Device.iPhone13ProMax]) || device.isOneOf([Device.simulator(Device.iPhoneX), Device.simulator(Device.iPhoneXR), Device.simulator(Device.iPhoneXR), Device.simulator(Device.iPhoneXSMax), Device.simulator(Device.iPhone11), Device.simulator(Device.iPhone11Pro), Device.simulator(Device.iPhone11ProMax), Device.simulator(Device.iPhone12), Device.simulator(Device.iPhone12Pro), Device.simulator(Device.iPhone12Mini), Device.simulator(Device.iPhone12ProMax), Device.simulator(Device.iPhone13), Device.simulator(Device.iPhone13Pro), Device.simulator(Device.iPhone13Mini), Device.simulator(Device.iPhone13ProMax)]) {
            m_home = "preview_home7_ixp"
        } else if device.isOneOf([Device.iPhone4]) || device.isOneOf([Device.simulator(Device.iPhone4)]) {
            m_home = "preview_home7_i4"
        } else if device.isOneOf([Device.iPhone5, Device.iPhone5s,Device.iPhoneSE, Device.iPhoneSE2]) || device.isOneOf([Device.simulator(Device.iPhone5), Device.simulator(Device.iPhone5s), Device.simulator(Device.iPhoneSE), Device.simulator(Device.iPhoneSE2)]) {
            m_home = "preview_home7_i5"
        } else if device.isOneOf([Device.iPhone6, Device.iPhone6s, Device.iPhone7, Device.iPhone8]) || device.isOneOf([Device.simulator(Device.iPhone6), Device.simulator(Device.iPhone6s), Device.simulator(Device.iPhone7), Device.simulator(Device.iPhone8)]) {
            m_home = "preview_home7_i6"
        } else if device.isOneOf([Device.iPhone6Plus, Device.iPhone6sPlus, Device.iPhone7Plus, Device.iPhone8Plus]) || device.isOneOf([Device.simulator(Device.iPhone6Plus), Device.simulator(Device.iPhone6sPlus), Device.simulator(Device.iPhone7Plus), Device.simulator(Device.iPhone8Plus)]) {
            m_home = "preview_home7_i6p"
        }
        return m_home
    }
}
