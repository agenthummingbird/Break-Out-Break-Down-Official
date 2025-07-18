//
//  ContentView.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/9/25.
//

import SwiftUI

struct BreakoutBreakdownView: View {
    var body: some View {
        TabView { // Navigation bar
            HomeTab()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            ScanTab()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Scan")
                }
            HistoryTab()
                .tabItem {
                    Image(systemName: "text.document.fill")
                    Text("History")
                }
            InfoTab()
                .tabItem {
                    Image(systemName: "info.square.fill")
                    Text("Information")
                }
        }
    }
}

#Preview {
    BreakoutBreakdownView()
}
