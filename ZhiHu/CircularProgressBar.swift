//
//  CircularProgressBar.swift
//  ZhiHu
//
//  Created by Hui Hui on 3/9/15.
//  Copyright (c) 2015 Hui Hui. All rights reserved.
//

import UIKit

let π:CGFloat = CGFloat(M_PI)

@IBDesignable class CircularProgressBar: UIView {

    @IBInspectable var counter: Int = 5
    @IBInspectable var outlineColor: UIColor = UIColor.lightGrayColor()
    @IBInspectable var counterColor: UIColor = UIColor.whiteColor()
    
    var circleLayer: CircleLayer!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        
        circleLayer = CircleLayer(frame: frame)
        circleLayer.backgroundColor = UIColor.clearColor().CGColor
        layer.addSublayer(circleLayer)
    }
    
    override func drawRect(rect: CGRect) {
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        let arcWidth: CGFloat = 2
        
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2*π
        
        var path = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.lineWidth = arcWidth
        outlineColor.setStroke()
        path.stroke()
    }

    func setProgress(progress: Float){
        //circleLayer.animateStrokeWithColor(progress)
        
        
    }
}
