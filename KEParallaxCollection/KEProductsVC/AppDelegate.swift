//
//  AppDelegate.swift
//  KEStoryLikeCollection
//
//  Created by Kaan Esin on 26.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, KEParallaxCollectionViewControllerDelegate, ProductsListVCDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "KEParallaxCollectionViewController") as? KEParallaxCollectionViewController {
            vc.delegate = self
            vc.itemArray = [(color: UIColor.lightGray, title: "1 sdfasdf", price: 400.0, discountedPrice: 200.0),
                            (color: UIColor.yellow, title: "2 asdklfj asdfjk", price: 1400.0, discountedPrice: 1200.0),
                            (color: UIColor.green, title: "3 a23r", price: 43000.0, discountedPrice: 42000.0),
                            (color: UIColor.darkGray, title: "4 askdlfjlkajsdflkj", price: 123.5, discountedPrice: nil),
                            (color: UIColor.black, title: "5 sdfj", price: 1499.99, discountedPrice: 1299.99),
                            (color: UIColor.orange, title: "6 aşosdfkjv pwdfı", price: 22.0, discountedPrice: 20.0),
                            (color: UIColor.magenta, title: "7 dsnvm", price: 213.0, discountedPrice: 200.0),
                            (color: UIColor.purple, title: "8 230r9fjv sodfpoısdpfsdf", price: 1.0, discountedPrice: nil),
                            (color: UIColor.blue, title: "9 sakdf", price: 23.99, discountedPrice: 20.0),
                            (color: UIColor.cyan, title: "10 sdfasdf sdfasdf", price: 19999.99, discountedPrice: 17999.99)]
            window?.rootViewController = UINavigationController(rootViewController: vc)
        }
        window?.makeKeyAndVisible()
        return true
    }

    func cellDidSelect(item: (color: UIColor, title: String, price: CGFloat, discountedPrice: CGFloat?), indexPath: IndexPath, cell: KEParallaxCell?) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailVC") as? ProductDetailVC {
            if let navc = window?.rootViewController as? UINavigationController {
                vc.loadView()
                vc.imgView.backgroundColor = item.color

                let imgView = UIImageView(image: cell?.imgCell.image)
                imgView.backgroundColor = item.color
                let rect = UIApplication.shared.delegate?.window!!.convert(cell!.imgCell.frame, from: cell?.contentView)
//                let rect = cell?.contentView.convert(cell!.imgCell.frame, to: UIApplication.shared.delegate?.window!)
                imgView.frame = rect!
                imgView.layer.cornerRadius = 20.0
                imgView.layer.masksToBounds = true
                UIApplication.shared.delegate?.window??.addSubview(imgView)
                
                UIView.animate(withDuration: 0.25, delay: 0, options: [.allowAnimatedContent, .allowUserInteraction], animations: {
                    imgView.frame = vc.imgView.frame
                }, completion: nil)

                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                navc.present(vc, animated: true) {
                    imgView.removeFromSuperview()
                }
            }
        }
    }
    
    func allClicked() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsListVC") as? ProductsListVC {
            if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
                vc.modalPresentationStyle = .overFullScreen
                vc.delegate = self
                vc.itemArray = [(title: "1 sdfasdf", price: 400.0, discountedPrice: 200.0, discountValue: 10, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRapSCeQqGfdGp8mFQR41el68BzzsA9qGi9PViWIYRj24Dmiu4J", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQcj--O4oT-rAdJHPRpqCso5FylV5lw1-DCdmbJvsR2zeTJp7pa"]),
                                (title: "2 sdfasdf", price: 300.0, discountedPrice: nil, discountValue: nil, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"]),
                                (title: "3 sdfasdf", price: 19999.99, discountedPrice: 10000.0, discountValue: 30, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"]),
                                (title: "4 sdfasdf", price: 40.0, discountedPrice: 20.0, discountValue: 99, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRapSCeQqGfdGp8mFQR41el68BzzsA9qGi9PViWIYRj24Dmiu4J"]),
                                (title: "5 sdfasdf", price: 4000.0, discountedPrice: 2000.0, discountValue: 10, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRapSCeQqGfdGp8mFQR41el68BzzsA9qGi9PViWIYRj24Dmiu4J", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQcj--O4oT-rAdJHPRpqCso5FylV5lw1-DCdmbJvsR2zeTJp7pa"]),
                                (title: "6 sdfasdf", price: 400.0, discountedPrice: nil, discountValue: nil, images: nil)]
                navc.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func orderScreen() {
        if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
            let alert = UIAlertController(title: "Order clicked", message: "", preferredStyle: .alert)
            navc.present(alert, animated: true, completion: nil)
        }
    }
    
    func filterScreen() {
        if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
            let alert = UIAlertController(title: "Filter clicked", message: "", preferredStyle: .alert)
            navc.present(alert, animated: true, completion: nil)
        }
    }
}

