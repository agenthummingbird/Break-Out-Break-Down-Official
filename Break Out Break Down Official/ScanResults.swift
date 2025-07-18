//
//  ScanResults.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/16/25.
//

import SwiftUI
import UIKit
import SwiftData

struct ScanResults: View {
    
    var image: UIImage?
    @State private var changePage = false
    
    var body: some View {
        let scanPhoto = savePhoto(photo: image)
        let newPhoto: SavedPhoto = SavedPhoto(data: scanPhoto.pngData()!, date: Date())
        //let newPhoto = SavedPhoto(photo: image!, date: Date())
        
        // the ! means that it will only work if there is a photo there (I think)
        
        NavigationStack {
            
            Image(uiImage: scanPhoto)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)

            Text("yay it works")
            
            Button (action: {
                changePage = true
            }, label: {
                Text("Change Page")
            })

        }
        .navigationTitle(Text("Scan Results"))
        .navigationDestination(isPresented: $changePage) {
            SaveToHistory(photoToHistory: newPhoto)
        }
                
        
        
        
        
    }
}

#Preview {
    ScanResults()
}

func savePhoto(photo: UIImage?) -> UIImage {
    //let example: UIImage = UIImage("examplePhoto")
    guard let shownImage = photo else {return UIImage(imageLiteralResourceName: "examplePhoto")}
    return shownImage
}

/*
 struct NoPhotoError: Error {
 enum NoPhoto {
 case "no photo"
 }
 
 }
 */
