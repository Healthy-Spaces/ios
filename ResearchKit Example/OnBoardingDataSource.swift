//
//  OnBoardingDataSource.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 8/4/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class OnBoardingDataSource: NSObject, UIPageViewControllerDataSource {

    var pageData: [String] = []
    var index: Int = 0
    
    override init() {
        let localPath = Bundle.main.url(forResource: "index", withExtension: "html")
        pageData = [(localPath?.absoluteString)!, "http://www.apple.com/", "http://lichlyterinc.com/", "http://research.engr.oregonstate.edu/ift/"]
    }
    
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> OnBoardingContentViewController? {
        if self.pageData.count == 0 || index >= self.pageData.count {
            return nil
        }
        
        let contentViewController = storyboard.instantiateViewController(withIdentifier: "ContentViewController") as! OnBoardingContentViewController
        contentViewController.dataObject = self.pageData[index]
        return contentViewController
    }
    
    func indexOfViewController(_ viewController: OnBoardingContentViewController) -> Int {
        return pageData.index(of: viewController.dataObject) ?? NSNotFound
    }
    
    // MARK: - Page View Controller Data Source Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        index = self.indexOfViewController(viewController as! OnBoardingContentViewController)
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
        index = self.indexOfViewController(viewController as! OnBoardingContentViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageData.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return index
    }
}
