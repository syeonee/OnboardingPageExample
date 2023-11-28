//
//  OnboardPageViewController.swift
//  OnboardingPageExample
//
//  Created by 김시연 on 2023/09/18.
//

import UIKit

class OnboardPageViewController: UIPageViewController {
    
    var contentPageViewControllerList = [UIViewController]()
    weak var onboardDelegate: OnboardPageControlDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        contentPageViewControllerList = [
            storyBoard.instantiateViewController(withIdentifier: "OneOnboard"),
            storyBoard.instantiateViewController(withIdentifier: "TwoOnboard"),
            storyBoard.instantiateViewController(withIdentifier: "ThreeOnboard"),
            storyBoard.instantiateViewController(withIdentifier: "FourOnboard"),
            storyBoard.instantiateViewController(withIdentifier: "FiveOnboard")
        ]
        onboardDelegate?.numberOfPage(numberOfPage: contentPageViewControllerList.count)
        setViewControllers([contentPageViewControllerList[0]], direction: .forward, animated: false, completion: nil)
    }
    
    
    func goToPage(index: Int) {
        let currentViewController = viewControllers!.first!
        let currentViewControllerIndex = contentPageViewControllerList.firstIndex(of: currentViewController)!
        
        let direction: NavigationDirection = index > currentViewControllerIndex ? .forward : .reverse
        setViewControllers([contentPageViewControllerList[index]], direction: direction, animated: false, completion: nil)
    }
    

}

extension OnboardPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = contentPageViewControllerList.firstIndex(of: viewController)!
        if currentIndex == 0 {
            return nil
        } else {
            return contentPageViewControllerList[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = contentPageViewControllerList.firstIndex(of: viewController)!
        if currentIndex == contentPageViewControllerList.count - 1 {
            return nil
        } else {
            return contentPageViewControllerList[currentIndex + 1]
        }
    }
    
}

extension OnboardPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentPageViewController = pageViewController.viewControllers?.first {
            let index = contentPageViewControllerList.firstIndex(of: currentPageViewController)!
            onboardDelegate?.pageChangedTo(index: index)
            
        }
    }
    
}
