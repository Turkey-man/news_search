//
//  ArticlePresenter.swift
//  NewsSearch
//
//  Created by ****** ****** on 17.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

class ArticlePresenter: BasePresentrer {
    
    var view: ArticleMvpView?
    var articleTitle = ""
    var articleURL = ""
    
    init(view: ArticleMvpView) {
        self.view = view
    }
    
    func onStart() {
        if !networkMethods.checkConnection() {
            view?.showNoConnectionAlert()
        }
    }
}
