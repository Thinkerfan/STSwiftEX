//
//  PlaceholderTextView.swift
//  QRCode
//
//  Created by cfans on 2018/12/17.
//  Copyright © 2018 cfans. All rights reserved.
//

import UIKit

@IBDesignable public class PlaceholderTextView: UITextView {
    
    /// 内容颜色
    @IBInspectable public var contentColor:UIColor = .black
    
    /// 提示占位符颜色
    @IBInspectable public var placeHolderColor:UIColor = .placeholderGray
    
    /// 提示占位符内容
    @IBInspectable public var placeHolderStr:String = ""{
        didSet{
            text = placeHolderStr
            textColor = placeHolderColor
        }
    }

    /// 文本内容
    public override var text: String!{
        didSet{
            textColor = contentColor
        }
    }
    
    /// 边框宽度
    public var bolderWidth: CGFloat!{
        didSet{
            layer.borderWidth = bolderWidth
        }
    }

    /// 内容
    public var content:String?{
        get{
            return (text==placeHolderStr||text.count==0) ? nil : text
        }
    }

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupViews()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews(){
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.placeholderGray.cgColor
        layer.cornerRadius = 5.0
        NotificationCenter.default.addObserver(self, selector: #selector(textDidBeginEditing), name: UITextView.textDidBeginEditingNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing), name: UITextView.textDidEndEditingNotification, object: nil);
    }

    @objc func textDidBeginEditing(){
        if self.text == placeHolderStr{
            self.text = "";
            self.textColor = contentColor
        }
    }

    @objc func textDidEndEditing(){
        if self.text.count == 0 {
            self.text = placeHolderStr
            self.textColor = placeHolderColor
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}
