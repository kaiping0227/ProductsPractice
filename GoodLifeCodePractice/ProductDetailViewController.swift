//
//  ProductDetailViewController.swift
//  GoodLifeCodePractice
//
//  Created by Francis Tseng on 2017/10/1.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import UIKit
import SDWebImage

enum Status {
    
    case normal, favorite
    
}

class ProductDetailViewController: UIViewController, ProductDelegate {
    
    var productID = 0
    
    var productStatus: Status = .normal
    
    let fetchManager = FetchManager()
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var salesCountLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchManager.getProduct(productID)
        
        fetchManager.delegateProduct = self
        
        setUpNoteButton()
        
    }

    func setUpNoteButton() {
        
        switch productStatus {
            
        case .normal:
            favoriteButton.setImage(#imageLiteral(resourceName: "ic_favorite_border_48pt"), for: .normal)
            
        case .favorite:
            favoriteButton.setImage(#imageLiteral(resourceName: "ic_favorite_48pt"), for: .normal)
            
        }
        
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
        let image = (sender.imageView?.image)!
        
        switch image {
            
        case #imageLiteral(resourceName: "ic_favorite_48pt"):
            favoriteButton.setImage(#imageLiteral(resourceName: "ic_favorite_border_48pt"), for: .normal)
            fetchManager.deleteFromFavoriteList(productID)

        case #imageLiteral(resourceName: "ic_favorite_border_48pt"):
            favoriteButton.setImage(#imageLiteral(resourceName: "ic_favorite_48pt"), for: .normal)
            fetchManager.addToFavoriteList(productID)

        default:
            break
            
        }

    }
    
    func didGet(_ product: Product) {
        
        DispatchQueue.main.async {
            
            self.productImageView.sd_showActivityIndicatorView()
            self.productImageView.sd_setImage(with: URL(string: product.imageOriginalUrl), completed: nil)
            
            self.titleLabel.text = product.title
            
            self.priceLabel.text = "$ " + product.price.description
            
            self.salesCountLabel.text = product.salesCount.description
            
            self.contentLabel.text = product.content
            
        }
    }
}
