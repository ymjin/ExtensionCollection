//
//  ViewController.swift
//  ExtensionCollection
//
//  Created by ymjin on 07/10/2023.
//  Copyright (c) 2023 ymjin. All rights reserved.
//

import UIKit
import ExtensionCollection

class ViewController: UIViewController {
    
    @IBOutlet var v:UIView!
    @IBOutlet var l:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        v.changeBorder(color: .red)
        l.text = Date().UTCToKST().toString()
    }
}

