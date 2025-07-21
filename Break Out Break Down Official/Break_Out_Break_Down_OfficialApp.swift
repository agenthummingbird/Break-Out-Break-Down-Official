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
    
    init() { // Initializer - configuration that affects entire app's UI
        let tabBarAppearance = UITabBarAppearance() // Create object to customize visuals of tab bar
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.systemGray6
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.purple
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.purple]
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    
    var body: some Scene {
        WindowGroup {
            BreakoutBreakdownView()
        }
        // Storing saved photo data to have access in the history tab (environment)
        .modelContainer(for: SavedPhoto.self)
    }
}
