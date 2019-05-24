//
//  DesignableUITextField.swift
//
//  Created by cfans on 2018/9/29.
//  Copyright © 2018年 cfans. All rights reserved.
//

import UIKit

extension UITextField{
    
    /// 设置提示占位符字体颜色
    public func setPlaceholderColor(color:UIColor){
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder!,attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
