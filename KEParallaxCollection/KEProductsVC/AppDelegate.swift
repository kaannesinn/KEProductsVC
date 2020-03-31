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
    var images: [String]?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "KEParallaxCollectionViewController") as? KEParallaxCollectionViewController {
            vc.delegate = self
            vc.itemArray = [(title: "1 sdfasdf", price: 400.0, discountedPrice: 200.0, discountValue: nil, images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRapSCeQqGfdGp8mFQR41el68BzzsA9qGi9PViWIYRj24Dmiu4J", "https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"], canBeAddedToBasket: true),
                            (title: "2 asdklfj asdfjk", price: 1400.0, discountedPrice: 1200.0, discountValue: nil, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"], canBeAddedToBasket: true),
                            (title: "3 a23r", price: 43000.0, discountedPrice: 42000.0, discountValue: nil, images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRapSCeQqGfdGp8mFQR41el68BzzsA9qGi9PViWIYRj24Dmiu4J", "https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"], canBeAddedToBasket: true),
                            (title: "4 askdlfjlkajsdflkj", price: 123.5, discountedPrice: nil, discountValue: nil, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"], canBeAddedToBasket: true),
                            (title: "5 sdfj", price: 1499.99, discountedPrice: 1299.99, discountValue: nil, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"], canBeAddedToBasket: true),
                            (title: "6 aşosdfkjv pwdfı", price: 22.0, discountedPrice: 20.0, discountValue: nil, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"], canBeAddedToBasket: true),
                            (title: "7 dsnvm", price: 213.0, discountedPrice: 200.0, discountValue: nil, images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRapSCeQqGfdGp8mFQR41el68BzzsA9qGi9PViWIYRj24Dmiu4J", "https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"], canBeAddedToBasket: true),
                            (title: "8 230r9fjv sodfpoısdpfsdf", price: 1.0, discountedPrice: nil, discountValue: nil, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"], canBeAddedToBasket: true),
                            (title: "9 sakdf", price: 23.99, discountedPrice: 20.0, discountValue: nil, images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRapSCeQqGfdGp8mFQR41el68BzzsA9qGi9PViWIYRj24Dmiu4J", "https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"], canBeAddedToBasket: true),
                            (title: "10 sdfasdf sdfasdf", price: 19999.99, discountedPrice: 17999.99, discountValue: nil, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRapSCeQqGfdGp8mFQR41el68BzzsA9qGi9PViWIYRj24Dmiu4J"], canBeAddedToBasket: true)]
            window?.rootViewController = UINavigationController(rootViewController: vc)
        }
        window?.makeKeyAndVisible()
        return true
    }

    func cellDidSelect(item: (title: String, price: CGFloat, discountedPrice: CGFloat?, discountValue: CGFloat?, images: [String]?, canBeAddedToBasket: Bool)) {
        openProductDetail(item: item, indexPath: nil, cell: nil)
    }
        
    func openProductDetail(item: (title: String, price: CGFloat, discountedPrice: CGFloat?, discountValue: CGFloat?, images: [String]?, canBeAddedToBasket: Bool), indexPath: IndexPath?, cell: KEParallaxCell?) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailVC") as? ProductDetailVC {
            if let navc = window?.rootViewController as? UINavigationController {
                vc.images = item.images
                vc.cell = cell
                vc.item = item
                self.images = item.images
                
                let tempNav = UINavigationController(rootViewController: vc)
                tempNav.modalPresentationStyle = .overFullScreen
                tempNav.modalTransitionStyle = .crossDissolve
                tempNav.navigationBar.isTranslucent = true
                tempNav.navigationBar.isHidden = true
                navc.present(tempNav, animated: true)
            }
        }
    }
    
    func cellDidSelect(item: (title: String, price: CGFloat, discountedPrice: CGFloat?, discountValue: CGFloat?, images: [String]?, canBeAddedToBasket: Bool), indexPath: IndexPath, cell: KEParallaxCell?) {
        openProductDetail(item: item, indexPath: indexPath, cell: cell)
    }
    
    func allClicked() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsListVC") as? ProductsListVC {
            if let navc = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
                vc.modalPresentationStyle = .overFullScreen
                vc.delegate = self
                vc.itemArray = [(title: "1 sdfasdf", price: 400.0, discountedPrice: 200.0, discountValue: 10, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRapSCeQqGfdGp8mFQR41el68BzzsA9qGi9PViWIYRj24Dmiu4J", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQcj--O4oT-rAdJHPRpqCso5FylV5lw1-DCdmbJvsR2zeTJp7pa"], canBeAddedToBasket: true),
                                (title: "2 sdfasdf", price: 300.0, discountedPrice: nil, discountValue: nil, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"], canBeAddedToBasket: true),
                                (title: "3 sdfasdf", price: 19999.99, discountedPrice: 10000.0, discountValue: 30, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a"], canBeAddedToBasket: false),
                                (title: "4 sdfasdf", price: 40.0, discountedPrice: 20.0, discountValue: 99, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRapSCeQqGfdGp8mFQR41el68BzzsA9qGi9PViWIYRj24Dmiu4J"], canBeAddedToBasket: true),
                                (title: "5 sdfasdf", price: 4000.0, discountedPrice: 2000.0, discountValue: 10, images: ["https://js.pngtree.com/web3/images/index-new/5330219.png?v=a", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRapSCeQqGfdGp8mFQR41el68BzzsA9qGi9PViWIYRj24Dmiu4J", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQcj--O4oT-rAdJHPRpqCso5FylV5lw1-DCdmbJvsR2zeTJp7pa"], canBeAddedToBasket: false),
                                (title: "6 sdfasdf", price: 400.0, discountedPrice: nil, discountValue: nil, images: nil, canBeAddedToBasket: true)]
                navc.pushViewController(vc, animated: true)
            }
        }
    }
    
}

