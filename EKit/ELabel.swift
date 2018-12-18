//
//  RoundLabel.swift
//  EKit
//
//  Created by 刘真 on 11/01/2018.
//

import UIKit

@IBDesignable
open class ELabel: UILabel {
    @IBInspectable public var radius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = radius
            setNeedsLayout()
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
