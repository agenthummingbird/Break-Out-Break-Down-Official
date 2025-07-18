//
//  HistoryTab.swift
//  Break Out Break Down Official
//
//  Created by 46GOParticipant on 7/11/25.
//

import SwiftUI
import SwiftData

//this is the context where the array of savedPhotos are needed
struct HistoryTab: View {
    
    //********need sort order by date
    
    @Query(sort: \SavedPhoto.date, order: .reverse) var history: [SavedPhoto] //access the model
    
    
    var body: some View {
        NavigationStack{
            
            List {
                            
                ForEach(history, id: \.self) {photo in //uses itself as the identifier, saying everything it iterates thru is unique?
                    Text("\(photo.date)")
                        .font(.title2)
                    //********Need to add skin condition
                    Image(uiImage: UIImage(data:photo.data)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                    
                }
            }
            //******swipe to delete
            
            
            .navigationTitle("History")
            //Add UI so that if there are no photos it will say so
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
