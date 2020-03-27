//
//  KEParallaxCell.swift
//  KEStoryLikeCollection
//
//  Created by Kaan Esin on 25.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

protocol KEParallaxCellDelegate: NSObject {
    func btnSelected(sender: UIButton, cell: KEParallaxCell)
}

class KEParallaxCell: UICollectionViewCell {
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDiscountedPrice: UILabel!
    @IBOutlet weak var btnOnCell: UIButton!
    var delegate: KEParallaxCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCellImage(isImageRounded: Bool = true, cornerRadius: CGFloat = 20.0) {
        if isImageRounded {
            imgCell.layer.cornerRadius = cornerRadius
            imgCell.layer.masksToBounds = true
        }
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.allowAnimatedContent, .allowUserInteraction], animations: {
            self.contentView.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }, completion: { (finished) in
            if finished {
                UIView.animate(withDuration: 0.1, delay: 0.1, options: [.allowAnimatedContent, .allowUserInteraction], animations: {
                    self.contentView.transform = CGAffineTransform.identity
                }, completion: { (finished) in
                    if finished {
                        self.delegate?.btnSelected(sender: sender, cell: self)
                    }
                })
            }
        })
    }
    
    @IBAction func btnTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.allowAnimatedContent, .allowUserInteraction], animations: {
            self.contentView.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.allowAnimatedContent, .allowUserInteraction], animations: {
            self.contentView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
