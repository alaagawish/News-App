//
//  HomeViewController.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import UIKit
import Reachability

class HomeViewController: UIViewController {
    
    @IBOutlet weak var articleTable: UITableView!
    var articles: [Article] = []
    var homeViewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel(network: Network(), localSource: Local.instance)
        
        
        self.articleTable.register(UINib(nibName: Constants.articleTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.articleCell)
        
        homeViewModel.passArticlesToViewController = {
            [weak self] in self?.articles = self?.homeViewModel.articles ?? []
            self?.articleTable.reloadData()
            self?.homeViewModel.saveArticlesLocal()
        }
        homeViewModel.getData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let reachability = try! Reachability()
        if reachability.connection != .unavailable {
            print("Network is available")
            homeViewModel.deleteAll()
            homeViewModel.getData()
            
            
        } else {
            print("Network is not available")
            
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
        cell.setValues(title: articles[indexPath.row].title , author: articles[indexPath.row].author ?? "" , image: articles[indexPath.row].urlToImage ?? ""  )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleDetails = self.storyboard?.instantiateViewController(withIdentifier: Constants.detailsStoryboard) as! DetailsViewController
        articleDetails.modalPresentationStyle = .fullScreen
        
        articleDetails.article = articles[indexPath.row]
        
        present(articleDetails, animated: true)
    }
}
