//
//  Segment.swift
//
//
//  Created by 刘真 on 09/11/2017.
//  Copyright © 2017 LiuZhen. All rights reserved.
//

import UIKit

@IBDesignable
open class ESegment: UIControl {
    
    //条目
    public var items: [String?]? {
        didSet {
            for sub in self.subviews {
                sub.removeFromSuperview()
            }
            createLabels()
            createIndicator()
        }
    }
    
    @IBInspectable var itemString: String? {
        didSet {
            items = itemString?.components(separatedBy: CharacterSet.init(charactersIn: " "))
        }
    }
    
    //当前选中的idnex
    @IBInspectable public var selectedIndex: Int = 0
    
    //UI
    var labels: [UILabel] = []
    var separators: [UIView] = []
    
    //配置指示器
    var indicator: UIView?
    @IBInspectable public var indicatorH: CGFloat = 4
    @IBInspectable public var indicatorW: CGFloat = 19
    @IBInspectable public var indicatorColor: UIColor = #colorLiteral(red: 0.9803921569, green: 0.568627451, blue: 0.1960784314, alpha: 1)
    
    //配置分隔线
    @IBInspectable public var separatorColor: UIColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
    @IBInspectable public var separatorWidth: CGFloat = 1
    
    //字体
    @IBInspectable public var font: UIFont = UIFont.systemFont(ofSize: 14)
    
    //设置字体大小
    @IBInspectable public var fontSize: CGFloat = 14 {
        didSet {
            font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    @IBInspectable public var fontColor: UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    @IBInspectable public var selectedColor: UIColor = #colorLiteral(red: 0.9803921569, green: 0.568627451, blue: 0.1960784314, alpha: 1)
    
    //垂直布局
    @IBInspectable public var vertical: Bool = false
    
    open override func awakeFromNib() {
        createIndicator()
    }
    
    //生成Labels
    func createLabels() {
        
        labels.removeAll()
        for item in items ?? [] {
            let label = UILabel()
            label.text = item
            label.textAlignment = .center
            label.font = self.font
            labels.append(label)
            addSubview(label)
            label.sizeToFit()
        }

        separators.removeAll()
        if let count = items?.count, count > 1 {
            for _ in 0..<count - 1 {
                let separator = UIView()
                separator.backgroundColor = separatorColor
                separators.append(separator)
                addSubview(separator)
            }
        }
    }
    
    func createIndicator() {
        //设置指示器
        indicator?.removeFromSuperview()
        indicator = UIView()
        if let indicator = indicator {
            indicator.layer.cornerRadius = 2
            indicator.layer.masksToBounds = true
            indicator.backgroundColor = indicatorColor
            indicator.frame = CGRect(origin: .zero, size: CGSize(width: indicatorW, height: indicatorH))
            addSubview(indicator)
        }
    }
   
    open override func layoutSubviews() {
        super.layoutSubviews()

        if vertical {
            let itemHeight = (self.frame.height - CGFloat(2*separators.count))/CGFloat(labels.count)
            var center = CGPoint(x: self.frame.width/2.0, y: itemHeight/2.0)
            
            //布局label
            for index in 0..<labels.count {
                let label = labels[index]
                label.font = font
                label.sizeToFit()
                label.textColor = selectedIndex == index ? selectedColor : fontColor
                label.center = center
                center.y += itemHeight + separatorWidth //2个像素为分隔线的宽度
            }
            indicator?.isHidden = true
        }
        else {
            indicator?.isHidden = false
            
            let itemWidth = (self.frame.width - CGFloat(2*separators.count))/CGFloat(labels.count)
            let contentHeight = self.frame.height
            var center = CGPoint(x: itemWidth/2.0, y: contentHeight/2.0)
            
            //布局label
            for index in 0..<labels.count {
                let label = labels[index]
                label.sizeToFit()
                label.font = font
                label.textColor = selectedIndex == index ? selectedColor : fontColor
                label.center = center
                center.x += itemWidth + separatorWidth //2个像素为分隔线的宽度
            }
            
            //布局分隔线
            center.x = itemWidth + separatorWidth/2.0
            for index in 0..<separators.count {
                let separator = separators[index]
                separator.frame.size = CGSize(width: separatorWidth, height: font.lineHeight)
                separator.center = center
                separator.backgroundColor = separatorColor
                center.x += itemWidth + separatorWidth
            }
        }

        layoutIndicator()
    }

    //布局指示器
    func layoutIndicator() {

        let itemWidth = (self.frame.width - CGFloat(2*separators.count))/CGFloat(labels.count)

        if labels.count > 0 {
            let indicatorY = self.frame.height - indicatorH/2.0
            let indicatorX = CGFloat(selectedIndex) * (itemWidth + separatorWidth) + itemWidth/2.0
            indicator?.center = CGPoint(x: indicatorX, y: indicatorY)
            indicator?.backgroundColor = indicatorColor
        }
    }

    var touching = false
    var preTouchIndex = 0
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p = touches.first?.location(in: self), self.bounds.contains(p) {
            touching = true
            preTouchIndex = indexOf(point: p)
        }
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p = touches.first?.location(in: self), self.bounds.contains(p), touching {
            if preTouchIndex == indexOf(point: p) {

                if preTouchIndex == selectedIndex {
                    touching = false
                    preTouchIndex = -1
                    return;
                }

                selectedIndex = preTouchIndex

                touching = false
                preTouchIndex = -1
                setNeedsLayout()

                UIView.animate(withDuration: 0.2, animations: {[weak self] in
                    self?.layoutIndicator()
                })

                self.sendActions(for: .valueChanged)
            }
        }
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p = touches.first?.location(in: self), !self.bounds.contains(p) {
            touching = false
        }
    }

    func indexOf(point: CGPoint) -> Int {
        if vertical {
            let height = frame.height / CGFloat(labels.count)
            let index = Int(point.y / height)
            return index
        }
        
        let width = frame.width / CGFloat(labels.count)
        let index = Int(point.x / width)
        return index
    }

    override open var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: UIView.noIntrinsicMetric, height: 44)
        }
    }

    override open func prepareForInterfaceBuilder() {
        items = itemString?.components(separatedBy: CharacterSet.init(charactersIn: " "))
    }
}
