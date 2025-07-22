//
//  InfoTab.swift
//  Break Out Break Down Official
//
//  Created by 46GOParticipant on 7/11/25.
//

import SwiftUI

struct InfoTab: View {
    var body: some View {
        
        ZStack {
            Color(hex: "59354D")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Skin Condition Information:")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 5)
                        .foregroundColor(Color(hex: "FFF7F3"))
                    
                    ForEach(skinConditions) { condition in // Loops through each skin condition and shows a block
                        DiseaseInfoBlock(
                            name: condition.name,
                            info: condition.info,
                            sourceURL: condition.sourceURL,
                            imageName: condition.imageName
                        )
                        .accentColor(Color(hex: "D290BB"))
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct SkinCondition: Identifiable {
    let id = UUID() // Gives each condition a unique ID to be used in the ForEach method
    let name: String
    let info: String
    let sourceURL: String
    let imageName: String
    let ingredientsToLookFor: [String]
    let recommendedProducts: [String]
}


let skinConditions: [SkinCondition] = [
    SkinCondition(
        name: "Eczema",
        info: "Eczema is a condition that causes your skin to become dry, itchy and bumpy. This condition weakens your skin’s barrier function, which is responsible for helping your skin retain moisture and protecting your body from outside elements.",
        sourceURL: "https://my.clevelandclinic.org/health/diseases/9998-eczema",
        imageName: "Eczema",
        ingredientsToLookFor: ["Ceramides", "Hyaluronic Acid", "Colloidal Oatmeal", "Niacinamide", "Shea Butter"],
        recommendedProducts: ["CeraVe Moisturizing Cream", "Aveeno Eczema Therapy Daily Moisturizing Cream", "La Roche-Posay Lipikar Balm AP+M"]
    ),
    SkinCondition(
        name: "Rosacea",
        info: "Rosacea is a common skin condition that causes flushing or long-term redness on your face. It also may cause enlarged blood vessels and small, pus-filled bumps. Some symptoms may flare for weeks to months and then go away for a while.",
        sourceURL: "https://www.mayoclinic.org/diseases-conditions/rosacea/symptoms-causes/syc-20353815",
        imageName: "Rosacea",
        ingredientsToLookFor: ["Azelaic Acid", "Metronidazole", "Sulfur", "Green Tea Extract", "Licorice Root Extract"],
        recommendedProducts: ["Paula's Choice 10% Azelaic Acid Booster", "The Ordinary Azelaic Acid Suspension 10%", "Dr. Jart+ Cicapair Tiger Grass Color Correcting Treatment"]
    ),
    SkinCondition(
        name: "Blackheads",
        info: "Blackheads are a type of acne (acne vulgaris). They’re open bumps on the skin that fill with excess oil and dead skin. They look as if dirt is in the bump, but an irregular light reflection off the clogged follicle actually causes the dark spots.",
        sourceURL: "https://my.clevelandclinic.org/health/diseases/22038-blackheads",
        imageName: "Blackheads",
        ingredientsToLookFor: ["Salicylic Acid (BHA)", "Retinoids (Retinol, Tretinoin)", "Niacinamide", "Clay"],
        recommendedProducts: ["Paula's Choice 2% BHA Liquid Exfoliant", "COSRX BHA Blackhead Power Liquid", "The Ordinary Retinol 0.5% in Squalane"]
    ),
    SkinCondition(
        name: "Psoriasis",
        info: "Psoriasis is a skin disease that causes a rash with itchy, scaly patches, most commonly on the knees, elbows, trunk and scalp.",
        sourceURL: "https://www.mayoclinic.org/diseases-conditions/psoriasis/symptoms-causes/syc-20355840",
        imageName: "Psoriasis",
        ingredientsToLookFor: ["Coal Tar", "Salicylic Acid", "Corticosteroids", "Vitamin D Analogues", "Urea"],
        recommendedProducts: ["Neutrogena T/Gel Therapeutic Shampoo", "CeraVe SA Cream for Rough & Bumpy Skin", "Dermarest Psoriasis Medicated Shampoo Plus Conditioner"]
    ),
    SkinCondition(
        name: "Milia",
        info: "Milia (milk spots) are small, white cysts on your skin. Cysts are filled pockets under the surface of your skin. The most common place to find milia are on your face. Milia are harmless and only affect your appearance.",
        sourceURL: "https://my.clevelandclinic.org/health/diseases/17868-milia",
        imageName: "Milia",
        ingredientsToLookFor: [""],
        recommendedProducts: [""]
    )
]

struct DiseaseInfoBlock: View { // Creates a reusable drop down tab that can be copy and pasted in a VStack to construct a information page
    //initializes constant properties that are defined by parameters
    let name: String
    let info: String
    let sourceURL: String
    let imageName: String

    var body: some View { // DisclosureGroup is the drop down tab where the name of the condition (name) is its parameter and its contents is the information we want to drop to (the V and Hstacks using the info, imageName, and sourceURL)
        DisclosureGroup(name) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 90)
                        .cornerRadius(8)
                    Text(info)
                        .font(.system(size: 12))
                        .frame(width: 200, alignment: .leading)
                        .foregroundColor(Color(hex: "FFF7F3"))
                }
                Link("Learn more", destination: URL(string: sourceURL)!) // Link is a control for navigating to a URL - makes URLs clickable
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.footnote)
                    .foregroundColor(Color(hex: "D290BB"))
                    .padding(.top, 5)
            }
            .padding(.top, 5)
        }
        .padding(.horizontal, 10)
        .foregroundColor(Color(hex: "D290BB"))
    }
}

#Preview {
    InfoTab()
}

