//
//  ArticleViewController.swift
//  NewsSearch
//
//  Created by ****** ****** on 17.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var articleWebKitView: WKWebView!
    
    var presenter: ArticlePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.onStart()
        articleWebKitView.load(URLRequest(url: URL(string: presenter.articleURL)!))
        navigationItem.title = presenter.articleTitle
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension ArticleViewController: ArticleMvpView {
    func showNoConnectionAlert() {
        Alerts.showNoConnectionAlert(vc: self)
    }
}
