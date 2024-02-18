//
//  Message.swift
//  MessagingApp
//
//  Created by Vlad Gradskiy on 18.02.2024.
//  


import Foundation


public struct Message: Decodable, Equatable {
    public let id: Int
    public let type: MessageType
    public let content: String
    public let date: Date
}

public enum MessageType: String, Decodable {
    case photo
    case voice
    case text
    
    var iconName: String {
        switch self {
        case .photo:
            return "photoMessageIcon"
        case .voice:
            return "voiceMessageIcon"
        case .text:
            return "readedMessageIcon"
        }
    }
}
