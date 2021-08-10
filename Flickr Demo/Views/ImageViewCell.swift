//
//  ImageViewCell.swift
//  Flickr Demo
//
//  Created by Jovial on 07/08/2021.
//

import SwiftUI
import Kingfisher

// Image View Cell class for the Grid Cell
struct ImageViewCell: View {
    var inputImage: ImageModel
    
    var body: some View {
        // Load Image using Kingfisher Library
        KFImage.url(URL(string: inputImage.SmallImageURL)!)
            .placeholder{
                Image("loading_icon").resizable()
            }
            .resizable()
            .cacheMemoryOnly()
            .cancelOnDisappear(true)
            .aspectRatio(contentMode: .fit)
    }
}

struct ImageViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewCell(inputImage: ImageModel())
    }
}
