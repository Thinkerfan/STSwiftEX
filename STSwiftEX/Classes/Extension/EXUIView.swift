//
//  EXView.swift
//  AliSC
//
//  Created by cfans on 2018/9/17.
//  Copyright © 2018年 cfans. All rights reserved.
//
import UIKit

extension UIView {
    
    /// the current view‘s  UIViewController
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /// set view background color maked from uimage
    public func setBackgroundImage(image:String){
        UIGraphicsBeginImageContext(self.frame.size);
        UIImage(named: image)?.draw(in: self.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.backgroundColor = UIColor.init(patternImage: image!)
    }
    
    /// add gradient layer
    public func addGradientLayer(
        start: CGPoint = CGPoint(x: 0, y: 0), //渐变起点
        end: CGPoint = CGPoint(x: 1, y: 1), //渐变终点
        frame: CGRect,
        colors: [UIColor]
        ) {
        layoutIfNeeded()
        removeGradientLayer()
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.frame = frame
        var cgColors = [CGColor]()
        for color in colors{
            cgColors.append(color.cgColor)
        }
        gradientLayer.colors = cgColors
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// remove gradient layer
    public func removeGradientLayer() {
        guard let layers = self.layer.sublayers else { return }
        for layer in layers {
            if layer.isKind(of: CAGradientLayer.self) {
                layer.removeFromSuperlayer()
            }
        }
    }
}

extension UIView {
    
    /// create view from nib name
    public static func loadFromNibNamed(nibNamed: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

extension UIView {
    /// 截图
    public func snapShot() -> UIImage?{
        var image:UIImage?
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0);
        if self.drawHierarchy(in: self.bounds, afterScreenUpdates: true){
            image = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext();
        return image;
    }
    
    /// 画网格线
    public func drawGrid(column:Int,row:Int,pathWidth:CGFloat = 5,pathColor:UIColor = .white){
        let path = UIBezierPath()
        
        let width = self.bounds.width
        let height = self.bounds.height
        
        let gridWidth = width/CGFloat(column)
        let gridHeight = height/CGFloat(row)
        
        for i in 1..<column{
            let start = CGPoint(x: CGFloat(i) * gridWidth, y: 0)
            let end = CGPoint(x: CGFloat(i) * gridWidth, y:height)
            path.move(to: start)
            path.addLine(to: end)
        }
        
        for i in 1..<row{
            let start = CGPoint(x: 0, y: CGFloat(i) * gridHeight)
            let end = CGPoint(x:width,y: CGFloat(i) * gridHeight)
            path.move(to: start)
            path.addLine(to: end)
        }
        
        path.close()
        drawBezierPath(path: path, pathWidth: pathWidth, color: pathColor)
    }
    
    /// mark 画Bezier分割线
    func drawBezierPath(path:UIBezierPath,pathWidth:CGFloat = 1,color:UIColor = UIColor.lightGray){
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = pathWidth
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor // draw grid the line code not add
        shapeLayer.path = path.cgPath
        self.layer.addSublayer(shapeLayer)
    }
}

extension UIView {
    /// origin X
    public var x : CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set {
            var frame = self.frame
            frame.origin.x = x
            self.frame = frame
        }
    }
    
    /// origin Y
    public var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set {
            var frame = self.frame
            frame.origin.y = y
            self.frame = frame
        }
    }
    
    /// size width
    public var width : CGFloat {
        get {
            return self.frame.size.width
        }
        
        set {
            var frame = self.frame
            frame.size.width = width
            self.frame = frame
        }
    }
    
    /// size height
    public var height : CGFloat {
        get {
            return self.frame.size.height
        }
        
        set {
            var frame = self.frame
            frame.size.height = height
            self.frame = frame
        }
    }
    
    /// frame origin
    public var origin : CGPoint {
        get {
            return self.frame.origin
        }
        
        set {
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    
    /// frame size
    public var size : CGSize {
        get {
            return self.frame.size
        }
        
        set {
            var frame = self.frame
            frame.size = size
            self.frame = frame
        }
    }
}

