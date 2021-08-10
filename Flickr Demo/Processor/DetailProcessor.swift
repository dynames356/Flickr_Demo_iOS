//
//  DetailProcessor.swift
//  Flickr Demo
//
//  Created by Jovial on 10/08/2021.
//

import Foundation
import Kingfisher

class DetailProcessor: NSObject, ObservableObject {
    @Published var mInputImage: ImageModel = ImageModel() {
        didSet {
            // If set load the image URL
            loadImage()
        }
    }
    // Temporary set Loading Icon Image to provide Loading Illusion
    @Published var mImage: UIImage = UIImage(imageLiteralResourceName: "loading_icon")
    
    override init() {
        
    }
    
    func loadImage() {
        print("Load Image -> \(mInputImage.BigImageURL)")
        // Generate Image URL for Image Loading
        guard let url = URL.init(string: mInputImage.BigImageURL) else {
            return
        }
        let resource = ImageResource(downloadURL: url)
        
        // Load Image using Kingfisher Library
        KingfisherManager.shared.retrieveImage(with: resource) { (result) in
            switch result {
            case .success(let value):
                self.mImage = value.image
            case .failure(let error):
                print("Load Image Error: \(error)")
            }
        }
    }
    
    func saveImage() {
        // Save Image into Photo Album
        UIImageWriteToSavedPhotosAlbum(mImage, self, #selector(saveError(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    // Check whether Save Image is successful or not
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if (error != nil) {
            print("Save Error -> \(String(describing: error))")
            return
        }
        print("Save finished!")
    }
}
