//
//  RoundView.swift
//  EKit
//
//  Created by 刘真 on 2017/11/17.
//

import UIKit

@IBDesignable

open class EView: UIView {
    
    @IBInspectable public var radius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = radius
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
    
    //过渡色
    @IBInspectable public var gradient: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var gradientColor1: UIColor = UIColor.white {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var gradientColor2: UIColor = UIColor.black {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var gradientAngle: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    //添加阴影
    @IBInspectable public var shadow: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var shadowOpacity: Float = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    //私有方法
    lazy var gradientLayer: CAGradientLayer = { [unowned self] in
        let layer = CAGradientLayer()
        layer.colors = [self.gradientColor1.cgColor, self.gradientColor2.cgColor]
        layer.speed = 0
        layer.timeOffset = 0
        layer.transform = CATransform3DMakeRotation(gradientAngle/180*CGFloat.pi, 0, 0, 1)
        self.layer.addSublayer(layer)
        return layer
        }()
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        //当设置了自动最大圆角时，忽略普通的圆角设设置
        if autoMaxCornerRadius {
            let maxSide = min(layer.frame.width, layer.frame.height)
            layer.cornerRadius = maxSide/2.0
        } else {
            layer.cornerRadius = radius
        }
        
        //设置边框
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.masksToBounds = layer.borderWidth > 0
        
        if self.gradient {
            self.gradientLayer.colors = [self.gradientColor1.cgColor, self.gradientColor2.cgColor]
            self.gradientLayer.transform = CATransform3DMakeRotation(gradientAngle/180*CGFloat.pi, 0, 0, 1)
            self.gradientLayer.frame = self.bounds
            self.gradientLayer.masksToBounds = true
            
            if autoMaxCornerRadius {
                let maxSide = min(layer.frame.width, layer.frame.height)
                self.gradientLayer.cornerRadius = maxSide/2.0
            } else {
                self.gradientLayer.cornerRadius = radius
            }
        }
        
        //设置阴影效果
        if self.shadow {
            layer.shadowColor = self.shadowColor.cgColor
            layer.shadowOffset = self.shadowOffset
            layer.shadowRadius = self.shadowRadius
            layer.shadowOpacity = self.shadowOpacity
            layer.masksToBounds = false
        }
        
        self.subviews.forEach({[weak self] in self?.bringSubviewToFront($0)})
    }
    
    override open func prepareForInterfaceBuilder() {
        setNeedsLayout()
    }
}
