//
//  ScanConfirmation.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/15/25.
//

import SwiftUI

struct ScanConfirmation: View {
    var image: UIImage? // Image passed from ScanTab
    
    @Environment(\.dismiss) private var dismiss // Dismisses current view of ScanConfirmation and goes back to ScanTab
    @State private var navigateToResults = false // Controls navigation to ScanResults

    var body: some View {
        VStack(spacing: 24) {
            if let image = image { // Show selected image
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)
                    .padding(.top, 40)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)
                    .padding(.top, 40)
            }

            Text("Do you want to use this photo?")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Please confirm or retake the photo shown above.")
                .font(.body)
                .foregroundColor(.gray)

            HStack(spacing: 20) {
                Button(action: {
                    // navigate to results
                    navigateToResults = true
                }) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.green)
                        .cornerRadius(8)
                }

                Button(action: {
                    // go back to scanTab
                    dismiss()
                }) {
                    Image(systemName: "arrow.uturn.left")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 32)

            Spacer()
        }
        .padding()
        .navigationDestination(isPresented: $navigateToResults) { // Navigation to ScanResults
            ScanResults(image: image)
        }
        
    }
}


#Preview {
    ScanConfirmation()
}
