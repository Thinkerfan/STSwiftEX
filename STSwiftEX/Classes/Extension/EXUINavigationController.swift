//
//  EXUINavigationBart.swift
//  AliSC
//
//  Created by cfans on 2018/9/14.
//  Copyright © 2018年 cfans. All rights reserved.
//
import UIKit

extension UINavigationController {

    /// 隐藏navigationBar底部一条黑线
    public func hideBottomLine(){
        self.navigationBar.shadowImage = UIImage()
    }
    
    /// 设置navigationBar透明
    public func setBarTransparent(){
        self.navigationBar.isTranslucent = true
        self.navigationBar.setBackgroundImage(ImageUtil.imageFromColor(color: UIColor.clear), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }

    /// push VC时隐藏导航栏左边返回文字
    public func pushViewControllerWithoutBackButtonTitle(_ viewController: UIViewController, animated: Bool = true) {
        viewControllers.last?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.hidesBottomBarWhenPushed = true
        pushViewController(viewController, animated: animated)
    }

    /// 设置navigationBar渐变背景色
    public func setBarGradientColor(colors:[UIColor],start:CGPoint = CGPoint(x: 1, y: 0),end:CGPoint = CGPoint(x: 1, y: 1) ){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.locations = [0.0 ,1.0]
        gradient.startPoint = start
        gradient.endPoint = end

        var updatedFrame = navigationBar.bounds
        updatedFrame.size.height +=   UIApplication.shared.statusBarFrame.height
        gradient.frame = updatedFrame
        let cgcolors = colors.map { $0.cgColor }
        gradient.colors = cgcolors
        
        navigationBar.setBackgroundImage(ImageUtil.imageFromLayer(fromLayer: gradient), for: .default)
    }

}

