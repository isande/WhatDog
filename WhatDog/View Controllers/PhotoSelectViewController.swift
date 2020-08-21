//
//  PhotoSelectViewController.swift
//  WhatDog
//
//  Created by Peggy Wollenhaupt on 8/20/20.
//  Copyright © 2020 Peggy Wollenhaupt. All rights reserved.
//

import UIKit
import CoreML
import Vision

class PhotoSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var thinkLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            imageView.image = pickedImage
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func TakePictureTapped(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func ChoosePictureTapped(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}
