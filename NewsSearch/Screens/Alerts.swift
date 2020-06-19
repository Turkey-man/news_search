//
//  Alerts.swift
//  NewsSearch
//
//  Created by ****** ****** on 18.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit

struct Alerts {
    private static func showBasicAlert(vc: UIViewController, title:     String, message: String) {
        let alert = UIAlertController(title: title, message: message,   preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default,     handler: nil))
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
    static func showNoConnectionAlert(vc: UIViewController) {
        showBasicAlert(vc: vc, title: "No connection", message: "No Internet connection!")
    }
}
