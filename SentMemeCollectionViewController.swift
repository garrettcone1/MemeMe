//
//  SentMemeCollectionViewController.swift
//  Version 1 MemeMe App
//
//  Created by Garrett Cone on 12/6/16.
//  Copyright © 2016 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

class SentMemeCollectionViewController: UICollectionViewController {
    
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeDetailViewController", for: indexPath) as! MemeCollectionViewCell
        
        let collectionMeme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        //cell.nameLabel.text = meme.name
        cell.memeImageView?.image = UIImage(named: collectionMeme.topText! + collectionMeme.bottomText!)
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        // Populate the view controller with data from the selected item
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}





