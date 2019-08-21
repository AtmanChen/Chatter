//
//  MainWindowController.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/20.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    private let toolBarController = ToolBarViewController()

    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
    }
    
}
