//
//  ChatViewController.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/20.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa
import TGUIKit

class ChatViewController: ViewController {
    
    private let topContainerView = View()
    private let profileButton = TitleButton()
    
    override init() {
        super.init()
        readyOnce()
    }
    
    override func loadView() {
        super.loadView()
        backgroundColor = nightBluePalette.background
    }
    
    
}
