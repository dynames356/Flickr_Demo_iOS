//
//  DetailView.swift
//  Flickr Demo
//
//  Created by Jovial on 08/08/2021.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var mProcessor = DetailProcessor()
    private var mInputImage: ImageModel
    
    init(inputImage: ImageModel) {
        mInputImage = inputImage
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Show Image Detail
                Image(uiImage: mProcessor.mImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .padding(.vertical, 5)
        .navigationTitle("Flickr Demo")
        .navigationBarTitleDisplayMode(.inline)
        // Hide Back Button due to using Navigation Title as the Button Text
        .navigationBarBackButtonHidden(true)
        // Replace it with Back Button for Leading Bar Items & Save Button for Trailing Bar Items
        .navigationBarItems(leading: Button("Back") {
            self.presentationMode.wrappedValue.dismiss()
        }, trailing: Button("Save") {
            mProcessor.saveImage()
        })
        // Change the Image Loading to onAppear function to avoid Image Loading when ContentView UI is shown
        .onAppear() {
            mProcessor.mInputImage = mInputImage
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(inputImage: ImageModel())
    }
}
