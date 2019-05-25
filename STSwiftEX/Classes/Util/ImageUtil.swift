//
//  Img.swift
//  STSwiftEXTest
//
//  Created by cfans on 2019/5/24.
//  Copyright © 2019 cfans. All rights reserved.
//

import UIKit

public struct ImgCombineUnit {
    public var image:UIImage
    public var rect:CGRect
    
    public init(image:UIImage,rect:CGRect){
        self.image = image
        self.rect = rect
    }
}

public class ImageUtil{
    
    /// 图片叠加处理
    public static func combineImages(bgSize:CGSize,unit:[ImgCombineUnit])->UIImage?{
        UIGraphicsBeginImageContext(bgSize)
        for i in unit{
            i.image.draw(in: i.rect)
        }
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    /// 图片叠加处理
    public static func mixImageWithImage(bottom:UIImage,top:UIImage,rect:CGRect)->UIImage?{
        UIGraphicsBeginImageContext(bottom.size)
        //通过两张图片进行位置和大小的绘制，实现两张图片的合并；其实此原理做法也可以用于多张图片的合并
        let width = bottom.size.width
        let height = bottom.size.height
        bottom.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        top.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    /// 图片+文字叠加处理
    public static func mixImageWithString(bottom:UIImage, top:NSString,rect:CGRect, withAttributes attrs: [NSAttributedString.Key : Any]? = nil)->UIImage?{
        UIGraphicsBeginImageContext(bottom.size);
        let width = bottom.size.width
        let height = bottom.size.height
        bottom.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        top.draw(in: rect, withAttributes: attrs)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    /// 图片大小处理
    public static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width:size.width * heightRatio, height:size.height * heightRatio)
        } else {
            newSize = CGSize(width:size.width * widthRatio,  height:size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in:rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    /// 图片大小处理
    public static func scaleImageWithMaxSize(image: UIImage, maxSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = maxSize.width  / size.width
        let heightRatio = maxSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            if widthRatio > 1 {
                newSize = size
            }else{
                newSize = CGSize(width:size.width * heightRatio, height:size.height * heightRatio)
            }
        } else {
            if heightRatio > 1 {
                newSize = size
            }else{
                newSize = CGSize(width:size.width * widthRatio,  height:size.height * widthRatio)
            }
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in:rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }

    /// 获取CALayer内容生产UIImage
    public static func imageFromLayer(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    
    /// 获取渐变颜色的UIIImage
    public static func gradient(size: CGSize, locations:[CGFloat] = [0,1],colors: [UIColor]) -> UIImage? {
        // Turn the colors into CGColors
        let cgcolors = colors.map { $0.cgColor }
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // From now on, the context gets ended if any return happens
        defer { UIGraphicsEndImageContext() }
        // Create the Coregraphics gradient
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: locations) else { return nil }
        // Draw the gradient
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /// 删除图片透明度
    public static func removeAlpha(from inputImage: UIImage) -> UIImage {
        let format = UIGraphicsImageRendererFormat.init()
        format.opaque = true //Removes Alpha Channel
        format.scale = inputImage.scale //Keeps original image scale.
        let size = inputImage.size
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            inputImage.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    /// Convert UIColor to UIImage
    public static func imageFromColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
