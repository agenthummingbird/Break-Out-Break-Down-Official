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
    //var photo: UIImage
    //var data: UIImage(data:data)
    var date: Date
    //let skinCondition: //make a new file for skin condition identification
    
    init(data: Data, date: Date){
        self.data = data
        //self.photo = photo
        self.date = date
        
    }
 
}

