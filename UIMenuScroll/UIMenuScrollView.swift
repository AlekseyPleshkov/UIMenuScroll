//
//  UIMenuSlideView.swift
//  Ploot
//
//  Created by Aleksey Pleshkov on 12/10/2018.
//  Copyright © 2018 Aleksey Pleshkov. All rights reserved.
//

import UIKit

public class UIMenuScrollView: UIView {
    
    /// Attach events
    public var delegate: UIMenuScrollViewDelegate?
    
    /// Button spacing
    public var spacing: CGFloat = 10.0
    
    /// Button list on stackView
    private var buttonList: [UIButton] = []
    
    /// If active scrolling scoll view to button
    private var isScrollingTo: Bool = false
    
    /// Button in center indicator view
    private var focusButton: UIButton?
    
    /// Create scrollView
    private var _scrollView: UIScrollView?
    private var scrollView: UIScrollView {
        guard let view = self._scrollView else {
            let newElement = UIScrollView()
            newElement.backgroundColor = UIColor.clear
            newElement.translatesAutoresizingMaskIntoConstraints = false
            newElement.delegate = self
            newElement.decelerationRate = .fast
            self._scrollView = newElement
            return newElement
        }
        
        return view
    }
    
    /// Create stackView in scrollView
    private var _stackView: UIStackView?
    private var stackView: UIStackView {
        guard let view = self._stackView else {
            let newElement = UIStackView()
            newElement.spacing = self.spacing
            newElement.axis = .horizontal
            newElement.alignment = .fill
            newElement.distribution = .fillProportionally
            newElement.translatesAutoresizingMaskIntoConstraints = false
            self._stackView = newElement
            return newElement
        }
        
        return view
    }
    
    /// Create center view indicator
    private var _indicatorView: UIImageView?
    private var indicatorView: UIImageView {
        guard let view = self._indicatorView else {
            let newElement = UIImageView()
            newElement.translatesAutoresizingMaskIntoConstraints = false
            newElement.isUserInteractionEnabled = false
            self._indicatorView = newElement
            return newElement
        }
        
        return view
    }
    
    public init() {
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        self.initViews()
        self.setupConstraints()
        self.addButtonsToStackView()
    }
    
    /// Init and add views
    private func initViews() {
        self.scrollView.addSubview(self.stackView)
        self.addSubview(self.scrollView)
        self.addSubview(self.indicatorView)
        
        guard let delegate = self.delegate else { return }
        
        // Set image to indicator view
        self.indicatorView.image = delegate.menuScroll(menuScroll: self)
    }
    
    /// Setting constraints for subviews
    private func setupConstraints() {
        let offsetLeading = self.frame.width / 2 - self.frame.height / 2
        
        let constraints: [NSLayoutConstraint] = [
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //
            self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.stackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: offsetLeading),
            self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -offsetLeading),
            self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            //
            self.indicatorView.widthAnchor.constraint(equalToConstant: self.frame.height),
            self.indicatorView.heightAnchor.constraint(equalToConstant: self.frame.height),
            self.indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Add buttons to stackView
    private func addButtonsToStackView() {
        guard let delegate = self.delegate, self.buttonList.count == 0 else { return }
        
        for index in 0..<delegate.menuScroll(menuScroll: self) {
            let button = self.createButton()
            self.buttonList.append(button)
            self.stackView.addArrangedSubview(button)
            // Aff first button to focused
            if self.focusButton == nil {
                self.focusButton = button
            }
            // Call delegate add button
            delegate.menuScroll(menuScroll: self, createdButton: button, index: index)
        }
    }
    
    /// Creating and setting button
    private func createButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(eventClick), for: .touchUpInside)
        
        // Set sizes
        let constraints: [NSLayoutConstraint] = [
            button.widthAnchor.constraint(equalToConstant: self.frame.height),
            button.heightAnchor.constraint(equalToConstant: self.frame.height)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return button
    }
    
    /// Event click to button in stackView
    @objc func eventClick(sender: UIButton) {
        guard let delegate = self.delegate else { return }
        
        if let focus = self.focusButton, sender == focus {
            let index = self.buttonList.firstIndex(of: focus) ?? 0
            delegate.menuScroll(menuScroll: self, touchSender: focus, index: index)
            
            // Animated indicator
            UIView.animate(withDuration: 0.25, animations: {
                self.indicatorView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }) { _ in
                UIView.animate(withDuration: 0.25, animations: {
                    self.indicatorView.transform = CGAffineTransform.identity
                })
            }
        }
        
        self.scrollTo(button: sender)
    }
    
    /// Selected near button by stack view center
    private func nearButton(scrollView: UIScrollView) -> UIButton? {
        let position = scrollView.contentOffset.x
        
        let near = self.buttonList.filter { button -> Bool in
            let buttonMinX = button.center.x - frame.height - self.spacing
            let buttonMaxX = button.center.x + self.spacing
            return position > buttonMinX && position < buttonMaxX
        }
        
        if let firstNear = near.first {
            return firstNear
        }
        
        return nil
    }
    
    /// Scroll to near button
    private func scrollTo(button: UIButton) {
        let center = button.center.x - frame.height / 2
        self.scrollView.setContentOffset(CGPoint(x: center, y: 0), animated: true)
        self.focusButton = button
        
        // Animated indicator
        UIView.animate(withDuration: 0.5, animations: {
            guard !self.isScrollingTo else { return }
            self.indicatorView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.indicatorView.transform = CGAffineTransform.identity
            }) { _ in
                self.isScrollingTo = false
            }
        }
        self.isScrollingTo = true
    }
}

/// MARK: Extension UIScrollViewDelegate
extension UIMenuScrollView: UIScrollViewDelegate {

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let near = self.nearButton(scrollView: scrollView) {
            self.scrollTo(button: near)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let near = self.nearButton(scrollView: scrollView) {
            self.scrollTo(button: near)
        }
    }
}
