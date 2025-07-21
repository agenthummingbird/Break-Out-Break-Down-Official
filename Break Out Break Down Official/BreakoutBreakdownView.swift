//
//  ContentView.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/9/25.
//

import SwiftUI
import SwiftData

struct BreakoutBreakdownView: View {
    
    // Defines enum for different tabs in app
    enum Tab: Hashable { // Hashable allows cases to be used as tags for TabView items so they can be selected
        case home
        case scan
        case history
        case info
    }

    @State private var selectedTab: Tab = .home // App starts on the Home tab
    @State private var showSaveSuccessMessage: Bool = false

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeTab(showSaveSuccessMessage: $showSaveSuccessMessage)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(Tab.home)
            ScanTab(selectedTab: $selectedTab, showSaveSuccessMessage: $showSaveSuccessMessage)
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Scan")
                }
                .tag(Tab.scan)
            HistoryTab()
                .tabItem {
                    Image(systemName: "text.document.fill")
                    Text("History")
                }
                .tag(Tab.history)
            InfoTab()
                .tabItem {
                    Image(systemName: "info.square.fill")
                    Text("Information")
                }
                .tag(Tab.info)
        }
    }
}

#Preview {
    BreakoutBreakdownView()
}
