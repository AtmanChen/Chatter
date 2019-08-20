//
//  ApplicationContext.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/20.
//  Copyright © 2019 Buck. All rights reserved.
//

import Foundation
import TGUIKit
import SwiftSignalKitMac

private final class ApplicationModalController: ModalController {
    override var background: NSColor {
        return .white
    }
    override var dynamicSize: Bool {
        return true
    }
    override var closable: Bool {
        return false
    }
    
    override func measure(size: NSSize) {
        self.modal?.resize(with: NSMakeSize(size.width, size.height), animated: false)
    }
}

final class ApplicationContext: NSObject, SplitViewDelegate {
    
    let window: Window
    private let splitView: SplitView
    private let leftController: NavigationViewController
    private let rightController: NavigationViewController
    
    var rootView: View {
        return splitView
    }
    
    func applyBackground() {
        leftController.backgroundColor = nightBluePalette.background
        rightController.backgroundColor = nightBluePalette.background
        if let rightHeader = rightController.header {
            rightHeader.show(true)
        }
        
        if let leftHeader = leftController.header {
            leftHeader.show(true)
        }
    }
    
    init(window: Window) {
        
        self.window = window
        self.window.maxSize = NSMakeSize(.greatestFiniteMagnitude, .greatestFiniteMagnitude)
        self.window.minSize = NSMakeSize(380, 500)
        self.window.setFrame(NSRect(x: 0, y: 0, width: 800, height: 650), display: true)
        self.window.center()
        
        self.splitView = SplitView(frame: window.contentView!.bounds)
        splitView.setProportion(proportion: SplitProportion(min:380, max:300+350), state: .single);
        splitView.setProportion(proportion: SplitProportion(min:300+350, max:300+350+600), state: .dual)
        
        rightController = NavigationViewController(ChatViewController(), window)
        rightController.set(header: NavigationHeader(44) { (header) -> NavigationHeaderView in
            let view = ChatNavigationHeaderView(header)
            view.updateProfile(nil)
            return view
        })
        
        self.window.rootViewController = rightController
        
        leftController = NavigationViewController(ChannelViewController(), window)
        leftController.set(header: NavigationHeader(44) { (header) -> NavigationHeaderView in
            let view = PlainNavigationHeaderView(header)
            view.updateTitleContent(nil)
            return view
        })
        
        super.init()
        splitView.delegate = self
        splitView.update(false)
    }
    
    func splitViewDidNeedSwapToLayout(state: SplitViewState) {
        let previousState = splitView.state
        splitView.removeAllControllers();
        let w:CGFloat = 300;
        splitView.mustMinimisize = false
        switch state {
        case .single:
            if rightController.stackCount == 1, previousState != .none {
                leftController.viewWillAppear(false)
            }
            splitView.addController(controller: rightController, proportion: SplitProportion(min:380, max:CGFloat.greatestFiniteMagnitude))
            if rightController.stackCount == 1, previousState != .none {
                leftController.viewDidAppear(false)
            }
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
        return true
    }
    
    func splitViewDrawBorder() -> Bool {
        return false
    }
}
