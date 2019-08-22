//
//  ApplicationContext.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/22.
//  Copyright © 2019 Buck. All rights reserved.
//

import Foundation
import Cocoa
import TGUIKit
import SwiftSignalKitMac


final class ApplicationContext: NSObject, SplitViewDelegate {
    
    var rootView: View {
        return containerView
    }
    
    private let window: Window
    private let splitView: SplitView
    private let containerView: View
    private let leftController: ChannelViewController
    private let rightController: ChatViewController
    private let profileImageView = ImageView()
    private let profileTitleLabel = TextView()
    
    init(window: Window) {
        window.maxSize = NSMakeSize(.greatestFiniteMagnitude, .greatestFiniteMagnitude)
        window.minSize = NSMakeSize(380, 500)
        window.setFrame(NSMakeRect(0, 0, 800, 650), display: true)
        window.center()
        self.window = window
        self.containerView = View(frame: window.bounds)
        self.containerView.backgroundColor = nightBluePalette.background
        
        splitView = SplitView(frame: NSRect(x: 0, y: 60, width: window.bounds.width, height: window.bounds.height - 60))
        splitView.setProportion(proportion: SplitProportion(min:380, max:300+350), state: .single);
        splitView.setProportion(proportion: SplitProportion(min:300+350, max:300+350+600), state: .dual)
        
        leftController = ChannelViewController()
        rightController = ChatViewController()
        super.init()
        
        containerView.addSubview(splitView)
        splitView.delegate = self
        splitView.state = .dual
        splitView.needFullsize()
        
        let profileTitleLayout = TextViewLayout(.initialize(string: "Log in", color: .white, font: .medium(13)))
        profileTitleLayout.measure(width: .greatestFiniteMagnitude)
        profileTitleLabel.update(profileTitleLayout)
        self.profileTitleLabel.setFrameOrigin(window.bounds.width - 20 - self.profileTitleLabel.frame.width, 30 - self.profileTitleLabel.frame.height / 2)
        containerView.addSubview(profileTitleLabel)
    }
    
    func splitViewDidNeedSwapToLayout(state: SplitViewState) {
        splitView.removeAllControllers()
        let w: CGFloat = 300
        splitView.mustMinimisize = false
        switch state {
        case .single:
            splitView.addController(controller: rightController, proportion: SplitProportion(min:380, max:CGFloat.greatestFiniteMagnitude))
        case .dual:
            splitView.addController(controller: leftController, proportion: SplitProportion(min:w, max:w))
            splitView.addController(controller: rightController, proportion: SplitProportion(min:380, max:CGFloat.greatestFiniteMagnitude))
        case .minimisize:
            splitView.mustMinimisize = true
            splitView.addController(controller: leftController, proportion: SplitProportion(min:70, max:70))
            splitView.addController(controller: rightController, proportion: SplitProportion(min:380, max:CGFloat.greatestFiniteMagnitude))
        default:
            break
        }
        splitView.layout()
    }
    
    
    
    func splitViewDidNeedMinimisize(controller: ViewController) {
        
    }
    
    func splitViewDidNeedFullsize(controller: ViewController) {
        
    }
    
    func splitViewIsCanMinimisize() -> Bool {
        return false
    }
    
    func splitViewDrawBorder() -> Bool {
        return false
    }
}
