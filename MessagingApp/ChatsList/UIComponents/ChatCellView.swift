//
//  ChatCellView.swift
//  MessagingApp
//
//  Created by Vlad Gradskiy on 18.02.2024.
//  

import SwiftUI

private enum Constants {
    
    static let topPadding: CGFloat = 10.0
    static let bottomSpacing: CGFloat = 8.0
    static let trailingPadding: CGFloat = 8.30
    static let leadingPadding: CGFloat = 17.0
    static let contentHeight: CGFloat = 67.0
    
    enum Image {
        static let spacing: CGFloat = 12.0
        static let height: CGFloat = 45.0
        static let topPadding: CGFloat = 4.0
    }
    
    enum ChatInfo {
        static let titleFont = Font.system(size: 17, weight: .semibold)
    }
    
    enum LastMessage {
        static let padding: CGFloat = 4.0
        static let trailingPadding: CGFloat = 14.0
        static let font = Font.system(size: 13)
        static let textColor = Color.secondary
        static let heigth: CGFloat = 42
    }
    
    enum Arrow {
        static let image = Resources.Images.arrowRightIcon
        static let height: CGFloat = 16.5
        static let width: CGFloat = 22.0
    }
}

struct ChatCellView: View {
    
    private let chatRoomInfo: ChatRoomInfo
    private var lastMessage: Message {
        chatRoomInfo.lastMessage
    }
    
    init(chatRoomInfo: ChatRoomInfo) {
        self.chatRoomInfo = chatRoomInfo
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: Constants.Image.spacing) {
            imageView
                .padding(.top, Constants.Image.topPadding)
            VStack(spacing: Constants.bottomSpacing) {
                VStack(spacing: Constants.LastMessage.padding) {
                    topInfoView
                    messageInfoView
                }
                .frame(height: Constants.contentHeight, alignment: .top)
                Divider()
            }
        }
        .background(Rectangle().fill(Color.white))
        .padding(.top, Constants.topPadding)
        .padding(.leading, Constants.leadingPadding)
        .padding(.trailing, Constants.trailingPadding)
    }
    
    private var imageView: some View {
        Circle()
            .fill(.blue)
            .frame(width: Constants.Image.height, height: Constants.Image.height)
            .overlay {
                Image(systemName: "person.fill")
                    .resizable()
                    .padding(9)
            }
    }
    
    private var topInfoView: some View {
        HStack(spacing: .zero) {
            Text(chatRoomInfo.name)
                .font(Constants.ChatInfo.titleFont)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(formatDate(lastMessage.date) ?? "")
                .font(Constants.LastMessage.font)
                .foregroundColor(Constants.LastMessage.textColor)
                .lineLimit(1)
            Image(Constants.Arrow.image)
                .resizable()
                .frame(
                    width: Constants.Arrow.width,
                    height: Constants.Arrow.height
                )
        }
    }
    
    @ViewBuilder
    private var messageInfoView: some View {
        HStack(alignment: .top) {
            Text(lastMessage.content)
                .font(Constants.LastMessage.font)
                .foregroundColor(Constants.LastMessage.textColor)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .padding(.trailing, Constants.LastMessage.trailingPadding)
    }
    
    func formatDate(_ date: Date) -> String? {
        let calendar = Calendar.current
        let calendarComponents: Set<Calendar.Component> = [.day, .weekOfYear, .weekday, .year]
        
        let currentComponents = calendar.dateComponents(calendarComponents, from: Date())
        let timestampComponents = calendar.dateComponents(calendarComponents, from: date)
        
        if currentComponents.day == timestampComponents.day {
            return date.formatted(date: .omitted, time: .shortened)
        } else if currentComponents.weekOfYear == timestampComponents.weekOfYear {
            return date.formatted(.dateTime.weekday(.abbreviated))
        } else if currentComponents.year == timestampComponents.year {
            return String(date.formatted(date: .numeric, time: .omitted).dropLast(5))
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
}
