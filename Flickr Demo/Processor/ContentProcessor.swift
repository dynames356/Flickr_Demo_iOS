//
//  ContentProcessor.swift
//  Flickr Demo
//
//  Created by Jovial on 07/08/2021.
//

import SwiftUI

class ContentProcessor: ObservableObject {
    @Published var mImageList = Array<ImageModel>()
    @Published var mImageCounter: Int = 0
    
    // To Monitor the Search Bar Input
    @Published var inputTags: String = "" {
        didSet {
            loadImages(tags: inputTags)
        }
    }
    @Published var mErrorMessage = ""
    
    private var mNumbOfImages = 21
    
    init() {
        // Initial Load of Images
        loadImages(tags: "Electrolux")
    }
    
    // Load Images based on inputted Tag String
    func loadImages(tags: String) {
        print("Input Tags: \(tags)")
        RequestData.getInstance().getImages(tags: tags, numberOfImages: mNumbOfImages) { (images, errorMessage) in
            self.mImageList = images
            self.mImageCounter = 0
            self.mErrorMessage = errorMessage
            self.objectWillChange.send()
        }
    }
    
    func getImageList() -> Array<ImageModel> {
        return mImageList
    }
}
