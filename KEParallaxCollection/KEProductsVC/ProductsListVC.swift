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

class ProductsListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ProductListCellDelegate, UICollectionViewDelegateFlowLayout {

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
    var headerWidth: CGFloat = 50.0
    var headerHeight: CGFloat = 60.0
       
    var delegate: ProductsListVCDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flowLayout.headerReferenceSize = CGSize(width: headerWidth, height: headerHeight)
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
        if let item = itemArray?[indexPath.row] {
            cell.lblTitle.text = item.title
            cell.lblTitle.textColor = .white
            cell.lblDiscountedPrice.font = UIFont(name: "HelveticaNeue-Bold", size: 19.0)
            cell.lblDiscountValue.font = UIFont(name: "HelveticaNeue-Light", size: 10.0)
            cell.lblPrice.font = UIFont(name: "HelveticaNeue", size: 14.0)
            cell.lblDiscountedPrice.isHidden = true
            cell.lblDiscountValue.isHidden = true
            if let disPrice = item.discountedPrice, let disValue = item.discountValue {
                cell.lblDiscountedPrice.isHidden = false
                cell.lblDiscountedPrice.attributedText = NSAttributedString(string: "\(disPrice) ₺", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                cell.lblPrice.attributedText = NSAttributedString(string: "\(item.price) ₺", attributes: [.strikethroughColor: UIColor.red, .strikethroughStyle: 3.0, .foregroundColor: UIColor.white])
                cell.lblDiscountValue.isHidden = false
                cell.lblDiscountValue.attributedText = NSAttributedString(string: "% \(disValue)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            }
            else {
                cell.lblPrice.font = UIFont(name: "HelveticaNeue-Bold", size: 19.0)
                cell.lblPrice.attributedText = NSAttributedString(string: "\(item.price) ₺", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
            if let images = item.images {
                if let scrollViewForImages = Bundle.main.loadNibNamed("ProductImagesScrollView", owner: self, options: [:])?.first as? ProductImagesScrollView {
                    if cell.viewEmbedScroll.tag == 0 {
                        scrollViewForImages.frame = CGRect(x: 0, y: 0, width: cell.viewEmbedScroll.bounds.width, height: cell.viewEmbedScroll.bounds.height)
                        
                        for (i, image) in images.enumerated() {
                            DispatchQueue.global().async {
                                if let url = URL(string: image), let data = try? Data(contentsOf: url) {
                                    DispatchQueue.main.async {
                                        if let img = UIImage(data: data) {
                                            let imgView = UIImageView(image: img)
                                            imgView.contentMode = .scaleAspectFit
                                            imgView.isUserInteractionEnabled = true
                                            imgView.tag = i
                                            imgView.frame = CGRect(x: CGFloat(i) * scrollViewForImages.bounds.width, y: 0, width: scrollViewForImages.bounds.width, height: scrollViewForImages.bounds.height)
                                            scrollViewForImages.scrollForImages.addSubview(imgView)
                                            
                                            let tap = UITapGestureRecognizer(target: self, action: #selector(self.scrollTapped(sender:)))
                                            imgView.addGestureRecognizer(tap)
                                        }
                                    }
                                }
                            }
                        }
                        scrollViewForImages.scrollForImages.contentSize = CGSize(width: CGFloat(images.count) * scrollViewForImages.bounds.width, height: scrollViewForImages.bounds.height)
                        cell.viewEmbedScroll.addSubview(scrollViewForImages)
                        cell.viewEmbedScroll.tag = 1
                    }
                }
            }
            cell.delegate = self
            cell.tag = indexPath.row
        }
        return cell
    }
    
    @objc func scrollTapped(sender: UITapGestureRecognizer) {
//        print(sender.view)
//        print(sender.view?.tag)
//        print(sender.view?.superview?.superview?.superview?.superview?.superview)
//        print(sender.view?.superview?.superview?.superview?.superview?.superview?.tag)
        
        if let imgTag = sender.view?.tag,
            let cellTag = sender.view?.superview?.superview?.superview?.superview?.superview?.tag,
            let item = itemArray?[cellTag] {
            if let preview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewImageVC") as? PreviewImageVC {
                if let scrollViewForImages = Bundle.main.loadNibNamed("ProductImagesScrollView", owner: self, options: [:])?.first as? ProductImagesScrollView {
                    scrollViewForImages.frame = CGRect(x: 0, y: 30, width: preview.view.bounds.width, height: preview.view.bounds.height-30)
                    
                    for (i, image) in (item.images ?? []).enumerated() {
                        DispatchQueue.global().async {
                            if let url = URL(string: image), let data = try? Data(contentsOf: url) {
                                DispatchQueue.main.async {
                                    if let img = UIImage(data: data) {
                                        let imgView = UIImageView(image: img)
                                        imgView.contentMode = .scaleAspectFit
                                        imgView.isUserInteractionEnabled = true
                                        imgView.tag = i
                                        imgView.frame = CGRect(x: CGFloat(i) * scrollViewForImages.bounds.width, y: 0, width: scrollViewForImages.bounds.width, height: scrollViewForImages.bounds.height)
                                        scrollViewForImages.scrollForImages.addSubview(imgView)
                                    }
                                }
                            }
                        }
                    }
                    scrollViewForImages.scrollForImages.contentSize = CGSize(width: CGFloat(item.images?.count ?? 0) * scrollViewForImages.bounds.width, height: scrollViewForImages.bounds.height)
                    preview.view.addSubview(scrollViewForImages)
                    scrollViewForImages.scrollForImages.contentOffset = CGPoint(x: CGFloat(imgTag) * scrollViewForImages.bounds.width, y: scrollViewForImages.scrollForImages.contentOffset.y)
                    present(preview, animated: true, completion: nil)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: headerWidth, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProductListReusableView", for: indexPath) as! ProductListReusableView
        return header
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func basketScreen() {
        if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
            let alert = UIAlertController(title: "basket clicked", message: "", preferredStyle: .alert)
            navc.present(alert, animated: true, completion: nil)
        }
    }
}
