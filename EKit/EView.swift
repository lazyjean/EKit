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
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
