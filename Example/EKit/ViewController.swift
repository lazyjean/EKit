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
        
        cacheProgress.observedTimes = [0.1, 0.2, 0.5, 0.8]
    }
    
    @objc func valueChanged(sender: Any) {
        print(sortEditor.sorted())
    }
}

