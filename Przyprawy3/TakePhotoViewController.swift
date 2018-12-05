//
//  TakePhotoViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 05/12/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class TakePhotoViewController: UIViewController, UINavigationControllerDelegate ,UIImagePickerControllerDelegate {
    let imagePicker=UIImagePickerController()
    @IBOutlet var photoImageView: UIImageView!
    enum ImageSource {
        case photoLibrary
        case camera
        case photoAlbum
    }
    
    @IBAction func takePhotoTap(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
        present(imagePicker, animated: true)
    }
    func selectImageFrom( _ source: ImageSource) {
        imagePicker.delegate=self
        switch source {
        case .camera:       imagePicker.sourceType = .camera
        case .photoLibrary: imagePicker.sourceType = .photoLibrary
        case .photoAlbum:   imagePicker.sourceType = .savedPhotosAlbum
        }
    }
    // Delegate method : UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("Image not found")
            return
        }
        photoImageView.image=selectedImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
