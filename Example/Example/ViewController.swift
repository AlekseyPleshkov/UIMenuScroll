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
    @IBOutlet weak var labelEventName: UILabel!
    
    private let menuScrollImages: [String] = [
        "menu-clean", "menu-eat", "menu-hand", "menu-play", "menu-sleep"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuScroll.delegate = self
        self.menuScroll.spacing = 10.0
    }
    
    private func clickToMenu (index: Int) {
        let imageNamge = self.menuScrollImages[index]
        self.labelEventName.text = "\(imageNamge)"
    }
}

extension ViewController: UIMenuScrollViewDelegate {
    
    func menuScroll(menuScroll: UIMenuScrollView) -> Int {
        return self.menuScrollImages.count
    }
    
    func menuScroll(menuScroll: UIMenuScrollView, createdButton: UIButton, index: Int) {
        let buttonImage = UIImage(named: self.menuScrollImages[index])
        createdButton.setImage(buttonImage, for: .normal)
    }
    
    func menuScroll(menuScroll: UIMenuScrollView, touchSender: UIButton, index: Int) {
        self.clickToMenu(index: index)
    }
    
    func menuScroll(menuScroll: UIMenuScrollView) -> UIImage? {
        return UIImage(named: "menuScrollIndicator")
    }
}
