//
//  ViewController.swift
//  ImagePicker
//
//  Created by Ryan Smith on 10/3/16.
//  Copyright © 2016 Ryan Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // sets default background color
    
       self.view.backgroundColor = UIColor.gray

        
        // Sets text field attributes
        

        setTextFields(textField: topTextField)
        setTextFields(textField: bottomTextField)
        
        
        
       
    }
    
    // Defines text field attributes
    func setTextFields(textField:UITextField) {
        let memeTextAttributes = [
            
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
            
            ] as [String : Any]
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = self
        
    }
    
    // Shares/saves meme
    
    @IBAction func shareMeme(_ sender: AnyObject) {
        let memedImage = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        
        activityViewController.completionWithItemsHandler = {activity, success, items, error in
            if success {
                self.save(memedImage: memedImage)
            }
        }
       present(activityViewController, animated: true, completion: nil)
        
    }
    
    // returns app to default screen
 
    @IBAction func returnToDefault(_ sender: AnyObject) {
        UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "ViewController")
    }

    // Sets the source type to either photo library or camera and runs pickAnImage function

    @IBAction func chooseSourceType(_ sender: UIBarButtonItem) {
        
        if sender == albumButton {
            pickAnImage(sourceType: .photoLibrary)
        } else {
            pickAnImage(sourceType: .camera)
        }
        
        
    }
    
    // Will open either camera or album depending on source type
    
    func pickAnImage(sourceType:UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Creates the meme
    
    func save(memedImage: UIImage) {
        
        
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
    }
    
    // render view to an image
    
    func generateMemedImage() -> UIImage {
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memedImage
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        
        //disables camera button when there is no camera
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        // Disables share button when there is no image

        if imagePickerView.image == nil {
            shareButton.isEnabled = false
        } else {
            shareButton.isEnabled = true
        
        }
        
    }
    
    // Moves view up/down when keyobard appears/dissapears 
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomTextField.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
        
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        self.view.frame.origin.y = 0
               
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    

}

