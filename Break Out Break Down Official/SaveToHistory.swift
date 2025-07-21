//
//  SaveToHistory.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/18/25.
//

import SwiftUI
import SwiftData
import UIKit

struct SaveToHistory: View {
    @Environment(\.modelContext) var context // Allows for saving new images to database
    @Environment(\.dismiss) private var dismiss // Dismisses current view/page
    @Binding var selectedTab: BreakoutBreakdownView.Tab
    @Binding var scanNavigationPath: NavigationPath // Allows for resetting entire navigation stack after each scan
    @Binding var showSaveSuccessMessage: Bool

    var photoToHistory: SavedPhoto?

    var body: some View {
        VStack {
            Text("Save this photo and information to your history?")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()

            if let photoData = photoToHistory?.data, let uiImage = UIImage(data: photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)
                    .padding(.bottom, 20)
            } else {
                Text("No photo to display.")
                    .foregroundColor(.gray)
            }

            HStack(spacing: 40) {
                Button(action: {
                    if let photo = photoToHistory {
                        context.insert(photo)
                        do {
                            try context.save()
                            showSaveSuccessMessage = true
                        } catch {
                            print("FAILED to save photo to history: \(error.localizedDescription)")
                        }
                    }
                    selectedTab = .home // Navigate to Home tab
                    scanNavigationPath = NavigationPath() // Reset the ScanTab's navigation path
                    dismiss() // Dismiss the current view
                }) {
                    Image(systemName: "checkmark.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.green)
                }

                Button(action: {
                    selectedTab = .home
                    scanNavigationPath = NavigationPath()
                    dismiss()
                }) {
                    Image(systemName: "xmark.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.red)
                }
            }
            .padding(.top, 30)
            Spacer()
        }
        .padding()
        .navigationTitle("Save to History")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    SaveToHistory(
        selectedTab: .constant(.scan),
        scanNavigationPath: .constant(NavigationPath()),
        showSaveSuccessMessage: .constant(false),
        photoToHistory: SavedPhoto(
            data: (UIImage(systemName: "photo")?.pngData() ?? Data()),
            date: Date(),
            predictedCondition: "Eczema"
        )
    )
}
