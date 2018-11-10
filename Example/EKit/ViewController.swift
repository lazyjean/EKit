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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sortEditor.source = ["LiLei", "HanMeimei", "John"]
//        sortEditor.addTarget(self, action: #selector(valueChanged:), for: .valueChanged)
        sortEditor.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
        cacheProgress.backgroundColor = UIColor.red
        cacheProgress.observedTimes = [0.1, 0.2, 0.5, 0.8]
        
        let ep = ECacheProgress.init(frame: CGRect.init(x: 50, y: self.view.frame.height-100, width: self.view.frame.width-100, height: 20))
        ep.progress = 0.5
        ep.cacheProgress = 0.8
        ep.observedTimes = [0.1, 0.2, 0.9]
        ep.backgroundColor = UIColor.red
        self.view.addSubview(ep)
        
        cacheProgress.observedTimes = [0.5, 0.8]
    }
    
    @objc func valueChanged(sender: Any) {
        print(sortEditor.sorted())
    }
}

