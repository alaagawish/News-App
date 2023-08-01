//
//  ArticleTableViewCell.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
    
    func setValues(title: String, author: String, image: String){
        self.articleAuthor.text = author
        self.articleTitle.text = title
        let url = URL(string: image )
        articleImage.kf.setImage(with: url,
                                 placeholder: UIImage(named: "noImg"))
        
    }
    
}
