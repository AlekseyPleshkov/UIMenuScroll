//
//  UIMenuScrollTests.swift
//  UIMenuScrollTests
//
//  Created by Aleksey Pleshkov on 13/10/2018.
//  Copyright © 2018 Aleksey Pleshkov. All rights reserved.
//

import XCTest
@testable import UIMenuScroll

class UIMenuScrollTests: XCTestCase {
    
    var menuScroll: UIMenuScrollView?
    var viewController: ViewController?

    override func setUp() {
        self.viewController = ViewController()
        self.menuScroll = UIMenuScrollView()
        
        if let menuScroll = self.menuScroll, let viewController = self.viewController {
            menuScroll.delegate = viewController
            menuScroll.startInit()
        }
    }

    func testNil() {
        XCTAssertNotNil(self.viewController, "ViewController is nil")
        XCTAssertNotNil(self.menuScroll, "MenuScroll is nil")
        XCTAssertNotNil(self.menuScroll?.delegate, "MenuScroll delegate is nil")
    }
    
    func testMenuScroll() {
        if let menuScroll = self.menuScroll {
            XCTAssertTrue(menuScroll.buttonsCount == 10, "Buttons is not created")
            XCTAssertTrue(menuScroll.buttonsList.count == 10, "Buttons is not created in UI")
            XCTAssertNotNil(menuScroll.focusButton, "Not is set first button to focus")
            XCTAssertNotNil(menuScroll.nearButton(scrollView: menuScroll.scrollView), "The button closest to the center was not found.")
        }
    }

}
