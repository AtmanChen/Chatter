//
//  ChannelViewController.swift
//  DevSlopesSlack
//
//  Created by Buck on 2019/8/14.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa

class ChannelViewController: NSViewController {
    
    @IBOutlet weak var usernameLabel: NSTextField!
    @IBOutlet weak var addChannelButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = GeneralColor.purple.cgColor
        tableView.backgroundColor = GeneralColor.purple
        addChannelButton.styleButton(name: "Add +", fontColor: .controlColor, alignment: .center, fontName: FONT.AVENIR_REGULAR.rawValue, size: 13)
    }
    
}
