//
//  HomeViewController.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import UIKit
import Reachability
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var articleTable: UITableView!
    var articles: [Article] = []
    var searchArticles: [Article] = []
    var homeViewModel: HomeViewModel!
    var disposeBag: DisposeBag!
    override func viewDidLoad() {
        super.viewDidLoad()
        disposeBag = DisposeBag()
        homeViewModel = HomeViewModel(network: Network(), localSource: Local.instance)
        searchBar.delegate = self
        self.articleTable.register(UINib(nibName: Constants.articleTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.articleCell)
        
        homeViewModel.passArticlesToViewController = {
            [weak self] in self?.articles = self?.homeViewModel.articles ?? []
            self?.searchArticles = self?.articles ?? []
            self?.articleTable.reloadData()
            self?.homeViewModel.saveArticlesLocal()
            self?.search()
        }
        homeViewModel.getData()
        search()
        pullToRefresh()
    }
    
    
    func pullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        articleTable.refreshControl = refreshControl
    }
    
    
    @objc func refresh() {
        homeViewModel.getData()
        articleTable.reloadData()
        articleTable.refreshControl?.endRefreshing()
    }
    
    
    func search() {
        searchBar.rx.text.subscribe{[weak self] text in
            guard let self = self else {return}
            self.filter(searchText: text!)
        }.disposed(by: disposeBag)
    }
    
    func filter(searchText:String) {
        if(!searchText.isEmpty) {
            articles = searchArticles.filter{ $0.title!.lowercased().contains(searchText.lowercased())}
            if articles.isEmpty {
                articles = []
            }
        }else {
            articles = searchArticles
        }
        self.articleTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let reachability = try! Reachability()
        if reachability.connection != .unavailable {
           // homeViewModel.deleteAll()
            homeViewModel.getData()
            
        } else {
            
            articles = homeViewModel.getSavedArticles()
            articleTable.reloadData()
            let alert : UIAlertController = UIAlertController(title: Constants.internetConnection, message: Constants.checkConnection, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: Constants.ok, style: .cancel,handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        reachability.whenReachable = { reachability in
            print("Network is available")
        }
        reachability.whenUnreachable = { reachability in
            print("Network is not available")
            
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.articleCell, for: indexPath) as! ArticleTableViewCell
        cell.setValues(title: articles[indexPath.row].title ?? "" , author: articles[indexPath.row].author ?? "" , image: articles[indexPath.row].urlToImage ?? ""  )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleDetails = self.storyboard?.instantiateViewController(withIdentifier: Constants.detailsStoryboard) as! DetailsViewController
        articleDetails.modalPresentationStyle = .fullScreen
        
        articleDetails.article = articles[indexPath.row]
        
        present(articleDetails, animated: true)
    }
}
