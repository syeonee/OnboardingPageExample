//
//  ViewController.swift
//  OnboardingPageExample
//
//  Created by 김시연 on 2023/09/18.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var onboardPageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var onboardPageViewController: OnboardPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardPageControl.preferredIndicatorImage = UIImage(named: "otherPageIndicator")
        onboardPageControl.setIndicatorImage(UIImage(named: "currentPageIndicator"), forPage: 0)
        onboardPageControl.pageIndicatorTintColor = UIColor(named: "Gray")
        onboardPageControl.currentPageIndicatorTintColor = UIColor(named: "Neo")
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let nextPageIndex = onboardPageControl.currentPage + 1
        onboardPageViewController.goToPage(index: nextPageIndex)
        onboardPageControl.currentPage = nextPageIndex
        updatePageControlUI(currentPageIndex: nextPageIndex)
        
        changeButtonText(index: nextPageIndex)
    }
    
    func changeButtonText(index: Int) {
        if index == (onboardPageControl.numberOfPages-1){
            nextButton.titleLabel?.text = "마지막"
        }else{
            nextButton.titleLabel?.text = "다음"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desinationViewController = segue.destination as? OnboardPageViewController {
            onboardPageViewController = desinationViewController
            onboardPageViewController.onboardDelegate = self
        }
    }
    
    @IBAction func pageControlValueChanged(_ sender: Any) {
        let currentPageIndex = onboardPageControl.currentPage
        onboardPageViewController.goToPage(index: currentPageIndex)
        updatePageControlUI(currentPageIndex: currentPageIndex)
        
        changeButtonText(index: currentPageIndex)
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
        
        changeButtonText(index: index)

    }
    
    
}

protocol OnboardPageControlDelegate: AnyObject {
    func numberOfPage(numberOfPage: Int)
    func pageChangedTo(index: Int)
}

