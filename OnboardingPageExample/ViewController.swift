//
//  ViewController.swift
//  OnboardingPageExample
//
//  Created by 김시연 on 2023/09/18.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var onboardPageControl: UIPageControl!
    
    var onboardPageViewController: OnboardPageViewController!
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardPageControl.preferredIndicatorImage = UIImage(named: "otherPageIndicator")
        let startPage = 0  // Assume the 1st page is the start page
        onboardPageControl.setIndicatorImage(UIImage(named: "currentPageIndicator"), forPage: startPage)
        onboardPageControl.pageIndicatorTintColor = UIColor(named: "Gray")
        onboardPageControl.currentPageIndicatorTintColor = UIColor(named: "Neo")
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desinationViewController = segue.destination as? OnboardPageViewController {
            onboardPageViewController = desinationViewController
            onboardPageViewController.onboardDelegate = self
        }
    }
    
    @IBAction func pageControlValueChanged(_ sender: Any) {
        let currentPageIndex = onboardPageControl.currentPage
        currentIndex = currentPageIndex
        onboardPageViewController.goToPage(index: currentPageIndex)
        updatePageControlUI(currentPageIndex: onboardPageControl.currentPage)
    }
    
    func updatePageControlUI(currentPageIndex: Int) {
        onboardPageControl.pageIndicatorTintColor = UIColor(named: "Gray")
        onboardPageControl.currentPageIndicatorTintColor = UIColor(named: "Neo")
        
        (0..<onboardPageControl.numberOfPages).forEach { (index) in
            let currentPageIconImage = UIImage(named: "currentPageIndicator")
            let otherPageIconImage = UIImage(named: "otherPageIndicator")
            let pageIcon = index == currentPageIndex ? currentPageIconImage : otherPageIconImage
            onboardPageControl.setIndicatorImage(pageIcon, forPage: index)
            
        }
    }

}

extension ViewController: OnboardPageControlDelegate {
    func numberOfPage(numberOfPage: Int) {
        onboardPageControl.numberOfPages = numberOfPage
    }
    
    func pageChangedTo(index: Int) {
        updatePageControlUI(currentPageIndex: index)
        onboardPageControl.currentPage = index
        currentIndex = index

    }
    
    
}

protocol OnboardPageControlDelegate: AnyObject {
    func numberOfPage(numberOfPage: Int)
    func pageChangedTo(index: Int)
}

