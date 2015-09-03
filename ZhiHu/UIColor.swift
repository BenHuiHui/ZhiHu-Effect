//
//  UIColor.swift
//  ZhiHu
//
//  Created by Hui Hui on 5/8/15.
//  Copyright (c) 2015 Hui Hui. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgbValue: UInt, alpha: CGFloat){
        self.init( red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,blue: CGFloat(rgbValue & 0x0000FF) / 255.0,alpha: alpha
        )
    }
}
