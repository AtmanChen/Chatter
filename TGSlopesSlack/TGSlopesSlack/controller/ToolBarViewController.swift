//
//  ToolBarViewController.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/20.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa
import TGUIKit
import SnapKit

final class ToolBarView: View, SplitViewDelegate {
    
    private let topContainerView = View()
    private let splitView: SplitView
    private let leftController = ChannelViewController()
    private let rightController = ChatViewController()
    private let profileImageView = ImageView()
    private let profileTitleButton = TitleButton()
    
     required init(frame frameRect: NSRect) {
        splitView = SplitView(frame: .zero)
        super.init(frame: frameRect)
        
        splitView.setProportion(proportion: SplitProportion(min:380, max:300+350), state: .single);
        splitView.setProportion(proportion: SplitProportion(min:300+350, max:300+350+600), state: .dual)
        
        splitView.delegate = self
        splitView.state = .dual
        splitView.needFullsize()
        
        profileTitleButton.set(text: "Log in", for: .Normal)
        profileTitleButton.style = ControlStyle(font: .medium(13), foregroundColor: .white)
        _ = profileTitleButton.sizeToFit()
        profileTitleButton.set(handler: { [weak self] _ in
            guard let self = self else {
                return
            }
            self.openSignIn()
        }, for: .Click)
        topContainerView.addSubview(profileTitleButton)
        
        profileImageView.image = #imageLiteral(resourceName: "profileDefault").precomposed(.white)
        topContainerView.addSubview(profileImageView)
        topContainerView.backgroundColor = nightBluePalette.background
        addSubview(topContainerView)
        addSubview(splitView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewFrameChanged(_:)), name: NSView.frameDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSView.frameDidChangeNotification, object: nil)
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
    
    override func layout() {
        super.layout()
        self.topContainerView.setFrameOrigin(NSPoint(x: 0, y: 20))
        self.topContainerView.setFrameSize(NSSize(width: self.bounds.width, height: 60))
        self.profileTitleButton.centerY(x: self.bounds.width - 20 - self.profileTitleButton.frame.width)
        self.profileImageView.centerY(x: profileTitleButton.frame.minX - 24 - 2)
        self.profileImageView.setFrameSize(NSSize(width: 24, height: 24))
        splitView.setFrameOrigin(0, self.topContainerView.frame.maxY)
        splitView.setFrameSize(NSSize(width: self.bounds.width, height: self.bounds.height - self.topContainerView.frame.maxY))
    }
    
    @objc
    private func viewFrameChanged(_ notification: Notification) {
        guard let window = NSApplication.shared.keyWindow as? Window else {
            return
        }
        setFrameSize(window.frame.size)
        layout()
    }
    
    @objc
    private func openSignIn() {
        let loginNavi = NavigationViewController(ProfileLoginViewController(), mainWindow)
        loginNavi._frameRect = NSRect(x: 0, y: 0, width: 475, height: 300)
        loginNavi.readyOnce()
        showModal(with: loginNavi, for: mainWindow)
    }
}

