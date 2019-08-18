//
//  ChatViewController.swift
//  DevSlopesSlack
//
//  Created by Buck on 2019/8/14.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa

class ChatViewController: NSViewController {

    @IBOutlet weak var chatTagLabel: NSTextField!
    @IBOutlet weak var chatDescriptionLabel: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var inputOutlineView: NSView!
    @IBOutlet weak var messageSendButton: NSButton!
    @IBOutlet weak var textField: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        setupUI()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
        
        inputOutlineView.wantsLayer = true
        inputOutlineView.layer?.backgroundColor = .white
        inputOutlineView.layer?.borderColor = NSColor.lightGray.withAlphaComponent(0.3).cgColor
        inputOutlineView.layer?.borderWidth = 2
        inputOutlineView.layer?.cornerRadius = 5
        
        messageSendButton.styleButton(name: "Send", fontColor: .darkGray, alignment: .center, fontName: FONT.AVENIR_REGULAR.rawValue, size: 13)
    }
    
}
