//
//  SortView.swift
//  Sort
//
//  Created by 刘真 on 2018/3/21.
//  Copyright © 2018年 刘真. All rights reserved.
//

import UIKit

@IBDesignable
open class ESortEditor: UIView {
   
    public var source: [String] = [] {
        didSet {
            setupUI()
        }
    }
    
    var labels: [UILabel] = []
    
    @IBInspectable public var borderColor: UIColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    @IBInspectable public var borderWidth: CGFloat = 1
    @IBInspectable public var itemWidth: CGFloat = 40
    @IBInspectable public var itemHeight: CGFloat = 29
    @IBInspectable public var padding: CGFloat = 15
    @IBInspectable public var itemBackgroundColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    @IBInspectable public var fontSize: CGFloat = 14
    @IBInspectable public var textColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    
    func setupUI() {
        labels.forEach({$0.removeFromSuperview()})
        source.forEach { (item) in
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: itemWidth, height: itemHeight))
            label.text = "\(item)"
            label.font = UIFont.systemFont(ofSize: fontSize)
            label.textColor = textColor
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.layer.borderColor = borderColor.cgColor
            label.layer.borderWidth = borderWidth
            label.layer.cornerRadius = 3
            label.layer.backgroundColor = itemBackgroundColor.cgColor
            labels.append(label)
            addSubview(label)
        }
    }

    override open func layoutSubviews() {
        
        if labels.count == 0 {
            return
        }
        
        let width = CGFloat(labels.count) * itemWidth
        var x = (frame.width - width - padding * CGFloat(max(labels.count - 1, 0)))/2
        
        let y = (frame.height - labels.first!.frame.height)/2
        
        labels.forEach { [weak self] in
            if $0 != self!.pickedUpLabel {
                $0.frame.origin = CGPoint(x: x,y: y)
            }
            x += $0.frame.width + self!.padding
        }
    }
    
    weak var pickedUpLabel: UILabel?
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pt = touches.first?.location(in: self)
        
        for label in labels {
            if let pt = pt, label.frame.contains(pt) {
                pickedUpLabel = label
                bringSubview(toFront: label)
                break
            }
        }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let label = pickedUpLabel, let touch = touches.first else {
            return
        }
        
        let pt = touch.location(in: self)
        let ppt = touch.previousLocation(in: self)
        label.center = label.center.applying(CGAffineTransform(translationX: pt.x - ppt.x, y: pt.y - ppt.y))
        
        var oldIndex = 0
        if let label = pickedUpLabel, let idx = labels.index(of: label) {
            oldIndex = idx
        }
        
        labels.sort {$0.center.x < $1.center.x}
        
        if let label = pickedUpLabel, let current = labels.index(of: label), current != oldIndex {
            updateLayout()
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pickedUpLabel = nil
        labels.sort {$0.center.x < $1.center.x}
        updateLayout()
    }
    
    func updateLayout() {
        UIView.animate(withDuration: 0.3) {
            self.layoutSubviews()
        }
    }
    
    override open func prepareForInterfaceBuilder() {
        self.source = ["LiLei", "HanMeimei", "John"]
    }
}
