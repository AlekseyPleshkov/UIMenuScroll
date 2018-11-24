//
//  ViewController.swift
//  UIMenuScrollTests
//
//  Created by Aleksey Pleshkov on 14/10/2018.
//  Copyright © 2018 Aleksey Pleshkov. All rights reserved.
//

import UIKit
import UIMenuScroll

class ViewController: UIViewController, UIMenuScrollViewDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func menuScroll(menuScroll: UIMenuScrollView) -> Int {
        return 10
    }
    
    func menuScroll(menuScroll: UIMenuScrollView, createdButton: UIButton, index: Int) {
        createdButton.setTitle("Test", for: .normal)
    }
    
    func menuScroll(menuScroll: UIMenuScrollView, touchSender: UIButton, index: Int) {
        //
    }
    
    func menuScroll(menuScroll: UIMenuScrollView) -> UIImage? {
        return UIImage(named: "")
    }

}
