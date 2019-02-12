//
//  RegisterVC.swift
//  BreakPoint
//
//  Created by Jeffrey Umandap on 01/02/2019.
//  Copyright © 2019 Jeffrey Umandap. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailTextfield: InsetTextField!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var passwordTextfield: InsetTextField!
    
    @IBOutlet weak var spinnerView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.clipsToBounds = true
        profileImg.contentMode = .scaleAspectFill
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectProfileImgPress(_ sender: Any) {
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openCamera(UIImagePickerController.SourceType.camera)
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openCamera(UIImagePickerController.SourceType.photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        
        // Add the actions
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func registerPress(_ sender: Any) {
        self.spinnerView.isHidden = false
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        let base64String = DataService.instance.convertImageTobase64(format: .png, image: profileImg.image!)
        
        if emailTextfield.text != nil && passwordTextfield.text != nil {
            AuthService.instance.registerUser(withEmail: self.emailTextfield.text!, andPassword: self.passwordTextfield.text!, imageCode: base64String!, userCreationComplete: { (success, registrationError) in
                if success {
                    AuthService.instance.loginUser(withEmail: self.emailTextfield.text!, andPassword: self.passwordTextfield.text!, loginComplete: { (success, nil) in
                        self.dismiss(animated: true, completion: nil)
                        print("Successfully registered user.")
                    })
                } else {
                    self.spinnerView.isHidden = true
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                    
                    print("Error Description in Register: \(String(describing: registrationError?.localizedDescription))")
                    
                    let alertPopup = UIAlertController(title: "Invalid Registration!", message: registrationError?.localizedDescription, preferredStyle: .alert)
                    
                    let alertOkBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertPopup.addAction(alertOkBtn)
                    self.present(alertPopup, animated: true, completion: nil)
                }
            })
        }
    }
    
    func openCamera(_ sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK:UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImg.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
