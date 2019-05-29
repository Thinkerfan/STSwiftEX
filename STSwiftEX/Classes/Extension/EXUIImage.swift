//
//  EXUIImage.swift
//  UIImage 扩展类
//
//  Created by cfans on 2018/11/21.
//  Copyright © 2018 cfans. All rights reserved.
//

import UIKit
extension UIImage{
    
    /// 根据颜色值来调整UIImage的颜色
    public func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 生成正方形的UIImage
    public func square() -> UIImage {
        let imageWidth = self.size.width
        let imageHeight = self.size.height
        if  imageWidth != imageHeight{
            let minSize = min(imageWidth, imageHeight)
            let newRect: CGRect = CGRect(x: (imageWidth-minSize)/2, y: (imageHeight-minSize)/2, width: minSize, height: minSize)
            let imageRef = self.cgImage!.cropping(to: newRect)
            let newImage = UIImage(cgImage: imageRef!)
            return newImage
        }else{
            return self
        }
    }

    /// 根据行数和列数来切分UIImage
    public func slice(column:Int,row:Int) -> [UIImage]{
        var imageArray = [UIImage]()
        
        let imageWidth = self.size.width
        let imageHeight = self.size.width
        let cellWidth = imageWidth/CGFloat(column)
        let cellHeight = imageHeight/CGFloat(row)
        
        for i in 0..<row {
            for j in 0..<column {
                let newImageRect = CGRect(x: CGFloat(j) * cellWidth, y:CGFloat(i) * cellHeight, width: cellWidth, height: cellHeight)
                let imageRef = self.cgImage!.cropping(to: newImageRect)
                let newImage = UIImage(cgImage: imageRef!)
                imageArray.append(newImage)
            }
        }
        return imageArray
    }

    /// 拷贝UIImage
    public func imageCopy()->UIImage{
        return UIImage(cgImage: self.cgImage!)
    }
    
}

// Image 缩放旋转处理
extension UIImage{
    
    // 缩放旋转处理
    public func rotatedImageWithTransform(_ rotation: CGAffineTransform, croppedToRect rect: CGRect) -> UIImage {
        let rotatedImage = rotatedImageWithTransform(rotation)
        
        let scale = rotatedImage.scale
        let cropRect = rect.applying(CGAffineTransform(scaleX: scale, y: scale))
        
        let croppedImage = rotatedImage.cgImage?.cropping(to: cropRect)
        let image = UIImage(cgImage: croppedImage!, scale: self.scale, orientation: rotatedImage.imageOrientation)
        return image
    }
    
    fileprivate func rotatedImageWithTransform(_ transform: CGAffineTransform) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: size.width / 2.0, y: size.height / 2.0)
        context?.concatenate(transform)
        context?.translateBy(x: size.width / -2.0, y: size.height / -2.0)
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rotatedImage!
    }
}

// Image 叠加
extension UIImage{
    
    /// 修复图片旋转
    public func fixOrientation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            break
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break
            
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        default:
            break
        }
        
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
            break
            
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
            break
        }
        
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        
        return img
    }
}

// 按照贝塞尔曲线来切图
extension UIImage {

    /// 按照贝塞尔曲线来切图
    public func imageByApplyingClippingBezierPath(_ path: UIBezierPath) -> UIImage {
        // Mask image using path
        let maskedImage = imageByApplyingMaskingBezierPath(path)
        // Crop image to frame of path
        let croppedImage = UIImage(cgImage: maskedImage.cgImage!.cropping(to: path.bounds)!)
        return croppedImage
    }

    /// 按照贝塞尔曲线来切图
    func imageByApplyingMaskingBezierPath(_ path: UIBezierPath) -> UIImage {
        // Define graphic context (canvas) to paint on
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()

        // Set the clipping mask
        path.addClip()
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!

        // Restore previous drawing context
        context.restoreGState()
        UIGraphicsEndImageContext()

        return maskedImage
    }

    /// 按照Rect来切图
    public func crop(toRect rect: CGRect) -> UIImage? {
        if let cgImage = cgImage, let croppedImage = cgImage.cropping(to: rect) {
            return UIImage(cgImage: croppedImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }

    /// 按照贝塞尔曲线来切图
    public func clip(path: UIBezierPath) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let cgImage = cgImage, let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }

        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -size.height)
        path.addClip()
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let clippedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return clippedImage
    }

    public func applyInnerShadow(forPath path: UIBezierPath, shadowColor: UIColor, shadowOffset: CGSize, shadowBlurRadius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        guard let cgImage = cgImage, let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }

        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -size.height)

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        UIColor(red: 0, green: 0, blue: 0, alpha: 0).setFill()
        path.fill()

        context.saveGState()
        context.clip(to: path.bounds)
        context.setShadow(offset: .zero, blur: 0)
        context.setAlpha(shadowColor.cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let ovalOpaqueShadow = shadowColor.withAlphaComponent(1)
        context.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color: ovalOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)

        ovalOpaqueShadow.setFill()
        path.fill()

        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()

        let clippedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return clippedImage
    }

}

extension UIImage{
    /// 图片旋转
    public func rotate(_ radians: CGFloat) -> UIImage {
        let cgImage = self.cgImage!
        let LARGEST_SIZE = CGFloat(max(self.size.width, self.size.height))
        let context = CGContext.init(data: nil, width:Int(LARGEST_SIZE), height:Int(LARGEST_SIZE), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue)!
        
        var drawRect = CGRect.zero
        drawRect.size = self.size
        let drawOrigin = CGPoint(x: (LARGEST_SIZE - self.size.width) * 0.5,y: (LARGEST_SIZE - self.size.height) * 0.5)
        drawRect.origin = drawOrigin
        var tf = CGAffineTransform.identity
        tf = tf.translatedBy(x: LARGEST_SIZE * 0.5, y: LARGEST_SIZE * 0.5)
        tf = tf.rotated(by: CGFloat(radians))
        tf = tf.translatedBy(x: LARGEST_SIZE * -0.5, y: LARGEST_SIZE * -0.5)
        context.concatenate(tf)
        context.draw(cgImage, in: drawRect)
        var rotatedImage = context.makeImage()!
        
        drawRect = drawRect.applying(tf)
        
        rotatedImage = rotatedImage.cropping(to: drawRect)!
        let resultImage = UIImage(cgImage: rotatedImage)
        return resultImage
    }
    
    public func alpha(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

