//
//  ViewController.swift
//  Video_Record_Project
//
//  Created by park kyung suk on 2019/06/16.
//  Copyright © 2019 park kyung suk. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices

class ViewController: UIViewController {

    let imagePickerController = UIImagePickerController()
    var videoUrl: URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    


    @IBAction func recordButtonTapped(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera Available")
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            print("Camera Unavailable")
        }
    }
    
    
    @IBAction func playButtonTapped(_ sender: Any) {
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaURL] as? String, mediaType == kUTTypeMovie as String, let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL, UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) else { return }
        
        
        // Handle a Movie capture
        UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        
        let title = error == nil ? "Success" : "Error"
        let message = error == nil ? "Video was saved" : "Video failed to save"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UINavigationControllerDelegate {
    

}

