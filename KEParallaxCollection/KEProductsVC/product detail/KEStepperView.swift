//
//  KEStepperView.swift
//  KEProductsVC
//
//  Created by Kaan Esin on 30.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

class KEStepperView: UIView {

    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnCount: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    var contentView: UIView?
    var itemCount: Int = 0
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5.0
        view.layer.masksToBounds = true
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "KEStepperView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
        
//        return Bundle.main.loadNibNamed("KEStepperView", owner: self, options: nil)?.first as? UIView
    }
    
    @IBAction func minusClicked(_ sender: UIButton) {
        if itemCount > 0 {
            itemCount -= 1
            btnCount.setTitle("\(itemCount) Adet", for: .normal)
        }
        
        if itemCount == 0 {
            if let addBasketView = superview?.superview as? ProductAddBasketView {
                addBasketView.btnAddBasket.isEnabled = false
            }
        }
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        itemCount += 1
        btnCount.setTitle("\(itemCount) Adet", for: .normal)
        
        if let addBasketView = superview?.superview as? ProductAddBasketView {
            addBasketView.btnAddBasket.isEnabled = true
        }
    }
    
    @IBAction func countClicked(_ sender: UIButton) {
    }

}
