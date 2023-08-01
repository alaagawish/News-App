//
//  FavouritesViewController.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var articlesTable: UITableView!
    var articles: [LocalArticle] = []
    var favouritesViewModel: FavouritesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritesViewModel = FavouritesViewModel(localSource: Local.instance)
        self.articlesTable.register(UINib(nibName: Constants.articleTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.articleCell)
        
        favouritesViewModel.refreshFavouriteArticles = {
            [weak self] in self?.articles = self?.favouritesViewModel.articles ?? []
            self?.articlesTable.reloadData()
        }
        favouritesViewModel.getArticles()
    }
        
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.articleCell, for: indexPath) as! ArticleTableViewCell
        cell.setValues(title: articles[indexPath.row].title, author: articles[indexPath.row].author, image: articles[indexPath.row].urlToImage)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert : UIAlertController = UIAlertController(title: Constants.deleteArticle, message: Constants.deleteQuestion, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Constants.yes, style: .default,handler: { [weak self] action in
                        
            self?.favouritesViewModel.deleteArticle(article: (self?.articles[indexPath.row])!)
            self?.articles.remove(at: indexPath.row)
            self?.articlesTable.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: Constants.no, style: .cancel,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
