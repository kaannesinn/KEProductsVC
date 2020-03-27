//
//  ViewController.swift
//  KEParallaxCollection
//
//  Created by Kaan Esin on 26.03.2020.
//  Copyright © 2020 Kaan Esin. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

