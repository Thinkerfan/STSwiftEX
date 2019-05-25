//
//  View.swift
//  STSwiftEXTest
//
//  Created by cfans on 2019/5/24.
//  Copyright © 2019 cfans. All rights reserved.
//

import UIKit

@IBDesignable public class CFTextField: UITextField {
    
    // Provides left padding for images
    @IBInspectable public var leftPadding: CGFloat = 0
    @IBInspectable public var textLeftPadding: CGFloat = 18
    @IBInspectable public var borderSize: CGFloat = 1.0
    @IBInspectable public var borderColor: UIColor = UIColor(red: 0xEE/255.0, green: 0xEE/255.0, blue: 0xEE/255.0, alpha: 1)
    
    
    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    public override  func textRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.textRect(forBounds: bounds)
        textRect.origin.x += textLeftPadding
        return textRect
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.editingRect(forBounds: bounds)
        textRect.origin.x += textLeftPadding
        return textRect
    }
    
    
    @IBInspectable public var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
        
        self.useUnderline()
    }
    
    func useUnderline() {
        
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = borderColor.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height-borderWidth, width:self.frame.size.width, height:borderWidth)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
