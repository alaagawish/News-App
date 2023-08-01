//
//  DetailsViewController.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var articleContent: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleURL: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    var article:Article!
    var detailsViewModel: DetailsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleURL.text = article.url
        articleDate.text = article.publishedAt
        articleTitle.text = article.title
        articleSource.text = article.source.name
        articleAuthor.text = article.author
        articleDescription.text = article.description
        articleContent.text = article.content
        let url = URL(string: article.urlToImage ?? "")
        articleImage.kf.setImage(with: url,
                                 placeholder: UIImage(named: Constants.noImg))
        detailsViewModel = DetailsViewModel(localSource: Local.instance)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        articleURL.isUserInteractionEnabled = true
        articleURL.addGestureRecognizer(tapGesture)
    }
    @objc func labelTapped() {
        
        if let url = URL(string: article.url) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Cannot open URL: \(url)")
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if  detailsViewModel.checkFav(article: article) {
            favouriteButton.setImage(UIImage(systemName: Constants.fillHeart), for: .normal)
        }else {
            favouriteButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
        }
        
        
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addFavourite(_ sender: UIButton) {
        if favouriteButton.currentImage ==  UIImage(systemName: Constants.heart) {
            detailsViewModel.addToFav(article: article)
            favouriteButton.setImage(UIImage(systemName: Constants.fillHeart), for: .normal)
            
        }else{
            
            let alert : UIAlertController = UIAlertController(title: Constants.deleteArticle, message: Constants.deleteQuestion, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: Constants.yes, style: .default,handler: { [weak self] action in
                print("delete begin")
               
                
                self?.favouriteButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
                print("heart fill")
                self?.detailsViewModel.removeFromFav(article: (self?.article)!)
                
            }))
            alert.addAction(UIAlertAction(title: Constants.no, style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
