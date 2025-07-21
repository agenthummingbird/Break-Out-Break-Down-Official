//
//  HistoryTab.swift
//  Break Out Break Down Official
//
//  Created by 46GOParticipant on 7/11/25.
//

import SwiftUI
import SwiftData

struct HistoryTab: View {
    
    // Fetches and stores SavedPhoto objects in an array
    @Query(sort: \SavedPhoto.date, order: .reverse) var history: [SavedPhoto]
    @Environment(\.modelContext) private var context // Needed for deleteItems

    var body: some View {
        NavigationStack {
            Group {
                if history.isEmpty {
                    ContentUnavailableView("No Photos Saved Yet", systemImage: "photo.fill")
                } else {
                    List {
                        ForEach(history) { photo in
                            VStack(alignment: .leading) {
                                Text(photo.date, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Condition: \(photo.predictedCondition)")
                                    .font(.headline)
                                    .padding(.bottom, 2)
                                if let uiImage = UIImage(data: photo.data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(8)
                                } else {
                                    Text("Image not available") // Fallback if image data is bad
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                        .onDelete(perform: deleteItems) // Swipe to delete
                    }
                }
            }
            .navigationTitle("History")
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let photo = history[index]
            context.delete(photo)
        }
    }
}

#Preview {
    HistoryTab()
}
