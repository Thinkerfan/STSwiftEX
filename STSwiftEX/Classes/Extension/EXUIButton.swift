//
//  EXUIButton.swift
//  Module
//
//  Created by cfans on 2018/9/29.
//  Copyright © 2018年 cfans. All rights reserved.
//
import UIKit
extension UIButton{
    
    /// set UIButton image top and label bottom
    public func setVerticalImgText(image:String,title:String,spacing:CGFloat = 10){
        setTitle(title, for: .normal)
        setImage(UIImage(named: image), for: .normal)
        
        let imageHeight = self.imageView!.height
        let imageWidth = self.imageView!.width;
        let labelWidth = self.titleLabel!.width
        let labelHeight = self.titleLabel!.height
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth/2, bottom: 0, right: -labelWidth/2)
        self.titleEdgeInsets = UIEdgeInsets(top: imageHeight+labelHeight+spacing, left: -imageWidth, bottom: 0, right: 0)
    }
    
    /// Verification code countdown
    /// - Parameter seconds: the coutdown second
    /// - Parameter endText: the text to show when time out
    public func timeCount(seconds:Int,endText:String){
        self.isEnabled = false
        var count = seconds
        let codeTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        codeTimer.setEventHandler {
            count = count - 1
            if count < 0 {
                codeTimer.cancel()
                DispatchQueue.main.async {
                    self.isEnabled = true
                    self.setTitle(endText, for: .normal)
                }
            }else{
                DispatchQueue.main.async {
                    self.setTitle("\(count) s", for: .normal)
                }
            }
        }
        codeTimer.activate()
    }
}

extension UIButton{
    /// Return UIButton with title
    public static func cfBtn(title:String) ->UIButton{
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        return btn
    }
    
    /// Return UIButton with image
    public static func cfBtn(img:String) ->UIButton{
        let btn = UIButton()
        btn.setImage(UIImage(named: img), for: .normal)
        return btn
    }
}
