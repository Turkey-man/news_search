//
//  BasePresenter.swift
//  NewsSearch
//
//  Created by ****** ****** on 17.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

class BasePresentrer {
    
    let networkMethods = NetworkMethods()
    
    func checkConnection() -> Bool {
        return networkMethods.checkConnection()
    }
}
