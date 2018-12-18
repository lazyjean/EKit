//
//  RoundImageView.swift
//  EKit
//
//  Created by 刘真 on 2017/11/17.
//

import UIKit

@IBDesignable

open class EImageView: UIImageView {
    
    @IBInspectable public var radius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = radius
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
        
        clipsToBounds = true
    }
    
    override open func prepareForInterfaceBuilder() {
        setNeedsLayout()
    }
}
