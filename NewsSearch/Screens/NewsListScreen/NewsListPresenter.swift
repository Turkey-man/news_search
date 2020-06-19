//
//  NewsListPresenter.swift
//  NewsSearch
//
//  Created by ****** ****** on 17.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import RxCocoa
import RxSwift

class NewsListPresenter: BasePresentrer {
    
    var view: NewsListMvpView?
    var allArticlesArray = [Article]()
    var filteredArticlesArray = [Article]()
    let disposeBag = DisposeBag()
    
    init(view: NewsListMvpView) {
        self.view = view
    }
    
    func onStart() {
        if networkMethods.checkConnection() == true {
            getNews()
        } else {
            view?.showNoConnectionAlert()
        }
    }
    
    func getNews() {
        networkMethods.getNews { articles in
            guard let receivedArticles = articles.articles else { return }
            self.filteredArticlesArray = receivedArticles
            self.allArticlesArray = receivedArticles
            self.view?.reloadTable()
        }
    }
    
    func findNews(searchRequest: String) {
        networkMethods.findNews(searchRequest: searchRequest) { articles in
            guard let receivedArticles = articles.articles else { return }
            self.filteredArticlesArray.removeAll()
            self.filteredArticlesArray = receivedArticles
            self.view?.reloadTable()
        }
    }
    
    func updateFilteredArray(searchRequest: String) {
        filteredArticlesArray.removeAll()
        for article in allArticlesArray {
            if let title = article.title {
                if let description = article.description {
                    if title.contains(searchRequest) || description.contains(searchRequest) {
                        filteredArticlesArray.append(article)
                    }
                }
            }
        }
        view?.reloadTable()
    }
    
    func cancelSearch() {
        filteredArticlesArray = allArticlesArray
        view?.reloadTable()
    }
}
