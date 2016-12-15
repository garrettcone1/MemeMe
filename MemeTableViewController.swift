//
//  MemeTableViewController.swift
//  Version 1 MemeMe App
//
//  Created by Garrett Cone on 12/6/16.
//  Copyright © 2016 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    
    var allMemes: [Meme]!
    
    @IBAction func addAMeme(_ sender: Any) {
        
        let memeEditor = storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        present(memeEditor, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        allMemes = applicationDelegate.memes
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.allMemes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let table = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        
        let tableMeme = self.allMemes[(indexPath as NSIndexPath).row]
        
        // Set the image and label
        table.imageView?.image = tableMeme.saveMemedImage
        table.textLabel?.text = tableMeme.topText! + " " + tableMeme.bottomText!
        return table
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.allMemes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
