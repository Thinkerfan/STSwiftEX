//  EXUILable.swift
//  Uncle
//
//  Created by cfans on 2019/3/21.
//  Copyright © 2019 cfans. All rights reserved.
//

import UIKit

extension UILabel{
    
    /// Returns UILabel with PingFang SC font
    public static func pfLable(text:String? = nil,color:UIColor? = nil, align:NSTextAlignment = .left,size:CGFloat = 16)->UILabel{
        let font = UIFont.pingFangSCFont(ofSize: size)
        return cfLable(text: text, color: color, align: align, font: font)
    }
    
    /// Returns UILabel with font
    public static func cfLable(text:String? = nil,color:UIColor? = nil, align:NSTextAlignment = .left,font:UIFont)->UILabel{
        let v = UILabel()
        v.text = text
        if let c = color{
            v.textColor = c
        }
        v.textAlignment = align
        v.font = font
        return v
    }
}
