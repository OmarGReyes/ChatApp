//
//  PhotoPickerLoginView.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 16/12/23.
//

import SwiftUI
import PhotosUI

struct PhotoPickerLoginView: View {
    @Binding var imageSelection: PhotosPickerItem?
    var selectedImage: UIImage?
    var body: some View {
        PhotosPicker(selection: $imageSelection, matching: .images) {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 90, height: 90)
                    
            } else {
                VStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: 64))
                    Text("Tap to add you own image")
                }
            }
        }
    }
}

struct PhotoPickerLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerLoginView(imageSelection: .constant(nil))
    }
}
