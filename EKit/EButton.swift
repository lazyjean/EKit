//
//  RoundButton.swift
//  EKit
//
//  Created by 刘真 on 2017/11/17.
//

import UIKit

@IBDesignable
open class EButton: UIButton {
    
    //设置半径
    @IBInspectable public var radius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = radius
            setNeedsLayout()
        }
    }
    
    //设置边框
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            setNeedsLayout()
        }
    }
    
    //最大圆角
    @IBInspectable public var autoMaxCornerRadius: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        //当设置了自动最大圆角时，忽略普通的圆角设设置
        if autoMaxCornerRadius {
            let maxSide = min(layer.frame.width, layer.frame.height)
            layer.cornerRadius = maxSide/2.0
        } else {
            layer.cornerRadius = radius
        }
        clipsToBounds = layer.cornerRadius > 0

        //设置边框
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
    override open func prepareForInterfaceBuilder() {
        setNeedsLayout()
    }
}
