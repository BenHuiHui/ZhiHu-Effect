//
//  HUINavigationBar.swift
//  ZhiHu
//
//  Created by Hui Hui on 3/9/15.
//  Copyright (c) 2015 Hui Hui. All rights reserved.
//

import UIKit

class HUINavigationBar: UIView {

    private let StatusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height

    private var statusBgView: UIView!
    private var navBgView: UIView!
    
    private var animationHolderView: UIView!
    private var progressHUD: CircularProgressBar!
    private var animationIndicator: UIActivityIndicatorView!
    private let animationWidth: CGFloat = 15
    
    private var titleLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews(frame)
    }
    
    private func layoutViews(frame: CGRect){
        navBgView = UIView(frame: CGRect(x: 0, y: StatusBarHeight, width: frame.size.width, height: frame.size.height - StatusBarHeight))
        addSubview(navBgView)
        
        titleLabel = UILabel(frame: CGRect(origin: CGPointZero, size: navBgView.frame.size))
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        
        navBgView.backgroundColor = UIColor.clearColor()
        titleLabel.backgroundColor = UIColor.clearColor()
        
        //Set default color
        backgroundColor = UIColor(red: 51.0 / 255, green: 204.0 / 255, blue: 255.0 / 255, alpha: 1)
        
        //Set Placeholder
        titleLabel.text = ""
        
        animationHolderView = UIView(frame: CGRect(x: 0, y: 0, width: animationWidth, height: animationWidth))
        animationHolderView.center = navBgView.center
        animationHolderView.backgroundColor = UIColor.clearColor()
        
        navBgView.addSubview(animationHolderView)
        
        navBgView.addSubview(titleLabel)
    }
    
    func setBackgroundAlpha(alpha: CGFloat){
        self.backgroundColor = backgroundColor?.colorWithAlphaComponent(alpha)
    }
    
    func animateProgress(progress: CGFloat){
        
        println("Progress is \(progress)")
        
        //If is animating, don't show the progress hud
        if animationIndicator != nil {
            return
        }
        
        //Use a value greater than 0.
        if progress <= 0.05 || progress > 1{
            hideProgressHUD()
        }
        
        else{
            if progressHUD == nil {
                progressHUD = CircularProgressBar(frame: CGRect(x: 0, y: 0, width: animationWidth, height: animationWidth))
                animationHolderView.addSubview(progressHUD)
            }
            
            progressHUD.setProgress(Float(progress))
        }
    }
    
    private func hideProgressHUD(){
        
        if progressHUD != nil{
            progressHUD.hidden = true
            progressHUD.removeFromSuperview()
            progressHUD = nil
        }

    }
    
    func animate(){
        hideProgressHUD()
        
        //Animation in progress
        if animationIndicator != nil{
            return
        }
       
        animationIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        animationIndicator.frame = CGRect(x: 0, y: 0, width: animationWidth, height: animationWidth)
        animationHolderView.addSubview(animationIndicator)
        
        
        animationIndicator.startAnimating()
    }
    
    func endAnimation(){
        animationIndicator.stopAnimating()
        animationIndicator.removeFromSuperview()
        animationIndicator = nil
    }
    
    func setTitle(title: String){
        titleLabel.text = title
        
        //Update animation holder view position
        var width = titleLabelWidth()
        var left = (UIScreen.mainScreen().bounds.size.width - width - 2.4 * animationWidth) / 2
        var frame = CGRect(x: left, y: (navBgView.frame.size.height - animationWidth) / 2, width: animationWidth, height: animationWidth)
        
        //println("Animation frame is \(frame)")
        animationHolderView.frame = frame
        animationHolderView.setNeedsDisplay()
    }
    
    //TODO: format the title label
    func setTitleAttribute(attributes: NSDictionary){
        
    }
    
    
    //MARK: Utlity
    
    //TODO: replace ! with ?
    private func titleLabelWidth() -> CGFloat {
        var size = (titleLabel!.text! as NSString).sizeWithAttributes([NSFontAttributeName: titleLabel.font])
        return size.width
    }
}
