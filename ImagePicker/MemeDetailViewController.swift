//
//  MemeDetailViewController.swift
//  ImagePicker
//
//  Created by Ryan Smith on 1/21/17.
//  Copyright © 2017 Ryan Smith. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    
    var meme: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailImage.image = meme.memedImage
        
    }

    

}
