//
//  EXUIVIewController.swift
//  TodoList
//
//  Created by cfans on 2018/10/4.
//  Copyright © 2018年 cfans. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

extension UIViewController {
    
    /// show toast
    public func hudTextToast(tip:String,duration:Double=2){
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.label.text = tip
        progressHUD.mode = .text
        progressHUD.hide(animated: true, afterDelay: duration)
    }

    /// show loading
    public func  hudLoading(tip:String=""){
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.label.text = tip
    }

    /// hide loading
    public func hudLoadingEnd(isAnimated:Bool) {
        MBProgressHUD.hide(for: self.view, animated: isAnimated)
    }

    ///  present出来的VC添加类似push出来的右进左出动画效果
    public func addPresentedNaviBackBtn(image:String){
        let btn = UIButton(type: .custom)
        let image = UIImage(named: image)
        if #available(iOS 11, *) {
            btn.setImage(image, for: .normal)
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -image!.size.width, bottom: 0, right: 0)
            btn.addTarget(self, action:  #selector(dismissVC), for: .touchUpInside)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        }else{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissVC))
        }
    }

    /// dismiss VC
    @objc public func dismissVC(){
        self.dismiss(animated: true)
    }
    
    /// add navigation bar gradient background view
    public func addNaviBgView(gradientColor:[UIColor])->GradientView{
        var frame = self.navigationController!.navigationBar.frame
        frame.size.height += frame.origin.y
        frame.origin.y = 0
        
        let bgNav = GradientView(frame: frame)
        bgNav.gradientColors = gradientColor
        self.view.addSubview(bgNav)
        return bgNav
    }
}
