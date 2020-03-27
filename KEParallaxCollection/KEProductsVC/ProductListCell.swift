//
//  ProductListCell.swift
//  KEProductsVC
//
//  Created by Kaan Esin on 27.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

protocol ProductListCellDelegate: NSObject {
    func basketScreen()
}

class ProductListCell: UICollectionViewCell {
    @IBOutlet weak var viewEmbedScroll: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDiscountedPrice: UILabel!
    @IBOutlet weak var lblDiscountValue: UILabel!
    @IBOutlet weak var btnBasket: UIButton!
    var delegate: ProductListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func basketClicked(_ sender: Any) {
        delegate?.basketScreen()
    }
    
}
