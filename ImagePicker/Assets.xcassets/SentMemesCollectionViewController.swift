//
//  SentMemesCollectionViewController.swift
//  ImagePicker
//
//  Created by Ryan Smith on 1/19/17.
//  Copyright © 2017 Ryan Smith. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes = [Meme]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        let space: CGFloat = 3.0
        let widthDimension = (view.frame.size.width - (2 * space)) / 3
        let heightDimension = (view.frame.size.height - (2 * space)) / 5.4
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        
        let meme = memes[indexPath.row]
        
        cell.memeImage.image = meme.memedImage
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetailVC = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        memeDetailVC.meme = memes[indexPath.row]
        
        self.navigationController?.pushViewController(memeDetailVC, animated: true)
    }

}
