//
//  UIMenuScrollViewDelegate.swift
//  Ploot
//
//  Created by Aleksey Pleshkov on 12/10/2018.
//  Copyright © 2018 Aleksey Pleshkov. All rights reserved.
//

import UIKit

public protocol UIMenuScrollViewDelegate {
    
    /// Set count a elements in menu scroll
    func menuScroll(menuScroll: UIMenuScrollView) -> Int
    
    /// Set options to single button on menu scroll
    func menuScroll(menuScroll: UIMenuScrollView, createdButton: UIButton, index: Int)
    
    /// Touch button event
    func menuScroll(menuScroll: UIMenuScrollView, touchSender: UIButton, index: Int)
    
    /// Set options to center indicator image
    func menuScroll(menuScroll: UIMenuScrollView) -> UIImage
    
}
