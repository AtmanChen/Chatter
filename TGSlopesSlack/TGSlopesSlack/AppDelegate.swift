//
//  AppDelegate.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/20.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa
import TGUIKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    @IBOutlet weak var window: Window!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        UserDefaults.standard.set(true, forKey: "NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints")
        launchInterface()
    }
    
    private func launchInterface() {
        window.maxSize = NSMakeSize(.greatestFiniteMagnitude, .greatestFiniteMagnitude)
        window.minSize = NSMakeSize(800, 500)
        window.setFrame(NSMakeRect(0, 0, 800, 650), display: true)
        window.center()
        
        let rootView = ToolBarView(frame: window.bounds)
        if !window.isKeyWindow {
            window.makeKeyAndOrderFront(self)
        }
        window.contentView?.addSubview(rootView, positioned: .below, relativeTo: window.contentView?.subviews.first)
        window.deminiaturize(self)
        NSApp.activate(ignoringOtherApps: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

