//
//  ChatCellView.swift
//  MessagingApp
//
//  Created by Vlad Gradskiy on 18.02.2024.
//  

import SwiftUI

private enum Constants {
    
    static let topPadding: CGFloat = 8.0
    static let trailingPadding: CGFloat = 18
    static let leadingPadding: CGFloat = 16.0
    static let contentHeight: CGFloat = 74.0
    static let bottomSpacing: CGFloat = 4.5
    
    enum Image {
        static let spacing: CGFloat = 12.0
        static let height: CGFloat = 52.0
        static let topPadding: CGFloat = 4.0
    }
    
    enum ChatInfo {
        static let titleFont = Font.system(size: 17, weight: .semibold)
    }
    
    enum LastMessage {
        static let padding: CGFloat = 4.0
        static let trailingPadding: CGFloat = 14.0
        static let font = Font.system(size: 14)
        static let textColor = Color.secondary
        static let heigth: CGFloat = 42
    }
    
    enum Date {
        static let font = Font.system(size: 14)
        static let textColor = Color.secondary
    }
    
    enum Arrow {
        static let image = Resources.Images.arrowRightIcon
        static let height: CGFloat = 12
        static let width: CGFloat = 7
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
            VStack(spacing: Constants.bottomSpacing) {
                HStack(spacing: 10) {
                    mainInfoView
                    arrowImage
                }
                .padding(.trailing, Constants.trailingPadding)
                Divider()
            }
        }
        .background(Rectangle().fill(Color.white))
        .padding(.top, Constants.topPadding)
        .padding(.leading, Constants.leadingPadding)
        .frame(height: Constants.contentHeight, alignment: .top)
    }
    
    private var mainInfoView: some View {
        VStack(spacing: .zero) {
            topInfoView
            lastMessageView
                .frame(maxHeight: .infinity, alignment: .center)
        }
    }
    
    private var imageView: some View {
        Circle()
            .fill(.indigo)
            .frame(width: Constants.Image.height, height: Constants.Image.height)
            .overlay {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundStyle(.white)
                    .padding(9)
            }
            .padding(.top, Constants.Image.topPadding)
    }
    
    private var topInfoView: some View {
        HStack(spacing: .zero) {
            Text(chatRoomInfo.name)
                .font(Constants.ChatInfo.titleFont)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(formatDate(lastMessage.date) ?? "")
                .font(Constants.Date.font)
                .foregroundColor(Constants.Date.textColor)
                .lineLimit(1)
        }
    }
    
    private var lastMessageView: some View {
        lastMessageText
            .font(Constants.LastMessage.font)
            .foregroundColor(Constants.LastMessage.textColor)
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .padding(.trailing, Constants.LastMessage.trailingPadding)
    }
    
    @ViewBuilder
    private var lastMessageText: some View {
        if lastMessage.type == .voice {
            HStack(spacing: .zero) {
                Image(lastMessage.type.iconName)
                Text(" ")
                Text(lastMessage.displayedInfo)
            }
        } else {
            (
                Text(Image(lastMessage.type.iconName))
                + Text(" ")
                + Text(lastMessage.displayedInfo)
            )
        }
    }
    
    private var arrowImage: some View {
        Image(Constants.Arrow.image)
            .resizable()
            .frame(
                width: Constants.Arrow.width,
                height: Constants.Arrow.height
            )
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
