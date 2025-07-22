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
        tabBarAppearance.backgroundColor = UIColor(red: 0.45, green: 0.27, blue: 0.39, alpha: 1.00)
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(red: 1.00, green: 0.97, blue: 0.95, alpha: 1.00)
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(red: 1.00, green: 0.97, blue: 0.95, alpha: 1.00)]
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 0.82, green: 0.56, blue: 0.73, alpha: 1.00)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(red: 0.82, green: 0.56, blue: 0.73, alpha: 1.00)]

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
