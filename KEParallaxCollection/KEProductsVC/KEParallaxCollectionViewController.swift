//
//  ViewController.swift
//  KEStoryLikeCollection
//
//  Created by Kaan Esin on 24.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

protocol KEParallaxCollectionViewControllerDelegate: NSObject {
    func cellDidSelect(item: (color: UIColor, title: String, price: CGFloat, discountedPrice: CGFloat?), indexPath: IndexPath, cell: KEParallaxCell?)
    func allClicked()
}

class KEParallaxCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, KEParallaxCellDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var itemArray: [(color: UIColor, title: String, price: CGFloat, discountedPrice: CGFloat?)]?
    var insetValue: CGFloat = 0.0
    var cellWidth: CGFloat = 370.0
    var cellHeight: CGFloat = 240.0
    var minimumLineSpacing: CGFloat = 5.0
    var minimumInteritemSpacing: CGFloat = 5.0
    var isImageRoundedOnCell: Bool = true
    var cornerRadiusForImageOnCell: CGFloat = 20.0
    var backgroundColor: UIColor = .lightGray
    var scrollDirection: UICollectionView.ScrollDirection = .horizontal
    var delegate: KEParallaxCollectionViewControllerDelegate?
    @IBOutlet weak var lblCategoryTitle: UILabel!
    @IBOutlet weak var btnAll: UIButton!
    let flowLayout = UICollectionViewFlowLayout()
    var offsetScroll1 : CGFloat = 0
    var offsetScroll2 : CGFloat = 0
    var isPagingEnabled: Bool = true

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
        
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if isPagingEnabled {
            offsetScroll1 = offsetScroll2
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isPagingEnabled {
            offsetScroll1 = offsetScroll2
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        if isPagingEnabled {
            let indexOfMajorCell = self.desiredIndex()
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            flowLayout.collectionView!.scrollToItem(at: indexPath, at: .left, animated: true)
            targetContentOffset.pointee = scrollView.contentOffset
        }
    }

    private func desiredIndex() -> Int {
        var integerIndex = 0
        print(flowLayout.collectionView!.contentOffset.x)
        offsetScroll2 = flowLayout.collectionView!.contentOffset.x
        if offsetScroll2 > offsetScroll1 {
            integerIndex += 1
            let offset = flowLayout.collectionView!.contentOffset.x / UIScreen.main.bounds.width
            integerIndex = Int(round(offset))
            if integerIndex < ((itemArray?.count ?? 0) - 1) {
                integerIndex += 1
            }
        }
        if offsetScroll2 < offsetScroll1 {
            let offset = flowLayout.collectionView!.contentOffset.x / UIScreen.main.bounds.width
            integerIndex = Int(offset.rounded(.towardZero))
        }
        let targetIndex = integerIndex
        return targetIndex
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KEParallaxCell", for: indexPath) as! KEParallaxCell
        cell.backgroundColor = .gray
        if let item = itemArray?[indexPath.row] {
            cell.lblTitle.text = item.title
            cell.lblTitle.textColor = .white
            cell.lblDiscountedPrice.font = UIFont(name: "HelveticaNeue-Bold", size: 19.0)
            cell.lblPrice.font = UIFont(name: "HelveticaNeue", size: 14.0)
            cell.lblDiscountedPrice.isHidden = true
            if let disPrice = item.discountedPrice {
                cell.lblDiscountedPrice.isHidden = false
                cell.lblDiscountedPrice.attributedText = NSAttributedString(string: "\(disPrice) ₺", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                cell.lblPrice.attributedText = NSAttributedString(string: "\(item.price) ₺", attributes: [.strikethroughColor: UIColor.red, .strikethroughStyle: 3.0, .foregroundColor: UIColor.white])
            }
            else {
                cell.lblPrice.font = UIFont(name: "HelveticaNeue-Bold", size: 19.0)
                cell.lblPrice.attributedText = NSAttributedString(string: "\(item.price) ₺", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
            cell.imgCell.backgroundColor = item.color
            cell.updateCellImage(isImageRounded: isImageRoundedOnCell, cornerRadius: cornerRadiusForImageOnCell)
            cell.delegate = self
            cell.tag = indexPath.row
            cell.btnOnCell.tag = indexPath.row
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = itemArray?[indexPath.row] {
            delegate?.cellDidSelect(item: item, indexPath: indexPath, cell: nil)
        }
    }
    
    func btnSelected(sender: UIButton, cell: KEParallaxCell) {
        if let item = itemArray?[sender.tag] {
            delegate?.cellDidSelect(item: item, indexPath: IndexPath(row: sender.tag, section: 0), cell: cell)
        }
    }
    
    @IBAction func btnAllClicked(_ sender: Any) {
        delegate?.allClicked()
    }
}
