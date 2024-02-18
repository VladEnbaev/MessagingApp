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
    public let hexColor: String
    public let pictureId: Int
    public let users: [Int]
    public var lastMessage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case hexColor = "color"
        case pictureId = "picture"
        case users
        case lastMessage
    }
}
