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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Scan Results")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
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
                        .font(.title2)
                        .bold()
                    ForEach(mlResults.prefix(3), id: \.identifier) { result in
                        StatsBarView(title: result.identifier, value: result.confidence)
                    }
                    // Information for predicted top condition
                    if let topResult = mlResults.first,
                       let conditionInfo = skinConditions.first(where: { $0.name == topResult.identifier }) {
                        Divider()
                            .padding(.vertical, 10)
                        ConditionInfoView(condition: conditionInfo)
                    } else if let topResult = mlResults.first {
                        Text("Detailed information for '\(topResult.identifier)' not available.")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
                Button(action: {
                    scanNavigationPath.append(ScanDestination.ingredients(image, mlResults.first?.identifier ?? "Unknown"))
                }) {
                    Text("Next: Recommendations")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
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
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(title): \(Int(value * 100))%")
                .font(.headline)
            ProgressView(value: value)
                .progressViewStyle(LinearProgressViewStyle(tint: .purple))
                .frame(height: 10)
                .cornerRadius(5)
        }
        .padding(.vertical, 6)
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
                    .foregroundColor(.accentColor)
                Text("Read About it Below:")
                VStack(alignment: .leading, spacing: 12) {
                    Text("About:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(condition.info)
                        .font(.body)
                }
                Link("Learn more from source", destination: URL(string: condition.sourceURL)!)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .padding(.top, 16)
                Text("Consult a healthcare provider for professional advice and treatment.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 16)
            }
            .padding()
        }
        .navigationTitle("\(condition.name) Info")
        .background(Color(UIColor.systemBackground))
    }
}
#Preview {
    ScanResults(image: UIImage(named: "Eczema"),
                mlResults: [PredictionResult(identifier: "Eczema", confidence: 0.95)],
                selectedTab: .constant(.scan),
                scanNavigationPath: .constant(NavigationPath()),
                showSaveSuccessMessage: .constant(false))
}


