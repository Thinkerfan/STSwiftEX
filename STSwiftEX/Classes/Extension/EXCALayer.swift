//
//  EXCALayer.swift
//
//
//  Created by cfans on 2019/5/24.
//  Copyright © 2019 cfans. All rights reserved.
//

import UIKit

extension CALayer {
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
