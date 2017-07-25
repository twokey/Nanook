//
//  AllertViewController.swift
//  MapMe
//
//  Created by Kirill Kudymov on 2017-04-06.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import UIKit

class AllertViewController: UIViewController {

    
    // Use this fucntion to show alerts from in function in the app
    static func showAlertWithTitle(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
}
