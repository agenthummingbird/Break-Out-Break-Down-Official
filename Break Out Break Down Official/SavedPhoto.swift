//
//  SavedPhoto.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/16/25.
//

import Foundation
import SwiftUI
import SwiftData
import UIKit

@Model
class SavedPhoto {
    var data: Data
    var date: Date
    var predictedCondition: String // New property to store the predicted condition

    init(data: Data, date: Date, predictedCondition: String) {
        self.data = data
        self.date = date
        self.predictedCondition = predictedCondition
    }
}
