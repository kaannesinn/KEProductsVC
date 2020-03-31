//
//  ProductSalerCell.swift
//  KEProductsVC
//
//  Created by Kaan Esin on 31.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

protocol ProductSalerCellDelegate: NSObject {
    func salerScreen(sender: UIButton, cell: ProductSalerCell)
    func cargoFreeScreen(sender: UIButton, cell: ProductSalerCell)
}

class ProductSalerCell: UITableViewCell {

    @IBOutlet weak var lblSalerName: UILabel!
    @IBOutlet weak var btnSaler: UIButton!
    @IBOutlet weak var lblSalerRate: UILabel!
    @IBOutlet weak var btnCargoFree: UIButton!
    var delegate: ProductSalerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func salerClicked(_ sender: UIButton) {
        delegate?.salerScreen(sender: sender, cell: self)
    }
    
    @IBAction func cargoFreeClicked(_ sender: UIButton) {
        delegate?.salerScreen(sender: sender, cell: self)
    }
    
}
