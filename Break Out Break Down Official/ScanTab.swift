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
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var showingCamera = false
    @State private var navigateToConfirmation = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(25)
                } else {
                    Text("No image selected.")
                        .foregroundStyle(.gray)
                        .padding()
                }
                
                Button("Take Photo") {
                    showingCamera = true
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
                .foregroundColor(.black)
                .cornerRadius(25)
                .sheet(isPresented: $showingCamera) {
                    CameraView(image: $selectedImage)
                        .onDisappear {
                            if selectedImage != nil {
                                navigateToConfirmation = true
                            }
                        }
                }
                
                PhotosPicker(
                    selection: $selectedPhoto,
                    matching: .images,
                    photoLibrary: .shared()
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
                            selectedImage = image
                            navigateToConfirmation = true
                        }
                    }
                }
            }
            .padding()
            .navigationDestination(isPresented: $navigateToConfirmation) {
                ScanConfirmation(image: selectedImage)
            }
        }
    }
}




#Preview {
    ScanTab()
}
