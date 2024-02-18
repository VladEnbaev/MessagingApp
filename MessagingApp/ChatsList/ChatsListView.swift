//
//  ChatsListView.swift
//  MessagingApp
//
//  Created by Vlad Gradskiy on 18.02.2024.
//

import SwiftUI

private enum Constants {
    
    static let bottomPadding: CGFloat = 100.0
    
    
    enum Title {
        static let text = "Chats"
    }
    
    enum TopButtons {
        static let titleL = "Broadcast Lists"
        static let titleR = "New Group"
        static let foregroundColor = Color.blue
        static let vPadding: CGFloat = 12
        static let hPadding: CGFloat = 16
    }
    
    enum EmptyLabel {
        static let text = "Сhatrooms have not been created yet"
        static let font = Font.system(size: 17)
    }
    
    enum EditButton {
        static let text = "Edit"
        static let size: CGFloat = 22.15
    }
    
    enum NewMessageButton {
        static let iconName = Resources.Images.editIcon
    }
}

public struct ChatListSceneView: View {
    
    @StateObject var viewModel: ChatsListViewModel
    
    init(viewModel: ChatsListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Life Cycle
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: .zero) {
                topButtonsView
                chatsView
            }
            .padding(.bottom, Constants.bottomPadding)
        }
        .safeAreaInset(edge: .top, content: { header })
        .onAppear {
            viewModel.action.send(.performInitialRequests)
        }
        .onAppear(firstAppearAction: {
            viewModel.action.send(.performInitialRequests)
        }, reAppearAction: {
            viewModel.action.send(.refresh)
        })
    }
    
    var topButtonsView: some View {
        HStack {
            Button(Constants.TopButtons.titleL) {
                //action
            }
            Spacer()
            Button(Constants.TopButtons.titleR) {
                //action
            }
        }
        .padding(.vertical, Constants.TopButtons.vPadding)
        .padding(.horizontal, Constants.TopButtons.hPadding)
    }
    
    @ViewBuilder
    var chatsView: some View {
        if viewModel.state.chatRooms.isEmpty {
            Text(Constants.EmptyLabel.text)
                .font(Constants.EmptyLabel.font)
                .foregroundColor(Resources.Colors.secondaryText)
                .frame(maxWidth: .infinity)
                .padding(.top, 100)
        } else {
            ForEach(viewModel.state.chatRooms, id: \.id) { info in
                ChatCellView(chatRoomInfo: info)
                    .onTapGesture { viewModel.action.send(.chatTapped(info)) }
            }
        }
    }
    
    private var header: some View {
        VStack(spacing: 0) {
            NavigationHeader(title: Constants.Title.text) {
                Button {
                    // action
                } label: {
                    Image(Constants.NewMessageButton.iconName)
                }
                .frame(width: Constants.EditButton.size,
                       height: Constants.EditButton.size)
            } leadingContent: {
                Button(Constants.EditButton.text) {
                    print("Edit tapped!")
                }
            }
            Divider()
        }
        .background(Material.bar)
    }
}


#Preview {
    ChatsListBuilder.createChatListScene()
}
