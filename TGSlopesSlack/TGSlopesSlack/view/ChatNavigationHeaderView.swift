//
//  ChatNavigationHeaderView.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/20.
//  Copyright © 2019 Buck. All rights reserved.
//

import TGUIKit
import SlackCore

final class ChatNavigationHeaderView: NavigationHeaderView {
    
    private let profileButton = TitleButton()
    
    override init(_ header: NavigationHeader) {
        super.init(header)
        background = nightBluePalette.background
        addSubview(profileButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame frameRect: NSRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    func updateProfile(_ account: Account?) {
        if let _ = account {
            profileButton.set(image: #imageLiteral(resourceName: "profileDefault").precomposed(), for: .Normal)
            profileButton.set(text: "梵尘", for: .Normal)
        } else {
            profileButton.set(image: #imageLiteral(resourceName: "profileDefault").precomposed(), for: .Normal)
            profileButton.set(text: "Login", for: .Normal)
        }
        profileButton.backgroundColor = nightBluePalette.background
        profileButton.style = ControlStyle(font: .normal(14.0), foregroundColor: nightBluePalette.text)
        _ = profileButton.sizeToFit()
        needsLayout = true
    }
    
    override func layout() {
        super.layout()
        profileButton.centerY(x: frame.width - profileButton.frame.width - 20)
    }
    
    override func updateLocalizationAndTheme() {
        super.updateLocalizationAndTheme()
        
    }
}
