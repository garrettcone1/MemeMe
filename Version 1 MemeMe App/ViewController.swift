//
//  ViewController.swift
//  Version 1 MemeMe App
//
//  Created by Garrett Cone on 11/17/16.
//  Copyright © 2016 Garrett Cone. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //Buttons & ImageView
    @IBOutlet weak var pickedImageDisplay: UIImageView!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    //TextFields
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    //Toolbars
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!

    let memeTextAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: Float(-3.0)
    
    ]
    
    func setTheTextFields(_ textFields: UITextField) {
        textFields.defaultTextAttributes = memeTextAttributes
        textFields.textAlignment = .center
        textFields.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        setTheTextFields(topTextField)
        setTheTextFields(bottomTextField)
    }
    
    
    
    // Sign up to be notified when the keyboard appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        //Disable Camera Button if not available
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        //Disable Share Button if no image is in the display
        shareButton.isEnabled = (pickedImageDisplay.image != nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // When the keyboardWillShowNotification is received, shift the view's frame up
    func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
        view.frame.origin.y = 0
    }

    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // Sign up to be notified when the keyboard appears
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    struct Meme {
        
        var topText: String?
        var bottomText: String?
        var originalImage: UIImage?
        var saveMemedImage: UIImage?
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navigationbar
        bottomToolbar.isHidden = true
        navigationBar.isHidden = true
        
        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navigationbar
        bottomToolbar.isHidden = false
        navigationBar.isHidden = false
        
        return memedImage
    }
    
    func save() {
        // Create the meme
        _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: pickedImageDisplay.image!, saveMemedImage: generateMemedImage())
    }
    
    // Clear text when starting to edit
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    // Hide the keyboard when "Return" is clicked
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func pickMyImage(_ sender: Any) {
        
        let imagePickerAction = UIImagePickerController()
        imagePickerAction.delegate = self
        imagePickerAction.sourceType = .photoLibrary
        self.present(imagePickerAction, animated: true, completion: nil)
        
        
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        
        let imagePickerAction = UIImagePickerController()
        imagePickerAction.delegate = self
        imagePickerAction.sourceType = .camera
        self.present(imagePickerAction, animated: true, completion: nil)
    }
    
    @IBAction func shareButton(_ sender: Any) {
        
        let memeToShare = generateMemedImage()
        let nextController = UIActivityViewController(activityItems: [memeToShare], applicationActivities: nil)
        // Call the save() method with completion handler
        nextController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
            }
        }
        
        self.present(nextController, animated: true, completion: nil)
        
    }
    
    // Selected image will be shown in the Image View
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String : Any]) {
        
        if let image = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage {
            
            pickedImageDisplay.image = image
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // If nothing is selected and clicked cancel, then we can exit the image picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    


}//End of class




