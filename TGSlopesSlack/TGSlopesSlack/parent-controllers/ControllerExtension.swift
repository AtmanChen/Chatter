//
//  ControllerExtension.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/22.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa
import TGUIKit
import SwiftSignalKitMac

class SlackGenericViewController<T>: GenericViewController<T> where T: NSView {
    
    let queue = Queue(name: "Controller Interface Q.", qos: .default)
    
    override init() {
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

class TableViewController: SlackGenericViewController<TableView>, TableViewDelegate {
    
    override func loadView() {
        super.loadView()
        genericView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func selectionDidChange(row:Int, item:TableRowItem, byClick:Bool, isNew:Bool) -> Void {
        
    }
    func selectionWillChange(row:Int, item:TableRowItem, byClick: Bool) -> Bool {
        return false
    }
    func isSelectable(row:Int, item:TableRowItem) -> Bool {
        return false
    }
    func findGroupStableId(for stableId: AnyHashable) -> AnyHashable? {
        return nil
    }
    
    override var enableBack: Bool {
        return true
    }
    
}
