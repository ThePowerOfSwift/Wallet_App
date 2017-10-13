//
//  UIColorPlatter.swift
//  wallet
//
//  Created by Ammy Pandey on 04/04/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    class func uicolorFromHex(_ rgbValue:UInt32, alpha : CGFloat)->UIColor
        
    {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0xFF) / 255.0
        return UIColor(red:red, green:green, blue:blue, alpha: alpha)
    }
}
