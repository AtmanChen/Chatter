//
//  ProfileLoginView.swift
//  TGSlopesSlack
//
//  Created by Buck on 2019/8/21.
//  Copyright © 2019 Buck. All rights reserved.
//

import TGUIKit
import SnapKit


final class ProfileLoginView: View {
    
    private let title = TextView()
    private let profileImage = ImageView()
    private let containerView = View()
    
    required init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        containerView.setFrameSize(frameRect.size)
        
        let image = #imageLiteral(resourceName: "profileDefault").precomposed()
        profileImage.image = image
        profileImage.sizeToFit()
        
        let titleLayout = TextViewLayout(.initialize(string: "Log In", color: .white, font: .normal(13)))
        titleLayout.measure()
        title.set(layout: titleLayout)
        
        containerView.addSubview(title)
        containerView.addSubview(profileImage)
        addSubview(containerView)
        
        
        containerView.snp.makeConstraints {
            $0.top.left.right.bottom.equalTo(self)
        }
        
        title.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.right.equalTo(self).offset(-16)
        }
        
        profileImage.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.width.height.equalTo(24)
            $0.right.equalTo(title.snp.left).offset(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layout() {
        super.layout()
        
        
    }
}
