//
//  ProductAddBasketView.swift
//  KEProductsVC
//
//  Created by Kaan Esin on 31.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

protocol ProductAddBasketViewDelegate: NSObject {
    func addBasketScreen(sender: UIButton, stepper: KEStepperView)
}

class ProductAddBasketView: UIView {

    @IBOutlet weak var stepperView: KEStepperView!
    @IBOutlet weak var btnAddBasket: UIButton!
    var delegate: ProductAddBasketViewDelegate?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addBasketClicked(_ sender: UIButton) {
        if stepperView.itemCount > 0 {
            delegate?.addBasketScreen(sender: sender, stepper: stepperView)
        }
    }
    
}
