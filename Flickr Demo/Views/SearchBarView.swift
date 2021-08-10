//
//  SearchBarView.swift
//  Flickr Demo
//
//  Created by Jovial on 07/08/2021.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    @State private var isEditing = false
 
    var body: some View {
        // Main UI
        ZStack {
            // Internal Box with Cornered Radius
            ZStack {
                // Search Bar Design
                Rectangle()
                    .foregroundColor(Color.white)
                // Horizontal Stack from Image, TextField, and Button
                HStack {
                    // The Search Icon for UI Design Purpose
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("LightGray"))
                    // The Textfield for use for search
                    TextField("Enter Tags",
                              text: $searchText,
                              onEditingChanged: { edit in },
                              onCommit: {
                                self.isEditing = false
                              })
                        .onTapGesture {
                            self.isEditing = true
                        }
                    
                    // Show Cancel Button when Editing
                    if isEditing {
                        Button(action: {
                            // Close Device's Keyboard when Cancel Button is pressed
                            self.isEditing = false
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }) {
                            Text("Cancel")
                        }
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                }
                .padding(.leading, 13)
            }
            .frame(height: 40.0)
            .cornerRadius(13)
            .padding()
        }
        .background(Color("LightGray"))
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
