//
//  IngredientsProducts.swift
//  Break Out Break Down Official
//
//  Created by 46GOParticipant on 7/20/25.
//

import SwiftUI
import SwiftData
import UIKit

struct IngredientsProducts: View {
    var image: UIImage?
    var predictedConditionName: String
    @Binding var selectedTab: BreakoutBreakdownView.Tab // Allows this page to change active tab
    @Binding var scanNavigationPath: NavigationPath // For manipulating and resetting navigation
    @Binding var showSaveSuccessMessage: Bool

    // Find skin condition from skinConditions array in InfoTab by matching it to predictedConditionName
    private var conditionInfo: SkinCondition? {
        skinConditions.first(where: { $0.name == predictedConditionName })
    }

    @State private var navigateToSavePhoto = false

    var body: some View {
        
        ZStack {
            Color(hex: "59354D")
                .edgesIgnoringSafeArea(.all)
 
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Recommendations for \(predictedConditionName)")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 10)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(hex: "FFF7F3"))
                    
                    if let condition = conditionInfo {
                        Text("Ingredients to Look For:")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.top, 10)
                            .foregroundColor(Color(hex: "FFF7F3"))
                        
                        // Displays all ingredients to look for associated with the detected skin condition
                        ForEach(condition.ingredientsToLookFor, id: \.self) { ingredient in
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text(ingredient)
                                    .font(.body)
                                    .foregroundColor(Color(hex: "FFF7F3"))
                            }
                            .padding(.vertical, 2)
                        }
                        .padding(.leading, 10)
                        
                        Divider()
                            .padding(.vertical, 10)
                        
                        Text("Recommended Products:")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.top, 10)
                            .foregroundColor(Color(hex: "FFF7F3"))
                        
                        // Displays all recommended products associated with the detected skin condition
                        ForEach(condition.recommendedProducts, id: \.self) { product in
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text(product)
                                    .font(.body)
                                    .foregroundColor(Color(hex: "FFF7F3"))
                            }
                            .padding(.vertical, 2)
                        }
                        .padding(.leading, 10)
                        
                    } else {
                        Text("No specific recommendations available for '\(predictedConditionName)'.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        navigateToSavePhoto = true
                    }) {
                        Text("Save to History")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "D290BB"))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .padding()
            }
            .navigationTitle("Recommendations")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $navigateToSavePhoto) {
                let newSavedPhoto = SavedPhoto(data: image?.pngData() ?? Data(), date: Date(), predictedCondition: predictedConditionName)
                SaveToHistory(selectedTab: $selectedTab, scanNavigationPath: $scanNavigationPath, showSaveSuccessMessage: $showSaveSuccessMessage, photoToHistory: newSavedPhoto)
                    .navigationBarBackButtonHidden(true)
            }
            .toolbar(.hidden, for: .tabBar)
        }
    }
}

#Preview {
    IngredientsProducts(
        image: UIImage(systemName: "photo"),
        predictedConditionName: "Eczema",
        selectedTab: .constant(.scan),
        scanNavigationPath: .constant(NavigationPath()),
        showSaveSuccessMessage: .constant(false)
    )
}
