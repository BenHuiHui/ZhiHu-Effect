//
//  CircleLayer.swift
//  ZhiHu
//
//  Created by Hui Hui on 3/9/15.
//  Copyright (c) 2015 Hui Hui. All rights reserved.
//

import UIKit

class CircleLayer: CAShapeLayer {

    override init!() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame:CGRect){
        super.init()
        
        path = circlePath(frame).CGPath
    }
    
    private func circlePath(rect:CGRect) -> UIBezierPath{
        
        let center = CGPoint(x:rect.width/2, y: rect.height/2)
        let radius: CGFloat = max(rect.width, rect.height)
        
        let arcWidth: CGFloat = 2
        
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2*π
        
        return UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    }
    
    func animateStrokeWithColor(progress: Float) {
        strokeColor = UIColor.whiteColor().CGColor
        var strokeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = progress
        strokeAnimation.duration = 0.1
        addAnimation(strokeAnimation, forKey: "stroke")
    }


}
