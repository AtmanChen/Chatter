//
//  ModalCreateAccount.swift
//  DevSlopesSlack
//
//  Created by Buck on 2019/8/21.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa

class ModalCreateAccount: NSView {
    
    @IBOutlet var view: NSView!
    
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
    }
    
}
