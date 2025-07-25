//
//  ScanResults.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/16/25.
//
import SwiftUI
import UIKit
import SwiftData
struct ScanResults: View {
    var image: UIImage?
    
    @State var mlResults: [PredictionResult]
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    @Binding var selectedTab: BreakoutBreakdownView.Tab
    @Binding var scanNavigationPath: NavigationPath
    @Binding var showSaveSuccessMessage: Bool
    
    private let mlService = MLService()
    
    var body: some View {
        ZStack {
            Color(hex: "59354D")
                    .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Scan Results")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 10)
                        .foregroundColor(Color(hex: "FFF7F3"))
                    if isLoading {
                        ProgressView("Analyzing image...")
                            .font(.title2)
                            .padding()
                    } else if let errorMessage = errorMessage {
                        VStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.red)
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    } else if mlResults.isEmpty {
                        VStack {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.orange)
                            Text("No definitive results found. Please try another image.")
                                .foregroundColor(.orange)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    } else {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                                .padding(.bottom, 10)
                        }
                        Text("Top 3 Predicted Conditions:")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(hex: "FFF7F3"))
                        
                        //Colors are individual to each stats bar
                        let result = mlResults.prefix(3)
                        StatsBarView(title: result[0].identifier, value: result[0].confidence, hexColor: "D290BB")
                        StatsBarView(title: result[1].identifier, value: result[1].confidence, hexColor: "F6a9a9")
                        StatsBarView(title: result[2].identifier, value: result[2].confidence, hexColor: "FFCABA")
                        
                        // Information for predicted top condition
                        if let topResult = mlResults.first,
                           let conditionInfo = skinConditions.first(where: { $0.name == topResult.identifier }) {
                            Divider()
                                .padding(.vertical, 10)
                            ConditionInfoView(condition: conditionInfo)
                        } else if let topResult = mlResults.first {
                            Text("Detailed information for '\(topResult.identifier)' not available.")
                                .font(.body)
                                .foregroundColor(Color(hex: "FFF7F3"))
                        }
                    }
                    Button(action: {
                        scanNavigationPath.append(ScanDestination.ingredients(image, mlResults.first?.identifier ?? "Unknown"))
                    }) {
                        Text("Next: Recommendations")
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
                .frame(maxWidth: .infinity)
                
            }
            .navigationTitle("Results Page")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { // Triggers ML predictions
                if mlResults.isEmpty {
                    performPrediction()
                } else {
                    isLoading = false
                }
            }
            .toolbar(.hidden, for: .tabBar)
        }
    }
    // Function to initiate ML prediction/analysis
    private func performPrediction() {
        isLoading = true
        errorMessage = nil
        guard let image = image else {
            errorMessage = "No image provided for analysis."
            isLoading = false
            return
        }
        mlService.predictSkinCondition(image: image) { results, error in // Calls predictSkinCondition from MLService
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = error.localizedDescription
                } else if let results = results {
                    self.mlResults = results
                } else {
                    errorMessage = "No prediction results."
                }
            }
        }
    }
}
struct StatsBarView: View {
    var title: String
    var value: Double
    var hexColor: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(title): \(Int(value * 100))%")
                .font(.headline)
                .foregroundColor(Color(hex: "FFF7F3"))
                .frame(height: 30)
            ProgressView(value: value)
                .scaleEffect(x: 1, y: 3)
                .progressViewStyle(LinearProgressViewStyle(tint: Color(hex:"\(hexColor)")))
                .frame(height: 10)
                .cornerRadius(5)
        }
        .padding(.vertical, 3)
    }
}
struct ConditionInfoView: View {
    let condition: SkinCondition
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Your condition is most likely: \(condition.name)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "FFF7F3"))
                Text("Read About it Below:")
                    .foregroundColor(Color(hex: "FFF7F3"))
                VStack(alignment: .leading, spacing: 12) {
                    Text("About:")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(hex: "FFF7F3"))
                    Text(condition.info)
                        .font(.body)
                        .foregroundColor(Color(hex: "FFF7F3"))
                }
                Link("Learn more from source", destination: URL(string: condition.sourceURL)!)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.footnote)
                    .foregroundColor(Color(hex: "FFF7F3"))
                    .padding(.top, 16)
                Text("Consult a healthcare provider for professional advice and treatment.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 16)
            }
            .padding()
        }
        .navigationTitle("\(condition.name) Info")
        .background(Color(hex: "59354D"))
    }
}
#Preview {
    ScanResults(image: UIImage(named: "Eczema"),
                mlResults: [PredictionResult(identifier: "Atopic Dermatitis", confidence: 0.58), PredictionResult(identifier: "Normal", confidence: 0.25), PredictionResult(identifier: "Psoriasis", confidence: 0.17)],
                selectedTab: .constant(.scan),
                scanNavigationPath: .constant(NavigationPath()),
                showSaveSuccessMessage: .constant(false))
}


