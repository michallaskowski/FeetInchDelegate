//
//  ViewController.swift
//  FeetInchDelegate
//
//  Created by michallaskowski on 10/18/2015.
//  Copyright (c) 2015 michallaskowski. All rights reserved.
//

import UIKit
import FeetInchDelegate
class ViewController: UIViewController {
    
    let del = FeetInchDelegate()
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.delegate = del
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

