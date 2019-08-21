//
//  MainWindowController.swift
//  DevSlopesSlack
//
//  Created by Buck on 2019/8/15.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.setFrame(NSMakeRect(0, 0, 800, 650), display: true)
        window?.center()
    }

}
