//
//  ChannelViewController.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/20.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa
import TGUIKit

class ChannelViewController: ViewController {
    
    override init() {
        super.init()
        readyOnce()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        backgroundColor = nightBluePalette.background
    }
}
