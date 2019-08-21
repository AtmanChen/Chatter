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

final class ToolBarViewController: NSViewController {
    
    private let titleLabel: NSTextField = {
        let tf = NSTextField()
        tf.isEditable = false
        tf.focusRingType = .none
        tf.isBordered = false
        return tf
    }()
    private let profileImage = NSImageView()
    private let containerView = NSView()
    
    private let testLabel = TextViewLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = nightBluePalette.background.cgColor
        
        testLabel.setFrameOrigin(.zero)
        testLabel.setFrameSize(NSSize(width: 200, height: 30))
        testLabel.setNeedsDisplay()
    }
    
    override func loadView() {
        guard let windowRect = NSApplication.shared.mainWindow?.bounds else {
            return
        }
        view = NSView(frame: windowRect)
        view.addSubview(containerView)
        profileImage.image = #imageLiteral(resourceName: "profileDefault")
        titleLabel.stringValue = "Log In"
        titleLabel.font = .normal(13)
        titleLabel.textColor = nightBluePalette.text
        testLabel.attributedString = .initialize(string: "This is a test label", color: nightBluePalette.text, font: .medium(20))
        containerView.addSubview(titleLabel)
        containerView.addSubview(profileImage)
        containerView.addSubview(testLabel)
        
        containerView.snp.makeConstraints {
            $0.top.left.right.equalTo(view)
            $0.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(containerView)
            $0.right.equalTo(containerView).offset(-16)
        }
        
        profileImage.snp.makeConstraints {
            $0.centerY.equalTo(containerView)
            $0.width.height.equalTo(24)
            $0.right.equalTo(titleLabel.snp.left).offset(-8)
        }
//        testLabel.snp.makeConstraints {
//            $0.center.equalTo(containerView)
//        }
//
//        testLabel.setNeedsDisplay()
    }
    
    
}
