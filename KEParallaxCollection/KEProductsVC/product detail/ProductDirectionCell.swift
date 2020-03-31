//
//  ProductDirectionCell.swift
//  KEProductsVC
//
//  Created by Kaan Esin on 31.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

protocol ProductDirectionCellDelegate: NSObject {
    func directionScreen(sender: UIButton, cell: ProductDirectionCell)
}

class ProductDirectionCell: UITableViewCell {

    @IBOutlet weak var btnDirect: UIButton!
    var delegate: ProductDirectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func directionClicked(_ sender: UIButton) {
        delegate?.directionScreen(sender: sender, cell: self)
    }
    
}
