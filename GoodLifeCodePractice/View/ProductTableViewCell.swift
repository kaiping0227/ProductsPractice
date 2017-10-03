//
//  ProductTableViewCell.swift
//  GoodLifeCodePractice
//
//  Created by Francis Tseng on 2017/9/29.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var productStoreNameLabel: UILabel!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productSalesCount: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
