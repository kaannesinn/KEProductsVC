//
//  ViewController.swift
//  KEParallaxCollection
//
//  Created by Kaan Esin on 26.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

enum CellType: NSInteger {
    case ProductDetailImageViewCell
    case ProductDetailInfoCell
    case ProductSalerCell
    case ProductColorsCell
    case ProductDirectionCell_Product_Features
    case ProductDirectionCell_Product_Comments
    case ProductDirectionCell_Product_Tax_Options
}

class ProductDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ProductDetailInfoCellDelegate, ProductSalerCellDelegate, ProductDirectionCellDelegate {

    @IBOutlet weak var btnClose: UIButton!
    var listArray: [[String: Any]]? = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewForBasket: ProductAddBasketView!
    var images: [String]? = []
    var cell: KEParallaxCell?
    var item: (title: String, price: CGFloat, discountedPrice: CGFloat?, discountValue: CGFloat?, images: [String]?, canBeAddedToBasket: Bool)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scrollViewForImages = Bundle.main.loadNibNamed("ProductImagesScrollView", owner: self, options: [:])?.first as? ProductImagesScrollView {
            scrollViewForImages.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: self.tableView.bounds.height)
            scrollViewForImages.images = images
            
            for (i, image) in (images ?? []).enumerated() {
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
            scrollViewForImages.scrollForImages.contentSize = CGSize(width: CGFloat(images?.count ?? 0) * scrollViewForImages.bounds.width, height: scrollViewForImages.bounds.height)
        }
        
