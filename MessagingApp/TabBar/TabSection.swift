//
//  TabSection.swift
//  MessagingApp
//
//  Created by Vlad Gradskiy on 19.02.2024.
//  


import Foundation

public enum TabSection: CaseIterable {
    case status
    case calls
    case camera
    case chats
    case settings
    
    
    var iconName: String {
        switch self {
        case .status:
            return "statusTabIcon"
        case .calls:
            return "callsTabIcon"
        case .camera:
            return "cameraTabIcon"
        case .chats:
            return "chatsTabIcon"
        case .settings:
            return "settingsTabIcon"
        }
    }

    var tabTitle: String {
        switch self {
        case .status:
            return "Status"
        case .calls:
            return "Calls"
        case .camera:
            return "Camera"
        case .chats:
            return "Chats"
        case .settings:
            return "Settings"
        }
    }
}
