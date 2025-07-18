//
//  SavedPhoto.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/16/25.
//

import Foundation
import SwiftUI
import SwiftData

@Model

class SavedPhoto {
    var photo: UIImage
    var date: Date
    //let skinCondition: //make a new file for skin condition identification
    
    init(photo: UIImage, date: Date){
        self.photo = photo
        self.date = date
        
    }
 
}

