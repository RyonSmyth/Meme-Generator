//
//  SentMemesTableViewController.swift
//  ImagePicker
//
//  Created by Ryan Smith on 1/19/17.
//  Copyright © 2017 Ryan Smith. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memes = [Meme]()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        
    }

    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell", for: indexPath) as! SentMemesTableViewCell
        let meme = memes[indexPath.row]
        cell.memeImage.image = meme.memedImage
        cell.memeText.text = ("\(meme.topText) \(meme.bottomText)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailVC = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        memeDetailVC.meme = memes[indexPath.row]
        
        self.navigationController?.pushViewController(memeDetailVC, animated: true)
    }

}
