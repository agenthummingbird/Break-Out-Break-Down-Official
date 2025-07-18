//
//  ScanResults.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/16/25.
//

import SwiftUI

struct ScanResults: View {
    
    var image: UIImage?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Results:")
                    .font(.title)
                // Stats bars
                StatsBarView(title: "Eczema", value: 0.80)
                StatsBarView(title: "Rosacea", value: 0.15)
                StatsBarView(title: "Whiteheads", value: 0.05)
                Text("Your Most Likely Condition is: Eczema")
                    .fontWeight(.semibold)
                Text("Read About it Below:")
                NavigationLink(destination: EczemaInfoView()) {
                    Text("Learn More About Eczema")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Results Page")
        }
    }
}
#Preview {
    ScanResults()
}

struct StatsBarView: View {
    var title: String
    var value: Double  // Between 0.0 and 1.0
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(title): \(Int(value * 100))%")
                .font(.headline)
            ProgressView(value: value)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .frame(height: 10)
                .cornerRadius(5)
        }
        .padding(.vertical, 6)
    }
}


struct EczemaInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Your condition is most likely: Eczema")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                Text("Read About it Below:")
                VStack(alignment: .leading, spacing: 12) {
                    Text("🧬 Causes:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Eczema (atopic dermatitis) is caused by a combination of genetic and environmental factors, including:")
                        .font(.body)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• A weakened skin barrier")
                        Text("• Immune system overreaction")
                        Text("• Allergens and irritants (soaps, detergents, dust)")
                        Text("• Climate (cold or dry weather)")
                        Text("• Stress")
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text("🛡️ Preventions:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("While eczema cannot be cured, it can be managed and flare-ups can be reduced by:")
                        .font(.body)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• Keeping skin moisturized regularly")
                        Text("• Avoiding harsh soaps and fragrances")
                        Text("• Wearing soft, breathable fabrics")
                        Text("• Managing stress")
                        Text("• Using a humidifier in dry environments")
                    }
                    .padding(.leading)
                }
                Text("⚠️ Always consult a healthcare provider for professional advice and treatment.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 16)
            }
            .padding()
        }
        .navigationTitle("Eczema Info")
        .background(Color(UIColor.systemBackground))
    }
}
#Preview {
    NavigationView {
        EczemaInfoView()
    }
}

