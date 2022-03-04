//
//  customPageControl.swift
//  customPageControl
//
//  Created by Apple on 4.03.22.
//

import UIKit

class CustomPageControl: UIControl {
    
    private let backgroundForCircle = UIView()
    private var sizeForCircle: CGFloat = 10
    private var sizeForCurrentCircle: CGFloat = 14
    private var correctionForPoints: CGFloat = -2
    private var numberOfPages = 5
    private var currentPage = 1
    private var hidesForSinglePage = false
    private var currentPageIndicatorTintColor = UIColor.white
    private var pageIndicatorTintColor = UIColor.lightGray
    
    override func draw(_ rect: CGRect) {
        
        correctionForPoints = (sizeForCircle - sizeForCurrentCircle) / 2
        backgroundForCircle.frame = CGRect(x: -correctionForPoints, y: sizeForCircle, width: sizeForCircle * 2.5 * CGFloat(numberOfPages) - sizeForCircle * 1.5, height: sizeForCircle)
        self.addSubview(backgroundForCircle)
        
        pagePoint()
        hideForOnePoint()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tapGesture)
        
    }
    
    private func hideForOnePoint() {
        if hidesForSinglePage == true && numberOfPages == 1 {
            backgroundForCircle.isHidden = true
        } else {
            backgroundForCircle.isHidden = false
        }
    }
    
    private func pagePoint() {
        
        for number in  0...numberOfPages - 1 {
            var xPoint = sizeForCircle * 2.5 * CGFloat(number)
            var yPoint: CGFloat = 0
            var color = pageIndicatorTintColor
            var size = sizeForCircle
            
            if number == currentPage - 1 {
                size = sizeForCurrentCircle
                color = currentPageIndicatorTintColor
                xPoint = xPoint + correctionForPoints
                yPoint = correctionForPoints
            }
            
            let circle = UIView(frame: CGRect(x: xPoint, y: yPoint, width: size, height: size))
            circle.backgroundColor = color
            circle.layer.cornerRadius = size / 2
            backgroundForCircle.addSubview(circle)
        }
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        self.sendActions(for: UIControl.Event.touchUpInside)
    }
    
    func setNumberOfPages(numberOfPages: Int) {
        self.numberOfPages = numberOfPages
    }
    
    func setCurrentPage(currentPage: Int) {
        if currentPage <= numberOfPages {
            self.currentPage = currentPage
        }
    }
    
    func setCurrentPageIndicatorTintColor(currentPageIndicatorTintColor: UIColor) {
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
    }
    
    func setPageIndicatorTintColor(pageIndicatorTintColor: UIColor) {
        self.pageIndicatorTintColor = pageIndicatorTintColor
    }
    
    func setSizeForCircle(size: CGFloat) {
        sizeForCircle = size
    }
    
    func setSizeForCurrentCircle(size: CGFloat) {
        sizeForCurrentCircle = size
    }
    
    func hidesForSinglePage(isHidden: Bool) {
        hidesForSinglePage = isHidden
    }
    
    func nextPage() {
        let oldIndex = currentPage - 1
        var newIndex = currentPage
        if currentPage == numberOfPages {
            currentPage = 1
            newIndex = 0
        } else {
            currentPage += 1
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
            self.backgroundForCircle.subviews[oldIndex].frame = CGRect(x: self.backgroundForCircle.subviews[oldIndex].frame.origin.x - self.correctionForPoints, y: 0, width: self.sizeForCircle, height: self.sizeForCircle)
            self.backgroundForCircle.subviews[oldIndex].layer.cornerRadius = self.sizeForCircle / 2
            self.backgroundForCircle.subviews[oldIndex].backgroundColor = self.pageIndicatorTintColor
            
            self.backgroundForCircle.subviews[newIndex].frame = CGRect(x: self.backgroundForCircle.subviews[newIndex].frame.origin.x + self.correctionForPoints, y: self.correctionForPoints, width: self.sizeForCurrentCircle, height: self.sizeForCurrentCircle)
            self.backgroundForCircle.subviews[newIndex].layer.cornerRadius = self.sizeForCurrentCircle / 2
            self.backgroundForCircle.subviews[newIndex].backgroundColor = self.currentPageIndicatorTintColor
        }
    }
}
