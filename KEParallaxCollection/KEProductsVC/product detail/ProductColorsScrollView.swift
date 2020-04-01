//
//  ProductColorsScrollView.swift
//  KEProductsVC
//
//  Created by Kaan Esin on 31.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

class ProductColorsScrollView: UIView {

    @IBOutlet weak var scrollForColors: UIScrollView!
    var colors: [[String: Any]]?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
