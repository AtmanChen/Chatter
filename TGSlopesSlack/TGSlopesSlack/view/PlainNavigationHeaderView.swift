//
//  PlainNavigationHeaderView.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/20.
//  Copyright © 2019 Buck. All rights reserved.
//

import TGUIKit
import SlackCore

final class PlainNavigationHeaderView: NavigationHeaderView {
    
    private let titleLabel = TextView()
    
    override init(_ header: NavigationHeader) {
        super.init(header)
        background = nightBluePalette.background
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame frameRect: NSRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    func updateTitleContent(_ account: Account?) {
        let titleLayout: TextViewLayout
        if let acc = account {
            titleLayout = TextViewLayout(.initialize(string: acc.name, color: nightBluePalette.text, font: .medium(13)))
        } else {
            titleLayout = TextViewLayout(.initialize(string: "Please Log in", color: nightBluePalette.text, font: .medium(13)))
        }
        titleLabel.background = nightBluePalette.background
        titleLabel.update(titleLayout)
        needsLayout = true
    }
    
    override func layout() {
        super.layout()
        titleLabel.center()
    }
    
}
