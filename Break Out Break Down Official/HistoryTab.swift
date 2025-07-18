//
//  HistoryTab.swift
//  Break Out Break Down Official
//
//  Created by 46GOParticipant on 7/11/25.
//

import SwiftUI
import SwiftData

//this is the context? where the savedPhotos are needed
struct HistoryTab: View {
    //@Environment(\.modelContext) var modelContext
    //var newSavedPhoto: UIImage
    
    var body: some View {
        NavigationStack{
            List {
                
            }
            /*
            .navigationTitle("History")
            .overlay(Text("No Photos Saved"))
            Button("Save") {
               // guard newSavedPhoto==nil else { return }
                
            }*/
        }
        
    }
}

#Preview {
    HistoryTab()
}
