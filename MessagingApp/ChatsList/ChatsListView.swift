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
        static let text = "Chat"
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
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: .zero) {
                    chatsView
                }
                .padding(.bottom, Constants.bottomPadding)
            }
        }
        .navigationTitle(Constants.Title.text)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(Constants.EditButton.text) {
                    print("Help tapped!")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // action
                } label: {
                    Image(Constants.NewMessageButton.iconName)
                }

            }
        }
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
            
            Button(Constants.TopButtons.titleR) {
                //action
            }
        }
        .background(Color.white)
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
//                ChatCellView(chatRoomInfo: info)
//                    .onTapGesture { viewModel.action.send(.chatTapped(info)) }
            }
        }
    }
}


#Preview {
    ChatsListBuilder.createChatListScene()
}
