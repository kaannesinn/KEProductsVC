//
//  ProductsListVC.swift
//  KEProductsVC
//
//  Created by Kaan Esin on 27.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

protocol ProductsListVCDelegate: NSObject {
    func orderScreen()
    func filterScreen()
}

class ProductsListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ProductListCellDelegate {

    var itemArray: [(title: String, price: CGFloat, discountedPrice: CGFloat?, discountValue: CGFloat?, images: [String]?)]?
    var insetValue: CGFloat = 5.0
    var cellWidth: CGFloat = 199.0
    var cellHeight: CGFloat = 315.0
    var minimumLineSpacing: CGFloat = 5.0
    var minimumInteritemSpacing: CGFloat = 5.0
    var cornerRadiusForCell: CGFloat = 20.0
    var backgroundColor: UIColor = .lightGray
    var scrollDirection: UICollectionView.ScrollDirection = .vertical
    let flowLayout = UICollectionViewFlowLayout()

    var delegate: ProductsListVCDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        flowLayout.scrollDirection = scrollDirection
        flowLayout.minimumLineSpacing = minimumLineSpacing
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: insetValue, left: insetValue, bottom: insetValue, right: insetValue)
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.backgroundColor = backgroundColor
    }
    
    @IBAction func orderClicked(_ sender: Any) {
        delegate?.orderScreen()
    }
    
    @IBAction func filterClicked(_ sender: Any) {
        delegate?.filterScreen()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
    func basketScreen() {
        if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
            let alert = UIAlertController(title: "basket clicked", message: "", preferredStyle: .alert)
            navc.present(alert, animated: true, completion: nil)
        }
    }
}
