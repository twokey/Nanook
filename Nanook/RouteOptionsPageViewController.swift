//
//  RouteOptionsPageViewController.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-12.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import UIKit

class RouteOptionsPageViewController: UIPageViewController {

    
    // MARK: Properties
    
    var origin: Place!
    var destinations: [Place]!

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        let routesOptionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "routesOptionsViewController") as! RouteOptionsTableViewController
        routesOptionViewController.originPlace = origin
        routesOptionViewController.destinationPlace = destinations.first
        routesOptionViewController.destinationIndex = 0
        setViewControllers([routesOptionViewController], direction: .forward, animated: true, completion: nil)
    }
}

extension RouteOptionsPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let viewControllerIndex = (viewController as! RouteOptionsTableViewController).destinationIndex!
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        let routesOptionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "routesOptionsViewController") as! RouteOptionsTableViewController
        routesOptionViewController.originPlace = origin
        routesOptionViewController.destinationPlace = destinations[previousIndex]
        routesOptionViewController.destinationIndex = previousIndex
        
        return routesOptionViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let viewControllerIndex = (viewController as! RouteOptionsTableViewController).destinationIndex!
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < destinations.count else {
            return nil
        }
        
        let routesOptionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "routesOptionsViewController") as! RouteOptionsTableViewController
        routesOptionViewController.originPlace = origin
        routesOptionViewController.destinationPlace = destinations[nextIndex]
        routesOptionViewController.destinationIndex = nextIndex

        return routesOptionViewController
    }
}
