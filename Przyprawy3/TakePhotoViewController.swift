//
//  TakePhotoViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 05/12/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class TakePhotoViewController: UIViewController, UINavigationControllerDelegate ,UIImagePickerControllerDelegate, UIGestureRecognizerDelegate {
    let imagePicker = UIImagePickerController()
    var currentSource : UIImagePickerController.SourceType = .camera
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var eanCodeLabel: UILabel!
    

    
   
    
    //var currentSourceType UIImagePickerController.SourceType
    
    @IBAction func takePhotoTap(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(currentSource)
        present(imagePicker, animated: true)
    }
    @IBAction func cancelTap(_ sender: UIBarButtonItem) {
         dismiss(animated: true)
    }
    func selectImageFrom( _ source: UIImagePickerController.SourceType) {
        imagePicker.delegate = self
        imagePicker.allowsEditing=true
        imagePicker.sourceType = source
        }
    
    // Delegate method : UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            print("Image not found")
            return
        }
        photoImageView.image=selectedImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageTapGesture=UITapGestureRecognizer(target: self, action: #selector(tapUserPhoto(_:)))
        imageTapGesture.delegate = self
        imageTapGesture.numberOfTapsRequired = 1
        photoImageView.addGestureRecognizer(imageTapGesture)
        photoImageView.isUserInteractionEnabled=true
        eanCodeLabel.text=database.scanerCodebarValue

        // Do any additional setup after loading the view.
    }
    @objc func tapUserPhoto(_ sender: UITapGestureRecognizer) {
        print("tapUserPhoto")
        let alertController=UIAlertController(title: "Warning", message: "You can change default photo source", preferredStyle: .alert)
        let actionPhotoLibrary=UIAlertAction(title: "Photo Library", style:
        .default) { (action) in
            print("Photo Library")
            self.currentSource = .photoLibrary
        }
        let actionPhotoAlbum=UIAlertAction(title: "Photo Album", style: .default) { (action) in
            print("Photo Album")
            self.currentSource = .savedPhotosAlbum
        }
        let actionCamera=UIAlertAction(title: "Camera", style: .default) { (action) in
            print("Photo Camera")
            self.currentSource = .camera
        }
        let actionCancel=UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(actionCamera)
        alertController.addAction(actionPhotoLibrary)
        alertController.addAction(actionPhotoAlbum)
        alertController.addAction(actionCancel)
        present(alertController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
