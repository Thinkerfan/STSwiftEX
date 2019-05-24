//
//  EXUIFont.swift
//  字体扩展类
//
//  Created by cfans on 2018/12/27.
//  Copyright © 2018 cfans. All rights reserved.
//

import UIKit

extension UIFont{

    /// Returns the PingFans SC font
    public static func pingFangSCFont(ofSize fontSize: CGFloat,style:String="Regular") -> UIFont{
        return UIFont(name: "PingFangSC-\(style)", size: fontSize)!
    }

}
