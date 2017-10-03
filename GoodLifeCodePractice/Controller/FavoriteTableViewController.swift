//
//  FavoriteTableViewController.swift
//  GoodLifeCodePractice
//
//  Created by Francis Tseng on 2017/9/30.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import UIKit
import SDWebImage
import UIScrollView_InfiniteScroll

class FavoriteTableViewController: UITableViewController, ProductsDelegate {

    let fetchManager = FetchManager()
    
    var page: Int = 1
    
    var products = [Product]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchManager.delegateProducts = self
        
        tableView.addInfiniteScroll { (tableView) in
            tableView.performBatchUpdates({
                
                self.page += 1
                
                self.fetchManager.getFavoriteList(page: self.page)
                
            }, completion: { (finished) in
                
                tableView.finishInfiniteScroll()
            })
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        products = []
        
        fetchManager.getFavoriteList(page: self.page)
        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
    }
    
    func didGet(_ products: [Product]) {
        self.products += products

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toDetail":
            
            let cell = sender as! FavoriteTableViewCell
            
            let productID = cell.tag
            
            let productDetailViewController = segue.destination as! ProductDetailViewController
            
            productDetailViewController.productID = productID
            
            productDetailViewController.productStatus = .favorite
            
        default:
            break
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
            
            cell.productPriceLabel.text = "$ " + self.products[indexPath.row].price.description
            
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
