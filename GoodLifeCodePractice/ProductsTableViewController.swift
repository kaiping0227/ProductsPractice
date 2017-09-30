//
//  ProductsTableViewController.swift
//  GoodLifeCodePractice
//
//  Created by Francis Tseng on 2017/9/29.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import UIKit

let reuseIdentifier = "ProductTableViewCell"

class ProductsTableViewController: UITableViewController, ProductsDelegate {

    var recievedProducts = [Product]()
    
    let fetchManager = FetchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchManager.getProductsList()
        
        fetchManager.delegateProducts = self
        
    }

    func didGet(_ products: [Product]) {
        recievedProducts = products
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recievedProducts.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductTableViewCell

        cell.productTitleLabel.text = recievedProducts[indexPath.row].title
        
        cell.productPriceLabel.text = recievedProducts[indexPath.row].price.description
        
        cell.productSalesCount.text = recievedProducts[indexPath.row].salesCount.description
        

        return cell
    }

}
