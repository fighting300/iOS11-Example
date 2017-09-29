//
//  ViewController.swift
//  iOS11-Example
//
//  Created by Leon on 2017/9/27.
//  Copyright © 2017年 leon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func touchDeviceCheck(_ sender: Any) {
        AppDeviceCheck.getNewDeviceId()
    }
    
    @IBAction func touchNFC(_ sender: Any) {
        let nfcVC = NFCViewController()
        self.present(nfcVC, animated: true, completion: nil)
    }
}

