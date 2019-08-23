//
//  SignInViewController.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/23.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa
import TGUIKit

final class SignInView: View {
    
    private let titleView = TextView()
    private let nameTF = NSTextField()
    private let emailTF = NSTextField()
    private let passwordTF = NSSecureTextField()
    private let leftContainerView = View()
    private let avatarImageView = ImageView()
    private let createAccountButton = TitleButton()
    private let chooseAvatarButton = TitleButton()
    
    required init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        let titleLayout = TextViewLayout(.initialize(string: "Sign In", color: nightBluePalette.text, font: .bold(.huge)))
        titleLayout.measure(width: .greatestFiniteMagnitude)
        titleView.update(titleLayout)
        
        nameTF.font = .normal(.title)
        nameTF.isBordered = false
        nameTF.focusRingType = .none
        nameTF.isBezeled = false
//        nameTF.delegate = self
        nameTF.nextKeyView = emailTF
        nameTF.nextResponder = emailTF
        nameTF.drawsBackground = false
        nameTF.textColor = nightBluePalette.text
        nameTF.placeholderAttributedString = .initialize(string: "Name", color: nightBluePalette.grayText, font: .normal(.title))
        
        emailTF.font = .normal(.title)
        emailTF.isBordered = false
        emailTF.focusRingType = .none
        emailTF.isBezeled = false
//        emailTF.delegate = self
        emailTF.nextKeyView = passwordTF
        emailTF.nextResponder = passwordTF
        emailTF.drawsBackground = false
        emailTF.textColor = nightBluePalette.text
        emailTF.placeholderAttributedString = .initialize(string: "Email", color: nightBluePalette.grayText, font: .normal(.title))
        
        passwordTF.isBordered = false
        passwordTF.focusRingType = .none
        passwordTF.isBezeled = false
        passwordTF.font = .normal(.title)
//        passwordTF.delegate = self
        passwordTF.nextResponder = nameTF
        passwordTF.nextKeyView = nameTF
        passwordTF.drawsBackground = false
        passwordTF.textColor = nightBluePalette.text
        passwordTF.placeholderAttributedString = .initialize(string: "Password", color: nightBluePalette.grayText, font: .normal(.title))
        
        createAccountButton.autohighlight = true
        createAccountButton.style = ControlStyle(font: .normal(.title), foregroundColor: .white, backgroundColor: nightBluePalette.blueUI, highlightColor: .white)
        createAccountButton.set(text: "Create Account", for: .Normal)
        _ = createAccountButton.sizeToFit()
        createAccountButton.setFrameSize(NSSize(width: 76, height: 36))
        createAccountButton.layer?.cornerRadius = 18
        createAccountButton.set(handler: { _ in
            print("Log In Clicked")
        }, for: .Click)
        
        leftContainerView.addSubview(nameTF)
        leftContainerView.addSubview(emailTF)
        leftContainerView.addSubview(passwordTF)
        leftContainerView.addSubview(createAccountButton)
    
        addSubview(leftContainerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        super.layout()
        nameTF.sizeToFit()
        emailTF.sizeToFit()
        passwordTF.sizeToFit()
    }
    
}

final class SignInViewController: GenericViewController<SignInView> {
    
    override init() {
        super.init()
        readyOnce()
        bar = .init(height: 44)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerBarView.text = .initialize(string: "Sign In", color: nightBluePalette.text, font: .medium(.huge))
        genericView.backgroundColor = nightBluePalette.background
    }
    
    override func backSettings() -> (String, CGImage?) {
        let d = super.backSettings()
        return ("Back", d.1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override var enableBack: Bool {
        return true
    }
    
    override var defaultBarTitle: String {
        return "Sign In"
    }
}


