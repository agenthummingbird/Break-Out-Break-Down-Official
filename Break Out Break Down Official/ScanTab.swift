//
//  scanTab.swift
//  Break Out Break Down Official
//
//  Created by 46GOParticipant on 7/11/25.
//

import SwiftUI
import UIKit
import PhotosUI

struct ScanTab: View {
    
    @State private var selectedPhoto: PhotosPickerItem?    // Photo selected from the library
    @State private var selectedImage: UIImage?             // UIImage created from the selected photo
    @State private var showingCamera = false               // Controls whether the camera sheet is presented
    @State private var navigateToConfirmation = false      // Controls navigation to ScanConfirmation
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Take Photo") { // Take photo button
                    showingCamera = true
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
                .foregroundColor(.black)
                .cornerRadius(25)
                .sheet(isPresented: $showingCamera) {
                    CameraView(image: $selectedImage) // Presents camera view
                        .onDisappear {
                            if selectedImage != nil { // If an image was taken, navigate to ScanConfirmation
                                navigateToConfirmation = true
                            }
                        }
                }
                
                PhotosPicker( // Select photo from photo library
                    selection: $selectedPhoto,
                    matching: .images, // Ensures only image types can be selected
                    photoLibrary: .shared() // Access the shared photo library
                ) {
                    Text("Select Photo")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
                .onChange(of: selectedPhoto) {
                    Task {
                        if let data = try? await selectedPhoto?.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            selectedImage = image // Set selected image
                            navigateToConfirmation = true // Navigates to ScanConfirmation
                        }
                    }
                }
            }
            .padding()
            .navigationDestination(isPresented: $navigateToConfirmation) { // Navigation to ScanConfirmation Page
                ScanConfirmation(image: selectedImage)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}




#Preview {
    ScanTab()
}
