//
//  RoundImageView.swift
//  EKit
//
//  Created by 刘真 on 2017/11/17.
//

import UIKit

@IBDesignable
public class RoundImageView: UIImageView {
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
    
    override public func prepareForInterfaceBuilder() {
        setNeedsLayout()
    }
}