        listArray?.append(["cell": CellType.ProductDetailImageViewCell])
        listArray?.append(["cell": CellType.ProductDetailInfoCell])
        listArray?.append(["cell": CellType.ProductSalerCell])
        listArray?.append(["cell": CellType.ProductColorsCell])
        listArray?.append(["cell": CellType.ProductDirectionCell_Product_Features])
        listArray?.append(["cell": CellType.ProductDirectionCell_Product_Comments])
        listArray?.append(["cell": CellType.ProductDirectionCell_Product_Tax_Options])
        tableView.reloadData()
    }
    
    @objc func scrollTapped(sender: UITapGestureRecognizer) {
        //        print(sender.view)
        //        print(sender.view?.tag)
        //        print(sender.view?.superview?.superview?.superview?.superview?.superview)
        //        print(sender.view?.superview?.superview?.superview?.superview?.superview?.tag)
        
        if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController,
            let imgTag = sender.view?.tag {
            if let preview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewImageVC") as? PreviewImageVC {
                if let scrollViewForImages = Bundle.main.loadNibNamed("ProductImagesScrollView", owner: self, options: [:])?.first as? ProductImagesScrollView {
                    scrollViewForImages.frame = CGRect(x: 0, y: 30, width: preview.view.bounds.width, height: preview.view.bounds.height-30)
                    scrollViewForImages.images = self.images
                    
                    for (i, image) in (self.images ?? []).enumerated() {
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
                    scrollViewForImages.scrollForImages.contentSize = CGSize(width: CGFloat(self.images?.count ?? 0) * scrollViewForImages.bounds.width, height: scrollViewForImages.bounds.height - 30)
                    preview.view.addSubview(scrollViewForImages)
                    scrollViewForImages.scrollForImages.contentOffset = CGPoint(x: CGFloat(imgTag) * scrollViewForImages.bounds.width, y: scrollViewForImages.scrollForImages.contentOffset.y)
                    navc.presentedViewController?.present(preview, animated: true)
                }
            }
        }
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case CellType.ProductDetailImageViewCell.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailImageViewCell") as! ProductDetailImageViewCell

            if let images = images {
                if let scrollViewForImages = Bundle.main.loadNibNamed("ProductImagesScrollView", owner: self, options: [:])?.first as? ProductImagesScrollView {
                    if cell.imagesView.tag == 0 {
                        scrollViewForImages.frame = CGRect(x: 0, y: 0, width: cell.imagesView.bounds.width, height: cell.imagesView.bounds.height)
                        scrollViewForImages.images = images
                        
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
                        cell.imagesView.addSubview(scrollViewForImages)
                        cell.imagesView.tag = 1
                    }
                }
            }
            
            return cell
        case CellType.ProductDetailInfoCell.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailInfoCell") as! ProductDetailInfoCell
            cell.lblTitle.text = item.title
            cell.lblTitle.textColor = .black
            cell.lblDiscountedPrice.font = UIFont(name: "HelveticaNeue-Bold", size: 19.0)
            cell.lblDiscountValue.font = UIFont(name: "HelveticaNeue-Light", size: 10.0)
            cell.lblPrice.font = UIFont(name: "HelveticaNeue", size: 14.0)
            cell.lblDiscountedPrice.isHidden = true
            cell.lblDiscountValue.isHidden = true
            if let disPrice = item.discountedPrice, let disValue = item.discountValue {
                cell.lblDiscountedPrice.isHidden = false
                cell.lblDiscountedPrice.attributedText = NSAttributedString(string: "\(disPrice) ₺", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                cell.lblPrice.attributedText = NSAttributedString(string: "\(item.price) ₺", attributes: [.strikethroughColor: UIColor.red, .strikethroughStyle: 3.0, .foregroundColor: UIColor.black])
                cell.lblDiscountValue.isHidden = false
                cell.lblDiscountValue.attributedText = NSAttributedString(string: "% \(disValue)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            }
            else {
                cell.lblPrice.font = UIFont(name: "HelveticaNeue-Bold", size: 19.0)
                cell.lblPrice.attributedText = NSAttributedString(string: "\(item.price) ₺", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
            cell.lblCommentsCount.text = "Yorum (\(1002))"
            cell.delegate = self
            return cell
        case CellType.ProductSalerCell.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSalerCell") as! ProductSalerCell
            cell.lblSalerName.text = "Satıcı"
            cell.btnSaler.setTitle("Batan Gemi", for: .normal)
            cell.btnCargoFree.setTitle("Kargo Bedava", for: .normal)
            cell.lblSalerRate.text = "\(9.7)"
            cell.lblSalerRate.textColor = .green
            cell.lblSalerRate.layer.borderColor = UIColor.green.cgColor
            cell.lblSalerRate.layer.borderWidth = 1.0
            cell.lblSalerRate.layer.cornerRadius = 5.0
            cell.lblSalerRate.layer.masksToBounds = true
            cell.btnCargoFree.layer.borderColor = UIColor.gray.cgColor
            cell.btnCargoFree.layer.borderWidth = 1.0
            cell.btnCargoFree.layer.cornerRadius = 5.0
            cell.btnCargoFree.layer.masksToBounds = true
            cell.delegate = self
            return cell
        case CellType.ProductColorsCell.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductColorsCell") as! ProductColorsCell
            cell.lblColor.text = "Renk Seç"
            return cell
        case CellType.ProductDirectionCell_Product_Features.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDirectionCell_Product_Features") as! ProductDirectionCell
            cell.btnDirect.setTitle("Ürün Özellikleri", for: .normal)
            cell.btnDirect.layer.cornerRadius = 5.0
            cell.btnDirect.layer.masksToBounds = true
            cell.delegate = self
            return cell
        case CellType.ProductDirectionCell_Product_Comments.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDirectionCell_Product_Comments") as! ProductDirectionCell
            cell.btnDirect.setTitle("Yorumlar", for: .normal)
            cell.btnDirect.layer.cornerRadius = 5.0
            cell.btnDirect.layer.masksToBounds = true
            cell.delegate = self
            return cell
        case CellType.ProductDirectionCell_Product_Tax_Options.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDirectionCell_Product_Tax_Options") as! ProductDirectionCell
            cell.btnDirect.setTitle("Ürün Taksit Seçenekleri", for: .normal)
            cell.btnDirect.layer.cornerRadius = 5.0
            cell.btnDirect.layer.masksToBounds = true
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            return cell
        }
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case CellType.ProductDetailImageViewCell.rawValue:
            return 363.0
        case CellType.ProductDetailInfoCell.rawValue:
            return 164.0
        case CellType.ProductSalerCell.rawValue:
            return 89.0
        case CellType.ProductColorsCell.rawValue:
            return 113.0
        case CellType.ProductDirectionCell_Product_Features.rawValue:
            return 79.0
        case CellType.ProductDirectionCell_Product_Comments.rawValue:
            return 79.0
        case CellType.ProductDirectionCell_Product_Tax_Options.rawValue:
            return 79.0
        default:
            return 0.0
        }
    }
    
    func shareScreen(sender: UIButton, cell: ProductDetailInfoCell) {
        if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
            let alert = UIAlertController(title: "share clicked", message: "", preferredStyle: .alert)
            navc.presentedViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func favoriteScreen(sender: UIButton, cell: ProductDetailInfoCell) {
        if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
            let alert = UIAlertController(title: "favorite clicked", message: "", preferredStyle: .alert)
            navc.presentedViewController?.present(alert, animated: true, completion: nil)
        }
        
        cell.btnFavorite.backgroundColor = sender.tag == 0 ? .green : .red
        cell.btnFavorite.tag = sender.tag == 0 ? 1 : 0
    }
    
    func salerScreen(sender: UIButton, cell: ProductSalerCell) {
        if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
            let alert = UIAlertController(title: "saler clicked", message: "", preferredStyle: .alert)
            navc.presentedViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func cargoFreeScreen(sender: UIButton, cell: ProductSalerCell) {
        if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
            let alert = UIAlertController(title: "cargo free clicked", message: "", preferredStyle: .alert)
            navc.presentedViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func directionScreen(sender: UIButton, cell: ProductDirectionCell) {
        let strAlert = cell.btnDirect.title(for: .normal)
        
        if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
            let alert = UIAlertController(title: strAlert, message: "", preferredStyle: .alert)
            navc.presentedViewController?.present(alert, animated: true, completion: nil)
        }
    }
}

