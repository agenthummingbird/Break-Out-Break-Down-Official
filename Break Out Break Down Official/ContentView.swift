//
//  ContentView.swift
//  Break Out Break Down Official
//
//  Created by 43GOParticipant on 7/9/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView { // NAVIGATION BAR
            homeTab()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            scanTab()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Scan")
                }
            historyTab()
                .tabItem {
                    Image(systemName: "text.document.fill")
                    Text("History")
                }
            infoTab()
                .tabItem {
                    Image(systemName: "info.square.fill")
                    Text("Information")
                }
        }
    }
}

#Preview {
    ContentView()
}
