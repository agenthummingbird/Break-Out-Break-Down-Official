//
//  ScanConfirmation.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/15/25.
//

import SwiftUI

struct ScanConfirmation: View {
    var image: UIImage?
    
    @Environment(\.dismiss) private var dismiss

    @Binding var selectedTab: BreakoutBreakdownView.Tab
    @Binding var scanNavigationPath: NavigationPath
    @Binding var showSaveSuccessMessage: Bool

    var body: some View {
        VStack(spacing: 24) {
            if let image = image {
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
                    scanNavigationPath.append(ScanDestination.results(image, [])) // Push ScanResults page to NavigationStack to pass on image and ML results
                }) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.green)
                        .cornerRadius(8)
                }

                Button(action: {
                    scanNavigationPath = NavigationPath() // Resets entire navigation path to return to very first screen of ScanTab
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
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    ScanConfirmation(selectedTab: .constant(.scan), scanNavigationPath: .constant(NavigationPath()), showSaveSuccessMessage: .constant(false))
}
