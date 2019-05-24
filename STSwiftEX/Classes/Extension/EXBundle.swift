//
//  EXBundle.swift
//  Bundle 扩展类
//
//  Created by cfans on 2018/10/4.
//  Copyright © 2018年 cfans. All rights reserved.
//

import UIKit
extension Bundle {
    
    /// Returns the app name
    public static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let name : String = dictionary["CFBundleDisplayName"] as? String {
            return name
        } else {
            return ""
        }
    }
    
    /// Returns the app version
    public static func appVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return "V1.0.1"
        }
        if let version : String = dictionary["CFBundleShortVersionString"] as? String {
            return version
        } else {
            return "V1.0.1"
        }
    }
    
    /// Returns the app bundle ID
    public static func appBundleID() -> String {
        return Bundle.main.bundleIdentifier!
    }
}
