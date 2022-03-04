//
//  ViewController.swift
//  customPageControl
//
//  Created by Apple on 4.03.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var viewForPageControl: UIView!
    var customPageControl: CustomPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewForPageControl.layoutIfNeeded()
        customPageControl = CustomPageControl(frame: viewForPageControl.bounds)
        guard let customControl = customPageControl else {return}
        customControl.setNumberOfPages(numberOfPages: 5)
        customControl.setCurrentPage(currentPage: 2)
        customControl.setCurrentPageIndicatorTintColor(currentPageIndicatorTintColor: .orange)
        customControl.setSizeForCircle(size: 12)
        customControl.setSizeForCurrentCircle(size: 17)
        customControl.hidesForSinglePage(isHidden: true)
        viewForPageControl.addSubview(customControl)
        customPageControl?.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
    }
    
    @objc func handleTap(sender: CustomPageControl.Event) {
        customPageControl?.nextPage()
    }
}

