//
//  ProfileLoginView.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/21.
//  Copyright © 2019 Buck. All rights reserved.
//

import TGUIKit
import SnapKit


final class ProfileLoginModalController: ModalController {
    
    public override var modalHeader: (left: ModalHeaderData?, center: ModalHeaderData?, right: ModalHeaderData?)? {
        return (left: nil, center: ModalHeaderData(title: "Log In"), right: nil)
    }
    
}


final class ProfileLoginView: View {
    
    private let title = TextView()
    private let emailTF = NSTextField()
    private let passwordTF = NSSecureTextField()
    private let signInButton = TitleButton()
    fileprivate let createAccountButton = TextView()
    
    deinit {
        var bp:Int = 0
        bp += 1
    }
    
    required init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        let titleLayout = TextViewLayout(.initialize(string: "Log In", color: nightBluePalette.text, font: .bold(.huge)))
        titleLayout.measure(width: .greatestFiniteMagnitude)
        title.update(titleLayout)
        
        emailTF.font = .normal(.title)
        emailTF.isBordered = false
        emailTF.focusRingType = .none
        emailTF.isBezeled = false
        emailTF.delegate = self
        emailTF.nextKeyView = passwordTF
        emailTF.nextResponder = passwordTF
        emailTF.drawsBackground = false
        emailTF.textColor = nightBluePalette.text
        emailTF.placeholderAttributedString = .initialize(string: "Email", color: nightBluePalette.grayText, font: .normal(.title))
        passwordTF.isBordered = false
        passwordTF.focusRingType = .none
        passwordTF.isBezeled = false
        passwordTF.font = .normal(.title)
        passwordTF.delegate = self
        passwordTF.nextResponder = emailTF
        passwordTF.nextKeyView = emailTF
        passwordTF.drawsBackground = false
        passwordTF.textColor = nightBluePalette.text
        passwordTF.placeholderAttributedString = .initialize(string: "Password", color: nightBluePalette.grayText, font: .normal(.title))
        
        signInButton.autohighlight = true
        signInButton.style = ControlStyle(font: .medium(.title), foregroundColor: nightBluePalette.text, backgroundColor: nightBluePalette.blueUI, highlightColor: .white)
        signInButton.set(text: "Log In", for: .Normal)
        _ = signInButton.sizeToFit()
        signInButton.setFrameSize(NSSize(width: 76, height: 36))
        signInButton.layer?.cornerRadius = 18
        signInButton.set(handler: { _ in
            print("Sign In Clicked")
        }, for: .Click)
        
        let createAccountLayout = TextViewLayout(.initialize(string: "Create Account?", color: nightBluePalette.blueUI, font: .normal(.title)))
        createAccountLayout.measure(width: .greatestFiniteMagnitude)
        createAccountButton.update(createAccountLayout)
        
        
//        addSubview(title)
        addSubview(emailTF)
        addSubview(passwordTF)
        addSubview(signInButton)
        addSubview(createAccountButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layout() {
        super.layout()
        emailTF.sizeToFit()
        passwordTF.sizeToFit()
//        title.centerX(y: 20)
        emailTF.setFrameOrigin(NSPoint(x: self.bounds.width / 2 - 100, y: 20))
        emailTF.setFrameSize(200, 22)
        passwordTF.setFrameOrigin(NSPoint(x: self.bounds.width / 2 - 100, y: emailTF.frame.maxY + 16))
        passwordTF.setFrameSize(200, 22)
        signInButton.setFrameOrigin(NSPoint(x: self.bounds.width / 2 - 38, y: passwordTF.frame.maxY + 28))
        createAccountButton.centerX(y: signInButton.frame.maxY + 20)
    }
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        ctx.setFillColor(nightBluePalette.border.cgColor)
        ctx.fill(NSMakeRect(emailTF.frame.minX, emailTF.frame.maxY, 200, .borderSize))
        ctx.fill(NSMakeRect(passwordTF.frame.minX, passwordTF.frame.maxY, 200, .borderSize))
    }
}

extension ProfileLoginView: NSTextFieldDelegate {
    
}


final class ProfileLoginViewController: GenericViewController<ProfileLoginView> {
    
    override init() {
        super.init()
        readyOnce()
        bar = .init(height: 44)
    }
    
    override func returnKeyAction() -> KeyHandlerResult {
        return .invokeNext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genericView.backgroundColor = nightBluePalette.background
        genericView.createAccountButton.set(handler: { _ in
            let signInViewController = SignInViewController()
            self.navigationController?.push(signInViewController, true, style: .push)
        }, for: .Click)
    }
    
    
    
}
