//
//  MemeTableViewController.swift
//  Version 1 MemeMe App
//
//  Created by Garrett Cone on 12/6/16.
//  Copyright © 2016 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var allMemes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    
    @IBAction func addAMeme(_ sender: Any) {
        
        let memeEditorController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        self.present(memeEditorController, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.allMemes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let table = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        
        let tableMeme = self.allMemes[(indexPath as NSIndexPath).row]
        
        // Set the image
        table.imageView?.image = tableMeme.saveMemedImage
        
        return table
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! MemeDetailViewController
        detailController.meme = self.allMemes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
