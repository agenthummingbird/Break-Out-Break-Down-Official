//
//  ScanData.swift
//  Break Out Break Down Official
//
//  Created by 46GOParticipant on 7/17/25.
//
/*
import Foundation
import SwiftUI

struct ScanHistoryEntry: Codable, Identifiable {
    let id = UUID()
    let imageFilename: String
    let diagnosis: String
    let date: String
}

class ScanHistoryManager: ObservableObject {
    @Published var history: [ScanHistoryEntry] = []

    private let fileURL: URL

    init() {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        fileURL = docs.appendingPathComponent("scan_history.json")
        loadHistory()
    }

    func addScan(image: UIImage, diagnosis: String) {
        let filename = UUID().uuidString + ".jpg"
        let imageURL = fileURL.deletingLastPathComponent().appendingPathComponent(filename)
        
        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: imageURL)
        }

        let entry = ScanHistoryEntry(
            imageFilename: filename,
            diagnosis: diagnosis,
            date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)
        )

        history.append(entry)
        saveHistory()
    }

    func loadHistory() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([ScanHistoryEntry].self, from: data) {
            self.history = decoded
        }
    }

    func saveHistory() {
        if let data = try? JSONEncoder().encode(history) {
            try? data.write(to: fileURL)
        }
    }

    func loadImage(filename: String) -> UIImage? {
        let path = fileURL.deletingLastPathComponent().appendingPathComponent(filename)
        return UIImage(contentsOfFile: path.path)
    }
}
*/
