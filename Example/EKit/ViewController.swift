//
//  ViewController.swift
//  EKit
//
//  Created by lazyjean on 11/17/2017.
//  Copyright (c) 2017 lazyjean. All rights reserved.
//

import UIKit
import EKit

class ViewController: UIViewController {

    @IBOutlet weak var sortEditor: ESortEditor!
    @IBOutlet weak var cacheProgress: ECacheProgress!
    @IBOutlet weak var shadowView: EView!
    @IBOutlet weak var shadow: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sortEditor.source = ["LiLei", "HanMeimei", "John"]
        sortEditor.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
        
        cacheProgress.backgroundColor = UIColor.red
        cacheProgress.observedTimes = [0.1, 0.2, 0.5, 0.8]
        
        let ep = ECacheProgress.init(frame: CGRect.init(x: 50, y: self.view.frame.height-100, width: self.view.frame.width-100, height: 20))
        ep.progress = 0.5
        ep.cacheProgress = 0.8
        ep.observedTimes = [0.1, 0.2, 0.9]
        ep.pauseIndicatorImage = #imageLiteral(resourceName: "断点")
        ep.backgroundColor = UIColor.red
        self.view.addSubview(ep)
        
        cacheProgress.observedTimes = [0.5, 0.8]
        
        cacheProgress.addTarget(self, action: #selector(dragBar(sender:)), for: .valueChanged)
        cacheProgress.addTarget(self, action: #selector(dragInside(sender:)), for: .touchDragInside)
        
//        self.shadow.layer.shadowColor = UIColor.red.cgColor
//        self.shadow.layer.shadowRadius = 5
//        self.shadow.layer.shadowOpacity = 1
//        self.shadow.layer.shadowOffset = CGSize(width: 3, height: 
//        self.shadow.layer.masksToBounds = true

        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
                self.cacheProgress.progress = CGFloat(Int.random(in: 1...100))/100
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func valueChanged(sender: Any) {
        print(sortEditor.sorted())
    }
    
    @objc func dragBar(sender: Any) {
        let ep = sender as! ECacheProgress
        print("drag bar \(ep.progress)")
    }
    
    @objc func dragInside(sender: Any) {
        let ep = sender as! ECacheProgress
        print("drag inside \(ep.progress)")
    }
}

