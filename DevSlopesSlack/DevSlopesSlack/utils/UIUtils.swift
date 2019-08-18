//
//  UIUtils.swift
//  TGUIKit
//
//  Created by keepcoder on 15/10/2016.
//  Copyright © 2016 Telegram. All rights reserved.
//

import Cocoa

public struct System {
    
//    public static var scaleFactor: Atomic<CGFloat> = Atomic(value: 2.0)
    
    public static var scaleFactor: CGFloat = 2.0
    
    public static var isRetina:Bool {
        get {
            return scaleFactor == 2.0
        }
    }
    
    public static var backingScale:CGFloat {
        return scaleFactor
    }
    
    public static var drawAsync:Bool {
        return false
    }
    
    public static var isScrollInverted: Bool {
        if UserDefaults.standard.value(forKey: "com.apple.swipescrolldirection") != nil {
            return UserDefaults.standard.bool(forKey: "com.apple.swipescrolldirection")
        } else {
            return true
        }
    }
    
}


public func floorToScreenPixels(scaleFactor: CGFloat, _ value: CGFloat) -> CGFloat {
    let scale = scaleFactor//NSScreen.main?.backingScaleFactor ?? 1.0
    return floor(value * scale) / scale
}

public func assertNotOnMainThread(_ file: String = #file, line: Int = #line) {
    assert(!Thread.isMainThread, "\(file):\(line) running on main thread")
}


public func assertOnMainThread(_ file: String = #file, line: Int = #line) {
    assert(Thread.isMainThread, "\(file):\(line) running on main thread")
}
