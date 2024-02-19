//
//  MainTabBarView.swift
//  MessagingApp
//
//  Created by Vlad Gradskiy on 18.02.2024.
//  


import SwiftUI

struct MainTabBarView: View {
    
    @State var selectedTab: TabSection = .chats
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabSection.allCases, id: \.hashValue) { tab in
                createScene(for: tab)
                    .tag(tab)
                    .tabItem {
                        Image(tab.iconName).renderingMode(.template)
                        Text(tab.tabTitle)
                    }
            }
        }
    }
    
    @ViewBuilder
    func createScene(for tab: TabSection) -> some View {
        switch tab {
        case .status:
            Color.white
        case .calls:
            Color.white
        case .camera:
            Color.white
        case .chats:
            ChatsListBuilder.createChatListScene()
        case .settings:
            Color.white
        }
    }
}
