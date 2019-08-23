//
//  ModalCreateAccount.swift
//  DevSlopesSlack
//
//  Created by Buck on 2019/8/21.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa
import TGUIKit

class ModalCreateAccount: NSView {
    
    @IBOutlet weak var stackView: NSStackView!
    @IBOutlet var view: NSView!
    @IBOutlet weak var nameTF: NSTextField!
    @IBOutlet weak var emailTF: NSTextField!
    @IBOutlet weak var passwordTF: NSSecureTextField!
    @IBOutlet weak var createAccountButton: NSButton!
    @IBOutlet weak var avatarImageView: NSImageView!
    @IBOutlet weak var chooseAvatarButton: NSButton!
    
    weak var delegate: ModalViewDelegate?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed("ModalCreateAccount", owner: self, topLevelObjects: nil)
        addSubview(view)
       
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
        view.layer?.cornerRadius = 7
        
        nameTF.focusRingType = .none
        emailTF.focusRingType = .none
        passwordTF.focusRingType = .none
        
        createAccountButton.styleButton(name: "Create Account", fontColor: nightBluePalette.text, alignment: .center, fontName: FONT.AVENIR_REGULAR.rawValue, size: 13)
        createAccountButton.wantsLayer = true
        createAccountButton.layer?.cornerRadius = 7
        createAccountButton.layer?.backgroundColor = GeneralColor.green.cgColor
        
        chooseAvatarButton.styleButton(name: "Choose Avatar", fontColor: nightBluePalette.text, alignment: .center, fontName: FONT.AVENIR_REGULAR.rawValue, size: 13)
        chooseAvatarButton.wantsLayer = true
        chooseAvatarButton.layer?.cornerRadius = 7
        chooseAvatarButton.layer?.backgroundColor = GeneralColor.green.cgColor
        
        avatarImageView.layer?.cornerRadius = 10
        avatarImageView.layer?.borderColor = NSColor.gray.cgColor
        avatarImageView.layer?.borderWidth = 3
        
    }
    
    @IBAction func actionCloseCreateAccountModal(_ sender: Any) {
        guard let delegate = delegate else {
            return
        }
        delegate.dismissModal()
    }
    
    
    @IBAction func actionCreateAccount(_ sender: Any) {
        guard let delegate = delegate else {
            return
        }
        delegate.actionCreateAccount()
    }
    
}
