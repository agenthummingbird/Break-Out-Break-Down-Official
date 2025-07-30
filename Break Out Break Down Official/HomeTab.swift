//
//  HomeTab.swift
//  Break Out Break Down Official
//
//  Created by 46GOParticipant on 7/11/25.
//

import SwiftUI
import SwiftData
import UIKit

struct HomeTab: View {
    @Query(sort: \SavedPhoto.date, order: .reverse) var recentPhotos: [SavedPhoto]
    @Binding var showSaveSuccessMessage: Bool // Binding property used to receive message state from BreakoutBreakdownView parent view

    var body: some View {
        ZStack {
            Color(hex: "59354D")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Howdy, User!")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 20)
                    .foregroundColor(Color(hex: "FFF7F3"))
                
                if showSaveSuccessMessage {
                    Text("Successfully saved! 🎉")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 15)
                        .background(Capsule().fill(Color(hex: " D290BB")))
                        .transition(.opacity.animation(.easeOut(duration: 0.3))) // Fade transition
                        .zIndex(1) // Places message at the top on VStack
                }
                
                Text("Your Most Recent Scan:")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex: "FFF7F3"))
                
                if let mostRecentPhoto = recentPhotos.first {
                    if let uiImage = UIImage(data: mostRecentPhoto.data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .padding(.bottom, 10)
                    } else {
                        Text("Image not available")
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("Condition: \(mostRecentPhoto.predictedCondition)")
                            .font(.headline)
                            .foregroundColor(Color(hex: "FFF7F3"))
                        Text("Scanned on: \(mostRecentPhoto.date, style: .date) at \(mostRecentPhoto.date, style: .time)")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "FFF7F3"))
                    }
                } else {
                    ContentUnavailableView("No Recent Scans", systemImage: "photo.badge.plus")
                        .font(.title2)
                        .foregroundColor(Color(hex: "FFF7F3"))
                }
                Spacer()
            }
            .padding()
            .onAppear {
                // Hide saved photo successfully message after 3 seconds
                if showSaveSuccessMessage {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation { // Animation
                            showSaveSuccessMessage = false
                        }
                    }
                }
            }
        }
    }
}



#Preview {
    HomeTab(showSaveSuccessMessage: .constant(true))
}
