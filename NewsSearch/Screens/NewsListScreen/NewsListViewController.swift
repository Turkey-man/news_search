//
//  NewsListViewController.swift
//  NewsSearch
//
//  Created by ****** ****** on 17.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Kingfisher
import RxCocoa
import RxSwift

class NewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: NewsListPresenter!
    var imagesArray = [UIImage?]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = NewsListPresenter(view: self)
        setupNavBar()
        setupTableView()
        presenter.onStart()
    }
    
    func setupNavBar() {
        navigationItem.title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.rx.text
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] query in
                if searchController.searchBar.text == "" {
                } else {
                    guard let text = searchController.searchBar.text else {return}
                    self.presenter.findNews(searchRequest: text)
                }
            }).disposed(by: disposeBag)
    }
    
    func setupTableView() {
        let cellNib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "customNewsCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.filteredArticlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customNewsCell") as? NewsTableViewCell else { return UITableViewCell() }
        let article = presenter.filteredArticlesArray[indexPath.row]
        if let url = article.urlToImage {
            let imageUrl = URL(string: url)
            cell.newsPreviewImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "iconNoImage"))
        }
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = presenter.filteredArticlesArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard
            .instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        viewController.presenter = ArticlePresenter(view: viewController)
        viewController.presenter.articleURL = article.url!
        viewController.presenter.articleTitle = article.title!
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension NewsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        navigationItem.title = "Search results"
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.cancelSearch()
        navigationItem.title = "News"
    }
}

extension NewsListViewController: NewsListMvpView {
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showNoConnectionAlert() {
        Alerts.showNoConnectionAlert(vc: self)
    }
}
