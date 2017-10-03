//
//  ProductsTableViewController.swift
//  GoodLifeCodePractice
//
//  Created by Francis Tseng on 2017/9/29.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import UIKit
import SDWebImage
import UIScrollView_InfiniteScroll

let reuseIdentifier = "ProductTableViewCell"

class ProductsTableViewController: UITableViewController, ProductsDelegate {

    var products = [Product]() {
        didSet {
//            DispatchQueue.main.async {
                self.tableView.reloadData()
//            }
        }
    }
    
    var page: Int = 1
    
    let fetchManager = FetchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        fetchManager.getProductsList(page: self.page)
        
        fetchManager.delegateProducts = self
        
        tableView.addInfiniteScroll { (tableView) in
            
//            tableView.performBatchUpdates({
            
//                self.page = 1
            
                self.fetchManager.getProductsList(page: self.page)
                
//            }, completion: { (finished) in
            
//                tableView.finishInfiniteScroll()
//            })
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        products = []
        
        fetchManager.getProductsList(page: self.page)
        
    }
    
    @IBAction func favoritesButtonPressed(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let favoriteViewController = storyBoard.instantiateViewController(withIdentifier: "FavoriteNaviTableViewController")
        
        present(favoriteViewController, animated: true, completion: nil)
    }
    
    func didGet(_ products: [Product]) {
        print("did get products")
        
        DispatchQueue.main.async {
            self.tableView.finishInfiniteScroll()
            
            
            
            
            self.page += 1
            
            self.products += products
            
        }
    }
    
    @IBAction func signoutButtonPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Sign Out", message: "Sure?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            
            UserDefaults.standard.removeObject(forKey: "accessToken")
            
            let landingStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            
            let landingViewController = landingStoryBoard.instantiateViewController(withIdentifier: "LoginViewController")
            
            DispatchQueue.main.async {
                AppDelegate.shared.window?.rootViewController = landingViewController
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductTableViewCell

        DispatchQueue.main.async {

            cell.productTitleLabel.text = self.products[indexPath.row].title
            
            cell.productPriceLabel.text = "$ " + self.products[indexPath.row].price.description
            
            cell.productStoreNameLabel.text = self.products[indexPath.row].storeName
            
            cell.productSalesCount.text = "Sold " + self.products[indexPath.row].salesCount.description
            
            cell.productImageView.sd_setImage(with: URL(string: self.products[indexPath.row].imageUrl), completed: nil)
            cell.productImageView.contentMode = .scaleAspectFill
            
            cell.tag = self.products[indexPath.row].id
            
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toDetailSegue":
            
            let cell = sender as! ProductTableViewCell
            
            let productID = cell.tag
            
            let productDetailViewController = segue.destination as! ProductDetailViewController
            
            productDetailViewController.productID = productID
            
            productDetailViewController.productStatus = .normal
            
        default:
            break
        }
    }
    
    @objc func addToFavoriteList(sender: UIButton) {
        
        guard let image = sender.imageView?.image else { return }
        
        switch image {
            
        case #imageLiteral(resourceName: "ic_favorite_border_48pt"):
            
            sender.setImage(#imageLiteral(resourceName: "ic_favorite_48pt"), for: .normal)
            
            fetchManager.addToFavoriteList(self.products[sender.tag].id)
            
        case #imageLiteral(resourceName: "ic_favorite_48pt"):
            
            sender.setImage(#imageLiteral(resourceName: "ic_favorite_border_48pt"), for: .normal)
            
            fetchManager.deleteFromFavoriteList(self.products[sender.tag].id)
            
        default:
            break
        }
  
    }
}
