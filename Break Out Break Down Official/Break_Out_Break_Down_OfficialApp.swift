//
//  Break_Out_Break_Down_OfficialApp.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/9/25.
//

import SwiftUI
import SwiftData

@main
struct Break_Out_Break_Down_OfficialApp: App {
    var body: some Scene {
        WindowGroup {
            BreakoutBreakdownView()
        }
        //storing saved photo data to have access in the history tab (environment)
        .modelContainer(for: SavedPhoto.self)
    }
}
