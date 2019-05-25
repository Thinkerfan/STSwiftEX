//
//  SCFile.swift
//  AliSC
//
//  Created by cfans on 2018/9/18.
//  Copyright © 2018年 cfans. All rights reserved.
//

import UIKit

public let kScreenWidth = UIScreen.main.bounds.width
public let kScreenHeight = UIScreen.main.bounds.height
public let kScreenScale = UIScreen.main.scale

public let kIPhoneX: Bool = isIPhoneXType()
public let kStatusBarHeight: CGFloat = kIPhoneX ? 44.0 : 20.0
public let kNaviBarHeight: CGFloat = 44.0
public let kTabbarHeight: CGFloat = kIPhoneX ? (49.0 + 34.0) : 49.0
public let kTabbarSafeBottomMargin: CGFloat = kIPhoneX ? 34.0 : 0.0
public let kStatusSafeMargin: CGFloat = kIPhoneX ? 24.0 : 0.0
public let kStatusBarAndNavigationBarHeight: CGFloat = kIPhoneX ? 88.0 : 64.0

// iPhone X
public func isIPhoneXType() -> Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    return UIApplication.shared.windows.first?.safeAreaInsets.bottom != 0
}

public class VCUtil{
    
    ///   分享
    public static func share(appid:String? = nil, items: [Any],rootVC:UIViewController,completion: (() -> Void)? = nil){
        var aItems = items
        if let aid = appid{
            let url = URL(string:"itms-apps://itunes.apple.com/app/id\(aid)")
            aItems.append(url!)
        }
        let vc = UIActivityViewController(activityItems: aItems, applicationActivities: nil)
        vc.excludedActivityTypes = [.print,.assignToContact,.saveToCameraRoll];
        rootVC.present(vc, animated: true, completion: completion)
    }
    
    ///  打开Appstore评论页面
    public static func appStoreReview(appid:String){
        let url = "itms-apps://itunes.apple.com/app/id\(appid)?action=write-review"
        UIApplication.shared.open(URL(string: url)!, options:[:])
    }
    
    /// 打开Appstore下载页面
    public static func appStoreShow(appid:String){
        let url = "itms-apps://itunes.apple.com/app/id\(appid)"
        UIApplication.shared.open(URL(string: url)!, options:[:])
    }
    
    /// 获取当前语言
    public static func currentLanguage() -> String {
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        switch String(describing: preferredLang) {
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
            return "zh-CN"
        default:
            return "en"
        }
    }
    
    /// 检验密码是否OK
    public static func checkPassword(password:String,combined:Bool = false) ->Bool {
        let pattern:String
        if (combined){
            pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}"
        }else{
            pattern = "[a-zA-Z0-9]{6,18}"
        }
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: password)
        return isMatch;
    }
}
