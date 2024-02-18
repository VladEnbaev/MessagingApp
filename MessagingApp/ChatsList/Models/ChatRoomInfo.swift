//
//  ChatRoomInfo.swift
//  MessagingApp
//
//  Created by Vlad Gradskiy on 18.02.2024.
//  


import Foundation


public struct ChatRoomInfo: Decodable, Equatable {
    public let id: Int
    public let name: String
    public let pictureName: String // this is bad
    public var lastMessage: Message
}

extension ChatRoomInfo {
    static let mocChatRooms: [ChatRoomInfo] = [
        ChatRoomInfo(id: 1, name: "Andrew Parker", pictureName: "room1_picture", lastMessage: Message(id: 1, type: .text, displayedInfo: "Hello!", date: Date())),
        ChatRoomInfo(id: 2, name: "Emily Johnson", pictureName: "room2_picture", lastMessage: Message(id: 2, type: .photo, displayedInfo: "photo.jpg", date: Date())),
        ChatRoomInfo(id: 3, name: "Michael Davis", pictureName: "room3_picture", lastMessage: Message(id: 3, type: .voice, displayedInfo: "0:35", date: Date())),
        ChatRoomInfo(id: 4, name: "Sophia Brown", pictureName: "custom_picture", lastMessage: Message(id: 4, type: .text, displayedInfo: "How are you? I'm doing great, thanks for asking! How are your family? How are your dog?", date: Date())),
        ChatRoomInfo(id: 5, name: "David Wilson", pictureName: "custom_picture", lastMessage: Message(id: 5, type: .photo, displayedInfo: "photo2.jpg", date: Date())),
        ChatRoomInfo(id: 6, name: "Emma Martinez", pictureName: "custom_picture", lastMessage: Message(id: 6, type: .voice, displayedInfo: "1:10", date: Date())),
        ChatRoomInfo(id: 7, name: "Olivia Rodriguez", pictureName: "custom_picture", lastMessage: Message(id: 7, type: .text, displayedInfo: "How's it going?", date: Date())),
        ChatRoomInfo(id: 8, name: "Ethan Taylor", pictureName: "custom_picture", lastMessage: Message(id: 8, type: .photo, displayedInfo: "photo3.jpg", date: Date())),
        ChatRoomInfo(id: 9, name: "Ava Moore", pictureName: "custom_picture", lastMessage: Message(id: 9, type: .voice, displayedInfo: "0:45", date: Date())),
        ChatRoomInfo(id: 10, name: "William Clark", pictureName: "custom_picture", lastMessage: Message(id: 10, type: .text, displayedInfo: "Nice to meet you!", date: Date()))
    ]
}
