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
        name: "Atopic Dermatitis",
        info: "Eczema is the name for a group of inflammatory skin conditions that cause dry skin, itchiness, rashes, scaly patches, blisters and skin infections. There are seven types of eczema that affect the skin. There is no cure for eczema but there are many treatments available to help you manage it.",
        sourceURL: "https://nationaleczema.org/eczema/#h-management-and-treatment",
        imageName: "Eczema",
        ingredientsToLookFor: ["Colloidal Oatmeal", "Shea Butter", "Aloe", "Glycerin", "Petrolatum", "Vitamin E", "Niacinamide"],
        recommendedProducts: ["CeraVe Moisturizing Cream", "Aveeno Eczema Therapy Daily Moisturizing Cream", "La Roche-Posay Lipikar Balm AP+M"]
    ),
    SkinCondition(
        name: "Rosacea",
        info: "Rosacea is a common skin condition that causes flushing or long-term redness on your face. It also may cause enlarged blood vessels and small, pus-filled bumps. Some symptoms may flare for weeks to months and then go away for a while.",
        sourceURL: "https://www.mayoclinic.org/diseases-conditions/rosacea/symptoms-causes/syc-20353815",
        imageName: "Rosacea",
        ingredientsToLookFor: ["Brimonidine", "Oxymetazoline", "Azelaic Acid", "Metronidazole", "Ivermectin"],
        recommendedProducts: ["Paula's Choice 10% Azelaic Acid Booster", "The Ordinary Azelaic Acid Suspension 10%", "Dr. Jart+ Cicapair Tiger Grass Color Correcting Treatment"]
    ),
    SkinCondition(
        name: "Blackheads",
        info: "Blackheads are a type of acne (acne vulgaris). They’re open bumps on the skin that fill with excess oil and dead skin. They look as if dirt is in the bump, but an irregular light reflection off the clogged follicle actually causes the dark spots.",
        sourceURL: "https://my.clevelandclinic.org/health/diseases/22038-blackheads",
        imageName: "Blackheads",
        ingredientsToLookFor: ["Salicylic Acid", "Azelaic Acid", "Benzoyl Peroxide", "Retinoids (Vitamin A Derivatives)", "Tea Tree Oil"],
        recommendedProducts: ["Paula's Choice Skin Perfecting 2% BHA Liquid Exfoliant", "COSRX BHA Blackhead Power Liquid", "The Ordinary Retinol 0.5% in Squalane"]
    ),
    SkinCondition(
        name: "Psoriasis",
        info: "Psoriasis is a skin disease that causes a rash with itchy, scaly patches, most commonly on the knees, elbows, trunk and scalp.",
        sourceURL: "https://www.mayoclinic.org/diseases-conditions/psoriasis/symptoms-causes/syc-20355840",
        imageName: "Psoriasis",
        ingredientsToLookFor: ["Salicylic Acid", "Cool Tar", "Corticosteroids", "Vitamin D Analogues", "Retinoids", "Anthralin", "Calcineurin Inhibitors"],
        recommendedProducts: ["Neutrogena T/Gel Therapeutic Shampoo", "CeraVe SA Cream for Rough & Bumpy Skin", "Dermarest Psoriasis Medicated Shampoo Plus Conditioner"]
    ),
    SkinCondition(
        name: "Milia",
        info: "Milia (milk spots) are small, white cysts on your skin. Cysts are filled pockets under the surface of your skin. The most common place to find milia are on your face. Milia are harmless and only affect your appearance.",
        sourceURL: "https://my.clevelandclinic.org/health/diseases/17868-milia",
        imageName: "Milia",
        ingredientsToLookFor: ["Adapalene", "Tretinoin"],
        recommendedProducts: ["Paula’s Choice Skin Perfecting 2% BHA Liquid Exfoliant", "CeraVe Resurfacing Retinol Serum", "CeraVe SA Smoothing Cream", "Vanicream Daily Facial Moisturizer"]
    ),
    SkinCondition(
        name: "Whiteheads",
        info: "Info/description: Whiteheads are a type of acne (acne vulgaris). Oil and dead skin close off hair follicles or sebaceous glands (oil glands) and form a closed bump on your skin (comedo, plural comedones).",
        sourceURL: "https://my.clevelandclinic.org/health/diseases/22039-whiteheads",
        imageName: "Whiteheads",
        ingredientsToLookFor: ["Salicylic Acid", "Azelaic Acid", "Benzoyl Peroxide", "Retinoids (Vitamin A Derivatives)"],
        recommendedProducts: ["CeraVe Foaming Facial Cleanser", "Differin Adapalene Gel 0.1% Acne Treatment", " Clinique Acne Solutions All Over Clearing Treatment"]
    ),
    SkinCondition(
        name: "Normal",
        info: "Normal skin is defined as well-balanced skin which contains the optimal amount of sebum and moisture. This skin type tends to have fine pores, an even tone and is neither too oily or too dry. Both sensitivity and outbreaks are rare in normal skin but this can be triggered by internal and external stressors.",
        sourceURL: "https://cityskinclinic.com/the-skincare-routines/normal-skin/",
        imageName: "NormalSkin",
        ingredientsToLookFor: ["Glycolic Acid", "Vitamin C", "Hyaluronic Acid", "Polyglutamic Acid", "Retinol", "Tretinoin"],
        recommendedProducts: ["CeraVe Hydrating Facial Cleanser", "Neutrogena Hydro Boost Water Gel", "The Ordinary Niacinamide 10% + Zinc 1%", "EltaMD UV Clear Broad-Spectrum SPF 46"]
    ),
    SkinCondition(
        name: "Hives",
        info: "Hives are raised red bumps (welts) or splotches on the skin that are often very itchy. They’re a type of swelling on the surface of your skin and happen when your body has an allergic reaction.",
        sourceURL: "Hives",
        imageName: "Hives",
        ingredientsToLookFor: ["Diphenhydramine", "Loratadine", "Levocetirizine"],
        recommendedProducts: ["Benadryl", "Claritin", "Allegra", "Zyrtec", "Xyzal"]
    ),
    SkinCondition(
        name: "Shingles",
        info: "Shingles is a viral infection that causes a painful rash. Shingles can occur anywhere on your body. It typically looks like a single stripe of blisters that wraps around the left side or the right side of your torso.",
        sourceURL: "https://www.mayoclinic.org/diseases-conditions/shingles/symptoms-causes/syc-20353054",
        imageName: "Shingles",
        ingredientsToLookFor: ["Acyclovir", "Famciclovir", "Valacyclovir"],
        recommendedProducts: ["Zovirax", "Valtrex"]
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

