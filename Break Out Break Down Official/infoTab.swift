//
//  infoTab.swift
//  Break Out Break Down Official
//
//  Created by 46GOParticipant on 7/11/25.
//

import SwiftUI

struct infoTab: View {
    var body: some View {
        VStack{
            Text("Skin Condition Information:")
            
            //Example Drop Down Texts
            DiseaseInfoBlock(name: "Eczema", info: "Itchy and dry spots on the skin which ...", sourceURL: "example.com", imageName: "examplePhoto")
            DiseaseInfoBlock(name: "Rosacea", info: "Pink patches on the skin...", sourceURL: "example.com", imageName: "examplePhoto")
            DiseaseInfoBlock(name: "Blackheads", info: "Oxidized black pimples on the skin...", sourceURL: "example.com", imageName: "examplePhoto")
        }
        .padding()
        Spacer()
    }
}

#Preview {
    infoTab()
}

// Creates a reusable drop down tab that can be copy and pasted in a VStack to construct a information page

struct DiseaseInfoBlock: View {
    //initializes constant properties that are defined by parameters
    let name: String
    let info: String
    let sourceURL: String
    let imageName: String
    
    var body: some View{
        
        // DisclosureGroup is the drop down tab where the name of the condition (name) is its parameter and its contents is the information we want to drop to (the V and Hstacks using the info, imageName, and sourceURL)
        DisclosureGroup(name){
            VStack{
                HStack{
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 90, alignment: .leading)
                    Spacer()
                    Text("\(info)")
                        .background(Color.teal)
                        .frame(width: 200, alignment: .leading)
                    
                }
                Text("Learn More: \(sourceURL)")
                    .font(.system(size:10))
                    .frame(alignment: .center)
                    .padding([.top, .bottom], 5)

            }
        }
        .padding(.horizontal, 20)
    }
    
    
    
    
}
