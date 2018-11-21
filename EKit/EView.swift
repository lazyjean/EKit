//
//  RoundView.swift
//  EKit
//
//  Created by 刘真 on 2017/11/17.
//

import UIKit

@IBDesignable

open class EView: UIView {
    
    @IBInspectable var radius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = radius
            clipsToBounds = true
        }
    }
    
    //设置边框
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            setNeedsLayout()
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = radius
        
        clipsToBounds = layer.cornerRadius > 0
        
        //设置边框
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
    override open func prepareForInterfaceBuilder() {
        setNeedsLayout()
    }
}
