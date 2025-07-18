//
//  CameraView.swift
//  Break Out Break Down Official
//
//  Created by 46GOParticipant on 7/15/25.
//

import Foundation
import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage? // Bind to parent view's state; Stores captured image
    @Environment(\.presentationMode) var presentationMode // Dismiss view (camera screen) when done
    
    func makeUIViewController(context: Context) -> some UIViewController { // Creates and returns the UIKit view controller to handle camera input
        let picker = UIImagePickerController() // Create camera/image picker
        picker.delegate = context.coordinator // Set coordinate as delegate to handle user actions
        picker.sourceType = .camera // Set source to device's camera
        return picker // Return the configured picker to be displayed
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // no updates
    }
    
    func makeCoordinator() -> Coordinator { // Creates the Coordinator instance that acts as the delegate for UIImagePickerController
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate { // Acts as bridge between UIKit and SwiftUI; Handles image selection and cancellation
        let parent: CameraView // Reference to the parent CameraView
        
        init(_ parent: CameraView) { // Initialize with reference to the parent view
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [UIImagePickerController.InfoKey : Any]) { // Called when a photo is successfully taken
            if let image = info[.originalImage] as? UIImage {
                parent.image = image // pass selected/captured image back to parent
            }
            parent.presentationMode.wrappedValue.dismiss() // Dismiss picker (dismiss the camera view after the image is selected)
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { // Called if camera is cancelled without taking a photo
            parent.presentationMode.wrappedValue.dismiss() // Dismiss camera view on cancel
        }
        
    }
}
