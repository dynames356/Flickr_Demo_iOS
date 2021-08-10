//
//  ContentView.swift
//  Flickr Demo
//
//  Created by Jovial on 07/08/2021.
//

import SwiftUI

struct ContentView: View {
    // Observed Object for API Call
    @ObservedObject private var mProcessor = ContentProcessor()
    
    // Produce 3 Columns Grid
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    let size = UIScreen.main.bounds.width / 3 - 10
    
    var body: some View {
        let mImages = mProcessor.mImageList
        
        NavigationView {
            VStack {
                // Search Bar UI
                SearchBarView(searchText: $mProcessor.inputTags)
                
                // If Observed Object contains Error Message from API Call, show it on the App
                if ($mProcessor.mErrorMessage.wrappedValue.isEmpty) {
                    ScrollView{
                        // If There are Images then produce the Grid
                        if (mImages.count > 0) {
                            LazyVGrid(columns: gridItemLayout, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                                // Loop each ImageModel obtained from API Call
                                ForEach(0..<mImages.count) { index in
                                    // For each Image Grid Cell, navigate it to Detail Page
                                    NavigationLink(destination: DetailView(inputImage: mImages[index])) {
                                        ImageViewCell(inputImage: mImages[index])
                                        .padding(5)
                                        .frame(width:120, height:120)
                                    }
                                }
                            })
                            .padding(5)
                        }
                    }
                } else {
                    Text("API Call Error -> \($mProcessor.mErrorMessage.wrappedValue)")
                }
                
                // To ensure that the UI is Top Aligned
                Spacer()
            }
            .navigationTitle("Flickr Demo")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
