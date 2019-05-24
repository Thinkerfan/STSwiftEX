//
//  EXString.swift
//  AliSC
//
//  Created by cfans on 2018/9/14.
//  Copyright © 2018年 cfans. All rights reserved.
//

import Foundation
extension String {

    public func replace(target: String, withString: String) -> String{
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    public func stringFromHTML() -> String? {
        let data = self.data(using: String.Encoding.unicode)!
        let attrStr = try? NSAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        return attrStr?.string
    }
    
   public  func insertHttpHeader()->String{
        let str = self.lowercased()
        if !str.hasPrefix("http://") && !str.hasPrefix("https://"){
            return "http://\(str)"
        }
        return str
    }

    public static func formatDuration(duration:Int) -> String{
        let minute = duration/60
        let seconds = duration%60
        return String.init(format:"%02zd:%02zd", minute, seconds)
    }

    public static func timeStrWithSecond(time:Int) -> String{
        if (time / 3600 > 0) {
            let hour   = time / 3600;
            let minute = time/60
            let seconds = time%60
            return String.init(format:"%02zd:%02zd:%02zd", hour,minute, seconds)
        }else{
            let minute = time/60
            let seconds = time%60
            return String.init(format:"%02zd:%02zd", minute, seconds)
        }
    }
    public static func timeStrWithTimeInterval(time:TimeInterval,dateFormat:String) ->String{
        let format = DateFormatter()
        format.dateFormat = dateFormat
        return "\(format.string(from: Date(timeIntervalSince1970: time)))"
    }

    public var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}
