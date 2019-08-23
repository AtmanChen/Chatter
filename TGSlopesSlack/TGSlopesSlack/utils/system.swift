//
//  system.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/22.
//  Copyright © 2019 Buck. All rights reserved.
//

import TGUIKit

public weak var mw:Window?

var mainWindow: Window {
    if let window = NSApp.keyWindow as? Window {
        return window
    } else if let window = NSApp.mainWindow as? Window {
        return window
    } else if let mw = mw {
        return mw
    }
    fatalError("window not found")
}
