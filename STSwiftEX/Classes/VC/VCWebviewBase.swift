//
//  VCWebviewBase.swift
//  使用Webview来打开网址链接基类
//
//  Created by cfans on 2019/5/6.
//  Copyright © 2019年 cfans. All rights reserved.
//

import WebKit

open class VCWebviewBase: UIViewController {
    
    public class func presentWebviewVC(url:String,rootVC:UIViewController){
        let vc = VCWebRecommend()
        vc.urlStr = url
        rootVC.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    var urlStr:String!
    private var webView:WKWebView!

    override open func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView(){
        self.view.backgroundColor = .white
        if self.navigationController?.viewControllers.count ?? 0 < 2{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(didDone))
        }

        webView = WKWebView(frame: self.view.bounds)
        webView.navigationDelegate = self
        self.view.addSubview(self.webView)

        hudLoading(tip: "")
        webView.load(URLRequest(url: URL(string: urlStr)!))

    }

     @objc func didDone() {
        self.dismiss(animated: true)
    }
}

extension VCWebviewBase:WKNavigationDelegate{
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hudLoadingEnd(isAnimated: true)
        self.title = webView.title
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow);
    }
}

