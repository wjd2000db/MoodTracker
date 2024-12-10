//
//  ContentView.swift
//  MoodTracker
//
//  Created by Yujin on 12/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var menu: Tab = .home
    enum Tab {
        case home
        case list
        case calendar
    }
    
    var body: some View {
        TabView(selection: $menu){
            AddDiaryView()
                .tabItem{
                    Label(LocalizedStringKey("New"), systemImage: "note.text")
                }
                .tag(Tab.home)
            
            DiaryRow()
                .tabItem{
                    Label(LocalizedStringKey("List"), systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
    }
}

#Preview {
    ContentView()
}
