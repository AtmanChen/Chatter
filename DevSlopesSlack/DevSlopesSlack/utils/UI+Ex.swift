//
//  UI+Ex.swift
//  DevSlopesSlack
//
//  Created by 黄永乐 on 2019/8/17.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa


extension NSButton {
    
    func styleButton(name: String, fontColor: NSColor, alignment: NSTextAlignment, fontName: String, size: CGFloat) {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        self.attributedTitle = NSAttributedString(string: name, attributes: [
            .foregroundColor: fontColor,
            .paragraphStyle: style,
            .font: NSFont(name: fontName, size: size)!
            ])
    }
    
}
