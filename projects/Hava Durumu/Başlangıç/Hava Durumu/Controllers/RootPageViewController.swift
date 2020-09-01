//
//  RootPageViewController.swift
//  Hava Durumu
//
//  Created by Can Balkaya on 8/22/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

class MainViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    // MARK: - Properties
    lazy var viewControllerList: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil )
        let firstVC = storyboard.instantiateViewController(identifier: "FirstVC")
        let secondVC = storyboard.instantiateViewController(identifier: "SecondVC")
        let thirdVC = storyboard.instantiateViewController(identifier: "ThirdVC")
        
        return [firstVC, secondVC, thirdVC]
    }()

    // MARK: - UI Elements
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Functions
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
           
        guard previousIndex >= 0 else { return nil }
        guard viewControllerList.count > previousIndex else { return nil }
    
        return viewControllerList[previousIndex]
    }
       
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
    
        guard viewControllerList.count != nextIndex else { return nil }
        guard viewControllerList.count > nextIndex else { return nil }
       
        return viewControllerList[nextIndex]
    }
}
