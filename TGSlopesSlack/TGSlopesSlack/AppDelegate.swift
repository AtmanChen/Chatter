//
//  AppDelegate.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/20.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa
import TGUIKit
import SwiftSignalKitMac

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: Window!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        launchInterface()
    }
    
    private func launchInterface() {
        
//        self.context.set(.single(ApplicationContext(window: window)))
//        _ = (self.context.get() |> deliverOnMainQueue).start(next: { context in
//            assert(Queue.mainQueue().isCurrent())
//            self.contextValue = context
//            if let context = self.contextValue {
//                context.applyBackground()
//                self.window.contentView?.addSubview(context.rootView, positioned: .below, relativeTo: self.window.contentView?.subviews.first)
//                if !self.window.isKeyWindow {
//                    self.window.makeKeyAndOrderFront(self)
//                }
//                self.window.deminiaturize(self)
//                NSApp.activate(ignoringOtherApps: true)
//            }
//        })
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

