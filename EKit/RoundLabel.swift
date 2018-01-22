//
//  RoundLabel.swift
//  EKit
//
//  Created by 刘真 on 11/01/2018.
//

import UIKit

@IBDesignable
open class RoundLabel: UILabel {
    @IBInspectable var radius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = radius
            clipsToBounds = true
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    override open func prepareForInterfaceBuilder() {
        setNeedsLayout()
    }
}
