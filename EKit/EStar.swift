//
//  EStar.swift
//  EKit
//
//  Created by 刘真 on 2018/1/19.
//

import UIKit

@IBDesignable
public class EStar: UIView {
    
    @IBInspectable public var starCount: Int = 0
    @IBInspectable public var starIcon: UIImage?
    @IBInspectable public var spacing: CGFloat = 0
    @IBInspectable public var starSize: CGSize = .zero
    
    private var imageViews: [UIImageView] = []
    
    func setupImageViews() {
        
        for iv in imageViews {
            iv.removeFromSuperview()
        }
        
        imageViews.removeAll()
        
        for _ in 0..<starCount {
            let iv = UIImageView(image: starIcon)
            imageViews.append(iv)
            addSubview(iv)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if starCount == 0 {
            return
        }
        
        setupImageViews()
        
        var origin: CGPoint = .zero
        
        var cellSize = starSize
        if cellSize == .zero, let ss = starIcon?.size {
            cellSize = ss
        }
        
        let contentWidth = CGFloat(starCount) * cellSize.width + CGFloat(starCount - 1) * spacing
        origin.x = (self.frame.width - contentWidth)/2.0
        origin.y = (self.frame.height - cellSize.height)/2.0
        
        for iv in imageViews {
            iv.frame = CGRect(origin: origin, size: cellSize)
            origin.x += cellSize.width
            origin.x += spacing
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        get {
            if let s = starIcon?.size {
                let t = CGFloat(max(starCount, 1))
                let w = t * s.width + (t - 1) * spacing
                let h = s.height
                return CGSize(width: w, height: h)
            }
            return CGSize(width: UIViewNoIntrinsicMetric, height: UIViewNoIntrinsicMetric)
        }
    }
    
    public override func prepareForInterfaceBuilder() {
        setNeedsLayout()
    }
}
