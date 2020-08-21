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
            
            guard let ciImage = CIImage(image: pickedImage) else {
                fatalError("cannot convert to CIImage")
            }
            
            detect(image: ciImage)
            
            imageView.image = pickedImage
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: DogClassifier().model) else {
            fatalError("cannot import model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            let classification = request.results?.first as? VNClassificationObservation
            self.breedLabel.text = classification?.identifier
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print("Error: \(error)")
        }
        
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
