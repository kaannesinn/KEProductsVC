//
//  ProductListReusableView.swift
//  KEProductsVC
//
//  Created by Kaan Esin on 30.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

protocol ProductListReusableViewDelegate: NSObject {
    func orderScreen()
    func filterScreen()
}

class ProductListReusableView: UICollectionReusableView {
    
    var delegate: ProductListReusableViewDelegate?
    @IBOutlet weak var btnOrder: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    
    @IBAction func orderClicked(_ sender: Any) {
        delegate?.orderScreen()
    }
    
    @IBAction func filterClicked(_ sender: Any) {
        delegate?.filterScreen()
    }
    
}
