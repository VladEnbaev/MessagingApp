//
//  ChatsListBuilder.swift
//  MessagingApp
//
//  Created by Vlad Gradskiy on 18.02.2024.
//  


import SwiftUI


public struct ChatsListBuilder {
    
    private init() {}
    
    public static func createChatListScene() -> ChatListSceneView {
        let viewModel = ChatsListViewModel()
        let scene = ChatListSceneView(viewModel: viewModel)
        return scene
    }
}
