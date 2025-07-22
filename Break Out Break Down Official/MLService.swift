//
//  SkinConditionClassifier.swift
//  Break Out Break Down Official
//
//  Created by 46GOParticipant on 7/20/25.
//
import Foundation
import CoreML
import UIKit
import Vision
class MLService {
    private var model: SkinDiseaseImageClassifier? // Holds ML model
    init() {
        do {
            // Instantiate ML Model
            self.model = try SkinDiseaseImageClassifier(configuration: MLModelConfiguration())
        } catch {
            print("Error initializing Core ML model: \(error)")
        }
    }
    // Function for predicting skin condition using UIImage
    func predictSkinCondition(image: UIImage, completion: @escaping ([PredictionResult]?, Error?) -> Void) {
        guard let model = model else { // Initialize ML model - otherwise (if initilization fails) call completion handler
            completion(nil, NSError(domain: "MLServiceError", code: 500, userInfo: [NSLocalizedDescriptionKey: "ML Model not initialized."]))
            return
        }
        
        // Resize imput image dimensions according to ML model's expected input size
        guard let resizedImage = image.resized(to: CGSize(width: 299, height: 299)),
              let ciImage = CIImage(image: resizedImage) else { // Vision requires CIImage
            completion(nil, NSError(domain: "MLServiceError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to process image."]))
            return
        }
        // Uses ML model to perform image classification
        let request = VNCoreMLRequest(model: try! VNCoreMLModel(for: model.model)) { request, error in // VNCoreMLRequest creates Vision model from ML model instance
            if let error = error { // Handle errors
                completion(nil, error)
                return
            }
            // Makes sure results are of expected type (skin condition & accuracy percentage)
            guard let observations = request.results as? [VNClassificationObservation] else {
                completion(nil, NSError(domain: "MLServiceError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to get classification results."]))
                return
            }
            let sortedResults = observations.sorted(by: { $0.confidence > $1.confidence })
            let topResults = sortedResults.prefix(3).map { observation in
                // Cast VNConfidence Float to Double
                PredictionResult(identifier: observation.identifier, confidence: Double(observation.confidence))
            }
            completion(topResults, nil)
        }
        // Performs image analysis
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                completion(nil, error)
            }
        }
    }
}
struct PredictionResult { // Holds prediction results
    let identifier: String // Skin condition
    let confidence: Double // Accuracy percentage
}
extension UIImage { // UIImage extension for resizing
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}


