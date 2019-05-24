//
//  GradientView.swift
//  渐变view
//
//  Created by cfans on 2019/5/24.
//  Copyright © 2019 cfans. All rights reserved.
//

import UIKit

open class GradientView:UIView{
    
    /// 渐变颜色数集
    public var gradientColors:[UIColor]?
    
    /// 渐变起始位置
    public var start:CGPoint =  CGPoint(x: 0, y: 0)//渐变起点
    
    /// 渐变终止位置
    public var end:CGPoint = CGPoint(x: 1, y: 1) //渐变终点
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        if let gradient = gradientColors{
            addGradientLayer(start: start, end: end, frame: self.bounds, colors: gradient)
        }
    }
    
}
