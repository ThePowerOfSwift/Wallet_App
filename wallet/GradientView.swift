//
//  GradientView.swift
//  wallet
//
//  Created by Ammy Pandey on 04/04/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

@IBDesignable
class Gradient_View: UIView {
    
    @IBInspectable var FirstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var SecondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
//    @IBInspectable var ThirdColor: UIColor = UIColor.clear {
//        didSet {
//            updateView()
//        }
//    }

    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor, SecondColor.cgColor, ]
    }
}
