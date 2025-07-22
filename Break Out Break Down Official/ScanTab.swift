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
    @State private var selectedPhoto: PhotosPickerItem? // Holds photo item from PhotosPicker
    @State private var selectedImage: UIImage? // Holds UIImage representation of selected/captured photo
    @State private var showingCamera = false // Controls presentation of camera

    @State private var scanNavigationPath = NavigationPath() // Defines sequence of screen in NavigationStack - resetting path returns screen to the initial/root of the stack

    @Binding var selectedTab: BreakoutBreakdownView.Tab
    @Binding var showSaveSuccessMessage: Bool

    var body: some View {
        NavigationStack(path: $scanNavigationPath) {
            
            ZStack {
                Color(hex: "59354D")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Scan your skin:")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 20)
                        .foregroundColor(Color(hex: "FFF7F3"))
                    
                    Button("Take Photo") {
                        showingCamera = true
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "D290BB"))
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .sheet(isPresented: $showingCamera) {
                        CameraView(image: $selectedImage)
                            .onDisappear {
                                if let image = selectedImage {
                                    scanNavigationPath.append(ScanDestination.confirmation(image))
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
                            .background(Color(hex: "F6A9A9"))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    .onChange(of: selectedPhoto) {
                        Task {
                            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                selectedImage = image
                                scanNavigationPath.append(ScanDestination.confirmation(image))
                            }
                        }
                    }
                }
                .padding()
                // Present different screens
                .navigationDestination(for: ScanDestination.self) { destination in
                    switch destination {
                    case .confirmation(let image):
                        ScanConfirmation(image: image, selectedTab: $selectedTab, scanNavigationPath: $scanNavigationPath, showSaveSuccessMessage: $showSaveSuccessMessage)
                    case .results(let image, let mlResults):
                        ScanResults(image: image, mlResults: mlResults, selectedTab: $selectedTab, scanNavigationPath: $scanNavigationPath, showSaveSuccessMessage: $showSaveSuccessMessage)
                    case .ingredients(let image, let predictedConditionName):
                        IngredientsProducts(image: image, predictedConditionName: predictedConditionName, selectedTab: $selectedTab, scanNavigationPath: $scanNavigationPath, showSaveSuccessMessage: $showSaveSuccessMessage)
                    }
                }
            }
        }
        // Resets the ScanTab (brings you back to initial scan/upload photo page) if user enters ScanTab again from another tab
        .onChange(of: selectedTab) { oldTab, newTab in
            if newTab == .scan {
                scanNavigationPath = NavigationPath() // Resets entire NavigationPath to be empty
                selectedImage = nil
                selectedPhoto = nil
            }
        }
    }
}

// Represent different navigation destinations within ScanTab
enum ScanDestination: Hashable { // Types pushed into NavigationPath must confirm to Hashable, and since UIIMage and arrays aren't inherently hashable, hence wrapping them in enum
    case confirmation(UIImage?)
    case results(UIImage?, [PredictionResult])
    case ingredients(UIImage?, String)

    func hash(into hasher: inout Hasher) {
        switch self {
        case .confirmation(let image):
            hasher.combine("confirmation")
            hasher.combine(image?.jpegData(compressionQuality: 0.8))
        case .results(let image, let results):
            hasher.combine("results")
            hasher.combine(image?.jpegData(compressionQuality: 0.8))
            hasher.combine(results.map { $0.identifier + String($0.confidence) })
        case .ingredients(let image, let conditionName):
            hasher.combine("ingredients")
            hasher.combine(image?.jpegData(compressionQuality: 0.8))
            hasher.combine(conditionName)
        }
    }

    static func == (lhs: ScanDestination, rhs: ScanDestination) -> Bool {
        switch (lhs, rhs) {
        case (.confirmation(let lhsImage), .confirmation(let rhsImage)):
            return lhsImage?.jpegData(compressionQuality: 0.8) == rhsImage?.jpegData(compressionQuality: 0.8)
        case (.results(let lhsImage, let lhsResults), .results(let rhsImage, let rhsResults)):
            return lhsImage?.jpegData(compressionQuality: 0.8) == rhsImage?.jpegData(compressionQuality: 0.8) &&
                   lhsResults.map { $0.identifier + String($0.confidence) } == rhsResults.map { $0.identifier + String($0.confidence) }
        case (.ingredients(let lhsImage, let lhsCondition), .ingredients(let rhsImage, let rhsCondition)):
            return lhsImage?.jpegData(compressionQuality: 0.8) == rhsImage?.jpegData(compressionQuality: 0.8) &&
                   lhsCondition == rhsCondition
        default:
            return false
        }
    }
}


#Preview {
    ScanTab(selectedTab: .constant(.scan), showSaveSuccessMessage: .constant(false))
}
