//
//  SaveToHistory.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/18/25.
//


//
//  SaveToHistory.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/17/25.
//

import SwiftUI
import SwiftData

struct SaveToHistory: View {
    
    @Environment(\.modelContext) var context
    @Query var history: [SavedPhoto]
    @State private var changePage = false

    var photoToHistory: SavedPhoto?
    
    var body: some View {
        
        NavigationStack{
            VStack{
                Text("Save To History?")
                    .padding()
                HStack{
                    Button (action: {
                        context.insert(photoToHistory!)
                        changePage = true
                    }, label: {
                        Text("Yes")
                    })
                    
                    Button (action: {
                        changePage = true
                    }, label: {
                        Text("No")
                    })
                }
        }
            .navigationDestination(isPresented: $changePage) {
                HomeTab()
            }
        
            
                    
            /*
            HStack{
                Button("Yes"){
                    let newPhoto = SavedPhoto(photo: image!, date: Date())
                    // the ! means that it will only work if there is a photo there (I think)
                    history.add(newPhoto)
                    goToNextPage = true
                    
                }
                .frame(width: 100)
                Button("No"){
                    //return to home page
                    goToNextPage = true
                }
                .frame(width: 100)
            }
            if(goToNextPage) {
                HomeTab()
            }
             */
            
        }
        
        
    }
}

#Preview {
    SaveToHistory()
}

/*class allPhotos (addPhoto: UIImage): ObservableObject {
    @Published var savedPhotos: [SavedPhoto]
    
}*/
