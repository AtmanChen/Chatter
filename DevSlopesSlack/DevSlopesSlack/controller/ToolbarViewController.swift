//
//  ToolbarViewController.swift
//  DevSlopesSlack
//
//  Created by Buck on 2019/8/14.
//  Copyright © 2019 Buck. All rights reserved.
//

import Cocoa

private enum ModalType {
    case logIn
    case createAccount
}

class ToolbarViewController: NSViewController {
    @IBOutlet weak var loginImageView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var loginStackView: NSStackView!
    
    var modalBackgroundView: ModalBackgroundView!
    var modalView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        setupUI()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = GeneralColor.green.cgColor
        
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(didClickLoginStack(_:)))
        
        loginStackView.addGestureRecognizer(clickGesture)
    }
    
    @objc
    private func didClickLoginStack(_ sender: NSClickGestureRecognizer) {
        modal(.logIn)
    }
    
    @objc
    func dismissModal(_ sender: NSClickGestureRecognizer) {
        dismissShadow()
        dismissModalView()
    }
    
    private func dismissShadow() {
        guard modalBackgroundView != nil else {
            return
        }
        modalBackgroundView.layer?.animateAlpha(from: 0.6, to: 0, duration: 0.3) { completed in
            if completed {
                self.modalBackgroundView.removeFromSuperview()
                self.modalBackgroundView = nil
            }
        }
    }
    
    private func dismissModalView() {
        if self.modalView != nil {
            self.modalView.removeFromSuperview()
            self.modalView = nil
        }
    }
    
    private func modal(_ modalType: ModalType) {
        if modalBackgroundView == nil {
            modalBackgroundView = ModalBackgroundView()
            modalBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(modalBackgroundView, positioned: .above, relativeTo: loginStackView)
            modalBackgroundView.wantsLayer = true
            modalBackgroundView.layer?.backgroundColor = .black
            let topConstraint = NSLayoutConstraint(item: modalBackgroundView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
            let leftConstraint = NSLayoutConstraint(item: modalBackgroundView!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
            let rightConstraint = NSLayoutConstraint(item: modalBackgroundView!, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: modalBackgroundView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            view.addConstraints([topConstraint, leftConstraint, rightConstraint, bottomConstraint])
            modalBackgroundView.alphaValue = 0
            let dismissModalClickGesture = NSClickGestureRecognizer(target: self, action: #selector(dismissModal(_:)))
            modalBackgroundView.addGestureRecognizer(dismissModalClickGesture)
            modalBackgroundView.layer?.animateAlpha(from: 0.1, to: 0.6, duration: 0.3)
        }
        
        dismissModalView()
        switch modalType {
        case .logIn:
            modalView = ModalLogin(frame: .zero)
            (modalView as! ModalLogin).delegate = self
        case .createAccount:
            modalView = ModalCreateAccount()
            (modalView as! ModalCreateAccount).delegate = self
        }
        modalView.wantsLayer = true
        modalView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(modalView, positioned: .above, relativeTo: modalBackgroundView)
        let horizonConstraint = modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = modalView.widthAnchor.constraint(equalToConstant: 475)
        let heightConstraint = modalView.heightAnchor.constraint(equalToConstant: 300)
        NSLayoutConstraint.activate([horizonConstraint, verticalConstraint, widthConstraint, heightConstraint])
        modalView.layer?.animateAlpha(from: 0.1, to: 1, duration: 0.3)
    }
    
}

extension ToolbarViewController: ModalViewDelegate {
    
    func dismissModal() {
        dismissShadow()
        dismissModalView()
    }
    
    func actionCreateAccount() {
        print("Create Account Button Pressed")
    }
    
    func actionModalCreateAccount() {
        modal(.createAccount)
    }
    
    
}
