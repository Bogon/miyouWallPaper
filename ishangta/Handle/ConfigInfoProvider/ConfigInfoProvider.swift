//
//  ConfigInfoProvider.swift
//  ishangta
//
//  Created by Senyas on 2021/3/6.
//

import Foundation

struct ConfigInfoProvider {
    
    /// 单例模式
    internal static var shared = ConfigInfoProvider()
    private init() { }
    
    /// urlPrefix
    private var m_urlPrefix: String = "http://xjosscdn.51jirili.com/"
    
    /// get urlPrefix
    func getUrlPrefix() -> String {
        return m_urlPrefix
    }
    
    /// set urlPrefix
    mutating func setUrlPrefix(urlPrefix value: String) {
        m_urlPrefix = value
    }
    
}
