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
    @Binding var image: UIImage? // bind to parent view's state
    @Environment(\.presentationMode) var presentationMode // dismiss view when done
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController() // create camera picker
        picker.delegate = context.coordinator // set coordinate as delegate
        picker.sourceType = .camera // set source to camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // no updates
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image // pass selected image to parent
            }
            parent.presentationMode.wrappedValue.dismiss() // dismiss picker
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss() // dismiss on cancel
        }
        
    }
}
