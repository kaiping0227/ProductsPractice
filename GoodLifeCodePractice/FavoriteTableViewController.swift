//
//  FavoriteTableViewController.swift
//  GoodLifeCodePractice
//
//  Created by Francis Tseng on 2017/9/30.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteTableViewController: UITableViewController, ProductsDelegate {

    let fetchManager = FetchManager()
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchManager.getFavoriteList()
        
        fetchManager.delegateProducts = self
        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
    }
    
    func didGet(_ products: [Product]) {
        self.products = products
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductFavTableViewCell", for: indexPath) as! FavoriteTableViewCell

        DispatchQueue.main.async {
            
            cell.productTitleLabel.text = self.products[indexPath.row].title
            
            cell.productPriceLabel.text = self.products[indexPath.row].price.description
            
            cell.productStoreNameLabel.text = self.products[indexPath.row].storeName
            
            cell.productSalesCountLabel.text = "Sold " + self.products[indexPath.row].salesCount.description
            
            cell.productImageView.sd_showActivityIndicatorView()
            cell.productImageView.sd_setImage(with: URL(string: self.products[indexPath.row].imageUrl), completed: nil)
            cell.productImageView.contentMode = .scaleAspectFill
            
            cell.tag = self.products[indexPath.row].id
            
        }

        return cell
    }
}
