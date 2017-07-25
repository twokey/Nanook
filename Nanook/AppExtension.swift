//
//  AppExtension.swift
//  MapMe
//
//  Created by Kirill Kudymov on 2017-04-06.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {

    // Find and return top viewcontroller (to show Alert VC)
    static func topViewController(_ base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(selected)
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        
        return base
    }
    
}
