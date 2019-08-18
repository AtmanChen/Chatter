//
//  ModalLogin.swift
//  DevSlopesSlack
//
//  Created by 黄永乐 on 2019/8/17.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa

class ModalLogin: NSView {
    
    
    @IBOutlet weak var stackView: NSStackView!
    @IBOutlet weak var emailTF: NSTextField!
    @IBOutlet var view: NSView!
    @IBOutlet weak var passwordTF: NSSecureTextField!
    @IBOutlet weak var loginButton: NSButton!
    @IBOutlet weak var createAccountButton: NSButton!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed("ModalLogin", owner: self, topLevelObjects: nil)
        addSubview(view)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
        view.layer?.cornerRadius = 7
        loginButton.wantsLayer = true
        loginButton.styleButton(name: "Log In", fontColor: .white, alignment: .center, fontName: FONT.AVENIR_REGULAR.rawValue, size: 14)
        loginButton.layer?.backgroundColor = GeneralColor.green.cgColor
        loginButton.layer?.cornerRadius = 7
        createAccountButton.wantsLayer = true
        createAccountButton.styleButton(name: "Create an account", fontColor: GeneralColor.green, alignment: .center, fontName: FONT.AVENIR_REGULAR.rawValue, size: 13)
        emailTF.focusRingType = .none
        passwordTF.focusRingType = .none
        
    }
    
    @IBAction func actionLogin(_ sender: Any) {
    }
    @IBAction func actionCloseLogin(_ sender: Any) {
    }
    @IBAction func actionCreateAccount(_ sender: Any) {
    }
    
}
