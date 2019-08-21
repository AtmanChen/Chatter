//
//  AppDelegate.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/20.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var window: NSWindow = {
        let w = NSWindow(contentRect: NSMakeRect(0, 0, 640, 480),
                         styleMask: [.titled, .resizable, .miniaturizable, .closable, .fullSizeContentView],
                         backing: .buffered,
                         defer: false)
        
        // 设置最小尺寸
        w.minSize = NSMakeSize(320, 240)
        
        // 打开显示在屏幕的中心位置
        w.center()
        
        return w
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        UserDefaults.standard.set(true, forKey: "NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints")
        launchInterface()
    }
    
    private func launchInterface() {
        self.window.makeKeyAndOrderFront(nil)
        self.window.titleVisibility = .hidden
        self.window.titlebarAppearsTransparent = true
        let toolBarController = ToolBarViewController()
        self.window.contentViewController = toolBarController
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

