//
//  SegmentViewController.swift
//  
//
//  Created by 刘真 on 09/11/2017.
//  Copyright © 2017 LiuZhen. All rights reserved.
//

import UIKit

@IBDesignable
open class ESegmentViewController: UIViewController {
    var transionView: UIView!
    var segment: ESegment!
    
    var viewControllers: [UIViewController]?
    
    var selectedIndex: Int = 0
    
    var selectedController: UIViewController? {
        if selectedIndex >= viewControllers?.count ?? 0 {
            return nil
        }
        return viewControllers![selectedIndex]
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //storyboard直播用TabBarController的模板生成
        if children.count > 0 {
            viewControllers = children
        }
        
        setup()
    }
    
    func setup() {
        
        let items = viewControllers?.map({ (vc) -> String? in
            return vc.tabBarItem.title
        })
        
        segment = ESegment()
        segment.items = items
        segment.backgroundColor = UIColor.white
        segment.addTarget(self, action: #selector(tabChanged(sender:)), for: .valueChanged)
        
        transionView = UIView()
        transionView.backgroundColor = UIColor.white
        
        if isViewLoaded {
            view.addSubview(segment)
            view.addSubview(transionView)
        }
    }
    
    @objc func tabChanged(sender: Any) {
        
        if selectedController?.isViewLoaded ?? false, let selected = selectedController?.view {
            selected.removeFromSuperview()
        }
        
        selectedIndex = segment.selectedIndex
        if isViewLoaded {
            view.setNeedsLayout()
        }
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let segmentSize = segment.intrinsicContentSize
        
        var origin: CGPoint = .zero
        origin.y += self.topLayoutGuide.length
        
        segment.frame = CGRect(x: origin.x, y: origin.y, width: self.view.frame.width, height: segmentSize.height)
        origin.y += segmentSize.height
        
        transionView.frame = CGRect(x: 0, y: origin.y, width: self.view.frame.width, height: self.view.frame.height - self.bottomLayoutGuide.length - origin.y)
        
        //如果没有添加到视图中，先添加进来
        if transionView.superview == nil, segment.superview == nil {
            view.addSubview(segment)
            view.addSubview(transionView)
        }
        
        //更新selectedController
        if let selected = selectedController {
            selected.view.frame = transionView.bounds
            
            if selected.parent != self {
                selected.willMove(toParent: self)
                addChild(selected)
                selected.didMove(toParent: self)
            }
            
            if selected.view.superview != self.view {
                transionView.addSubview(selected.view)
            }
            
            selected.view.frame = transionView.bounds
        }
    }
}
