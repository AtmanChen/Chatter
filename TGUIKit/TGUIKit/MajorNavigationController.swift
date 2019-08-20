//
//  SingleChatNavigationController.swift
//  Telegram-Mac
//
//  Created by keepcoder on 13/10/2016.
//  Copyright © 2016 Telegram. All rights reserved.
//

import Cocoa
import SwiftSignalKitMac



public protocol MajorControllerListener : class {
    func navigationWillShowMajorController(_ controller:ViewController);
}

open class MajorNavigationController: NavigationViewController, SplitViewDelegate {
    
    public var alwaysAnimate: Bool = false
    private var majorClass:AnyClass
    private var defaultEmpty:ViewController
    private var listeners:[WeakReference<ViewController>] = []
    
    private let container:GenericViewController<BackgroundView> = GenericViewController<BackgroundView>()
    
    override var containerView:BackgroundView {
        get {
            return container.genericView
        }
        set {
            super.containerView = newValue
        }
    }
    
    
    
    open override func loadView() {
        super.loadView()
        
        genericView.setProportion(proportion: SplitProportion(min:380, max: .greatestFiniteMagnitude), state: .single)

        controller._frameRect = bounds
        controller.viewWillAppear(false)
        controller.navigationController = self
        
        containerView.addSubview(navigationBar)
        containerView.frame = bounds
        navigationBar.frame = NSMakeRect(0, 0, containerView.frame.width, controller.bar.height)
        controller.view.frame = NSMakeRect(0, controller.bar.height , containerView.frame.width, containerView.frame.height - controller.bar.height)
        
        navigationBar.switchViews(left: controller.leftBarView, center: controller.centerBarView, right: controller.rightBarView, controller: controller, style: .none, animationStyle: controller.animationStyle, liveSwiping: false)
        
        containerView.addSubview(controller.view)
        Queue.mainQueue().justDispatch {
            self.controller.viewDidAppear(false)
        }
        
        
    }
    
    public func closeSidebar() {
        genericView.removeProportion(state: .dual)
        genericView.setProportion(proportion: SplitProportion(min:380, max: .greatestFiniteMagnitude), state: .single)
        genericView.layout()
        
        viewDidChangedNavigationLayout(.single)
    }
    
  
    
    public init(_ majorClass:AnyClass, _ empty:ViewController, _ window: Window) {
        self.majorClass = majorClass
        self.defaultEmpty = empty
        container.bar = .init(height: 0)
        assert(majorClass is ViewController.Type)
        
        super.init(empty, window)
    }
    
    open override func currentControllerDidChange() {
        if let view = view as? DraggingView {
            view.controller = controller
        }
        for listener in listeners {
            listener.value?.navigationWillChangeController()
        }
    }
    
    open override func viewDidLoad() {
        //super.viewDidLoad()
        
        genericView.delegate = self
        genericView.layout()
    }
    
    public func splitViewDidNeedSwapToLayout(state: SplitViewState) {
        genericView.removeAllControllers();
        
        switch state {
        case .dual:
            genericView.addController(controller: container, proportion: SplitProportion(min: 800, max: .greatestFiniteMagnitude))
            if let sidebar = sidebar {
                genericView.addController(controller: sidebar, proportion: SplitProportion(min:350, max: 350))
            }
        case .single:
            genericView.addController(controller: container, proportion: SplitProportion(min: 800, max: .greatestFiniteMagnitude))
        default:
            break
        }
        controller.viewDidChangedNavigationLayout(state)
        viewDidResized(self.frame.size)
    }
    
    public func splitViewDidNeedMinimisize(controller: ViewController) {
        
    }
    
    public func splitViewDidNeedFullsize(controller: ViewController) {
        
    }
    
    public func splitViewIsCanMinimisize() -> Bool {
        return false;
    }
    
    public func splitViewDrawBorder() -> Bool {
        return true
    }
    
    open override func viewClass() ->AnyClass {
        return DraggingView.self
    }
    
    public var genericView:SplitView {
        return view as! SplitView
    }
   
