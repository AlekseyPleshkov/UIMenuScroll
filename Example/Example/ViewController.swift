//
//  ViewController.swift
//  UIMenuScroll
//
//  Created by AlekseyPleshkov on 10/13/2018.
//  Copyright (c) 2018 AlekseyPleshkov. All rights reserved.
//

import UIKit
import UIMenuScroll

class ViewController: UIViewController {
    
    @IBOutlet weak var menuScroll: UIMenuScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuScroll.delegate = self
        self.menuScroll.spacing = 10.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UIMenuScrollViewDelegate {
    func menuScroll(menuScroll: UIMenuScrollView) -> Int {
        return 10
    }
    
    func menuScroll(menuScroll: UIMenuScrollView, createdButton: UIButton, index: Int) {
        let buttonImage = UIImage(named: "menuScrollTest")
        createdButton.setImage(buttonImage, for: .normal)
    }
    
    func menuScroll(menuScroll: UIMenuScrollView, touchSender: UIButton, index: Int) {
        print("Touch")
    }
    
    func menuScroll(menuScroll: UIMenuScrollView) -> UIImage {
        return UIImage(named: "menuScrollIndicator")!
    }
}
