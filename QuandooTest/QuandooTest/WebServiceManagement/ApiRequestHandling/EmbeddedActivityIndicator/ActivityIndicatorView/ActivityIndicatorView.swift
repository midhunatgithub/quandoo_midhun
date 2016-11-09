//
//  ActivityIndicatorView.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/6/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class ActivityIndicatorView: UIView {
    let defaultTitleFont = UIFont(name: "HelveticaNeue-bold", size: 18.0)!
    private var activityIndicatorView:NVActivityIndicatorView!
    private lazy var titleLabel = UILabel()
    
    public class var sharedInstance: ActivityIndicatorView {
        struct Singleton {
            static let instance = ActivityIndicatorView(frame: CGRect.zero)
        }
        return Singleton.instance
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let actualSize =  CGSize(width: 80, height: 80)
        // NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE
        activityIndicatorView = NVActivityIndicatorView(
            frame: CGRect(x:0, y:0, width:actualSize.width, height:actualSize.height),
            type:  NVActivityIndicatorType(rawValue: 13)!,
            color: UIColor.white,
            padding: 0)
        addSubview(activityIndicatorView)
        
        let width = frame.size.width / 3
        titleLabel.frame = CGRect(x:0, y:0,width: width,height: 30)
        titleLabel.font = defaultTitleFont
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.adjustsFontSizeToFitWidth = true
        addSubview(titleLabel)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func start(){
        let indicator = ActivityIndicatorView.sharedInstance.activityIndicatorView
        indicator?.startAnimating()
    }
    private func stop(){
        let indicator = ActivityIndicatorView.sharedInstance.activityIndicatorView
        indicator?.stopAnimating()
    }
    
    public class func showFoodieActivity(title: String)  {
        
        let indicator = ActivityIndicatorView.sharedInstance
        indicator.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        
        indicator.updateFrame()
        
        if indicator.superview == nil {
            //show the spinner
            indicator.alpha = 0.0
            
            guard let containerView = defaultActivityContainer() else {
                fatalError("\n`UIApplication.keyWindow` is `nil`. If you're trying to show a spinner from your view controller's `viewDidLoad` method, do that from `viewWillAppear` instead. Alternatively use `useContainerView` to set a view where the spinner should show")
            }
            containerView.addSubview(indicator)
            UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseOut, animations: {
                indicator.alpha = 1.0
                }, completion: nil)
            
            #if os(iOS)
                // Orientation change observer
                NotificationCenter.default.addObserver(
                    indicator,
                    selector: #selector(ActivityIndicatorView.updateFrame),
                    name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation,
                    object: nil)
            #endif
        }
        
        indicator.title = title
        indicator.start()
        
    }
    public class func hideFoodieActivity(completion: (() -> Void)? = nil) {
        
        let indicator = ActivityIndicatorView.sharedInstance
        NotificationCenter.default.removeObserver(indicator)
        dispatchOnMainQueue {
            indicator.stop()
            if indicator.superview == nil {
                return
            }
            UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseOut, animations: {
                indicator.alpha = 0.0
                }, completion: {_ in
                    indicator.alpha = 1.0
                    indicator.removeFromSuperview()
                    
                    
                    completion?()
            })
        }
        
    }
    
    //
    // Custom superview for the spinner
    //
    private static weak var customActivityContainer: UIView? = nil
    
    private static func defaultActivityContainer() -> UIView? {
        return customActivityContainer ?? UIApplication.shared.keyWindow
    }
    public class func addActivityOnView(activityContainer: UIView?) {
        customActivityContainer = activityContainer
    }
    
    public func updateFrame() {
        if let containerView = ActivityIndicatorView.defaultActivityContainer() {
            ActivityIndicatorView.sharedInstance.frame = containerView.bounds
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    public override var frame: CGRect {
        didSet {
            if frame == CGRect.zero {
                return
            }
            
            guard let indicator = activityIndicatorView else{
                return
            }
            
            indicator.center = center
            let width = frame.size.width / 3
            let height = activityIndicatorView?.frame.size.height
            titleLabel.frame = CGRect(x:0, y:0,width: width,height: 30)
            titleLabel.center =  CGPoint(x:
                indicator.center.x,y:
                indicator.center.y + height!)
            
            
            
        }
    }
    public var title: String = "" {
        didSet(newTitle) {
            // Do not show spring animation if title hasn't changed.
            if newTitle != title {
                let indicator = ActivityIndicatorView.sharedInstance
                
                UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseOut, animations: {
                    indicator.titleLabel.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                    indicator.titleLabel.alpha = 0.2
                    }, completion: {_ in
                        indicator.titleLabel.text = self.title
                        UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: [], animations: {
                            indicator.titleLabel.transform = CGAffineTransform.identity
                            indicator.titleLabel.alpha = 1.0
                            }, completion: nil)
                })
            }
        }
    }
}