    override open func push(_ controller: ViewController, _ animated: Bool = true, style:ViewControllerStyle? = nil) {
        
        assertOnMainThread()
        
        controller.navigationController = self
        
        
        
        
        if genericView.state == .dual {
            controller.loadViewIfNeeded(NSMakeRect(0, 0, genericView.frame.width - 350, genericView.frame.height))
        } else {
            controller.loadViewIfNeeded(genericView.bounds)
        }
        
        genericView.update()
        

        pushDisposable.set((controller.ready.get() |> deliverOnMainQueue |> take(1)).start(next: {[weak self] _ in
            if let strongSelf = self {
                let isMajorController = controller.className == NSStringFromClass(strongSelf.majorClass)
                let removeAnimateFlag = strongSelf.stackCount == 2 && isMajorController && !strongSelf.alwaysAnimate
                
                if isMajorController {
                    for controller in strongSelf.stack {
                        controller.didRemovedFromStack()
                    }
                    strongSelf.stack.removeAll()
                    
                    strongSelf.stack.append(strongSelf.empty)
                }
                
                if let index = strongSelf.stack.index(of: controller) {
                    strongSelf.stack.remove(at: index)
                }
                
                 strongSelf.stack.append(controller)
                
                let anim = animated && (!isMajorController || strongSelf.controller != strongSelf.defaultEmpty) && !removeAnimateFlag
                
                let newStyle:ViewControllerStyle
                if let style = style {
                    newStyle = style
                } else {
                    newStyle = anim ? .push : .none
                }

                CATransaction.begin()
                strongSelf.show(controller, newStyle)
                CATransaction.commit()
                
                


            }
        }))
    }
    
    
    open override func back(animated:Bool = true, forceAnimated: Bool = false, animationStyle: ViewControllerStyle = .pop) -> Void {
        if  !isLocked, let last = stack.last, last.invokeNavigationBack() {
            if stackCount > 1 {
                let ncontroller = stack[stackCount - 2]
                let removeAnimateFlag = ((ncontroller == defaultEmpty || !animated) && !alwaysAnimate) && !forceAnimated
                last.didRemovedFromStack()
                stack.removeLast()
                
                show(ncontroller, removeAnimateFlag ? .none : animationStyle)
            } else {
                doSomethingOnEmptyBack?()
            }
        }
        
    }
    
    
    
    
    public func removeExceptMajor() {
        let index = stack.index(where: { current in
            return current.className == NSStringFromClass(self.majorClass)
        })
        if let index = index {
            while stack.count > index {
                stack.removeLast()
            }
        } else {
            while stack.count > 1 {
                stack.removeLast()
            }
        }
    }
    
    open override var responderPriority: HandlerPriority {
        return empty.responderPriority
    }
        
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.window?.set(handler: { [weak self] in
            if let strongSelf = self {
                return strongSelf.escapeKeyAction()
            }
            return .rejected
        }, with: self, for: .Escape, priority: self.responderPriority)
        
        self.window?.set(handler: { [weak self] in
            if let strongSelf = self {
                return strongSelf.returnKeyAction()
            }
            return .rejected
        }, with: self, for: .Return, priority: self.responderPriority)
        
        
        self.window?.set(handler: { [weak self] in
            if let strongSelf = self {
                return strongSelf.backKeyAction()
            }
            return .rejected
        }, with: self, for: .LeftArrow, priority: self.responderPriority)
        
        self.window?.set(handler: { [weak self] in
            if let strongSelf = self {
                return strongSelf.nextKeyAction()
            }
            return .rejected
        }, with: self, for: .RightArrow, priority: self.responderPriority)
        
        
        
    }

    
    open override var canSwipeBack: Bool {
        return (self.genericView.state == .single || self.stackCount > 2)
    }
    
    
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.window?.removeAllHandlers(for: self)
        self.window?.removeAllHandlers(for: self.containerView)
    }
    
    open override func backKeyAction() -> KeyHandlerResult {
        let status:KeyHandlerResult = stackCount > 1 ? .invoked : .rejected
        if isLocked {
            return .invoked
        }
        let cInvoke = self.controller.backKeyAction()
        
        if cInvoke == .invokeNext {
            return .invokeNext
        } else if cInvoke == .invoked {
            return .invoked
        }
        self.back()
        return status
    }
    
    open override func nextKeyAction() -> KeyHandlerResult {
        if isLocked {
            return .invoked
        }
        return self.controller.nextKeyAction()
    }
    
    
    open override func escapeKeyAction() -> KeyHandlerResult {
        let status:KeyHandlerResult = stackCount > 1 ? .invoked : .rejected
        if isLocked {
            return .invoked
        }
        let cInvoke = self.controller.escapeKeyAction()
        
        if cInvoke == .invokeNext {
            return .invokeNext
        } else if cInvoke == .invoked {
            return .invoked
        }
        self.back()
        return status
    }
    
    open override func returnKeyAction() -> KeyHandlerResult {
        let status:KeyHandlerResult = .rejected
        
        let cInvoke = self.controller.returnKeyAction()
        
        if cInvoke == .invokeNext {
            return .invokeNext
        } else if cInvoke == .invoked {
            return .invoked
        }
        return status
    }
    
    public func add(listener:WeakReference<ViewController>) -> Void {
        let index = listeners.index(where: { (weakView) -> Bool in
            return listener.value == weakView.value
        })
        if index == nil {
            listeners.append(listener)
        }
    }
    
    public func remove(listener:WeakReference<ViewController>) -> Void {
        
        let index = listeners.index(where: { (weakView) -> Bool in
            return listener.value == weakView.value
        })
        
        if let index = index {
            listeners.remove(at: index)
        }
    }
    
}
