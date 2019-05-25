//
//  VCDetail.swift
//  KTSZ
//
//  Created by cfans on 2018/10/18.
//  Copyright © 2018年 cfans. All rights reserved.
//

import WebKit
import StoreKit

class VCWebRecommend: VCWebviewBase{

   override func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let strURL = navigationAction.request.url?.absoluteString ?? ""
        if strURL.contains("https://itunes.apple.com/"){
//            UIApplication.shared.open(navigationAction.request.url!, options:[:])
            if var appid = navigationAction.request.url?.lastPathComponent{
                appid = appid.replace(target: "id", withString: "")
                openAppstoreInApp(appid: appid)
            }
        }
        decisionHandler(.allow);
    }
}

extension VCWebRecommend:SKStoreProductViewControllerDelegate{
    
    func openAppstoreInApp(appid:String){
        let productView = SKStoreProductViewController()
        productView.delegate = self
        self.present(productView, animated: true)
        
        productView.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier : appid]) { (result, error) in
            
            if let err = error{
                self.hudTextToast(tip: err.localizedDescription)
            }
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true)
    }
}
