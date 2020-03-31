//
//  ProductDetailInfoCell.swift
//  KEProductsVC
//
//  Created by Kaan Esin on 31.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

protocol ProductDetailInfoCellDelegate: NSObject {
    func shareScreen(sender: UIButton, cell: ProductDetailInfoCell)
    func favoriteScreen(sender: UIButton, cell: ProductDetailInfoCell)
}

class ProductDetailInfoCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var lblCommentsCount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDiscountedPrice: UILabel!
    @IBOutlet weak var lblDiscountValue: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    var delegate: ProductDetailInfoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func shareClicked(_ sender: UIButton) {
        delegate?.shareScreen(sender: sender, cell: self)
    }
    
    @IBAction func favoriteClicked(_ sender: UIButton) {
        delegate?.favoriteScreen(sender: sender, cell: self)
    }
    
}
