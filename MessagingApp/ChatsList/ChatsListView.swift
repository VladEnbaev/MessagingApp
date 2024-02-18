//
//  ChatsListView.swift
//  MessagingApp
//
//  Created by Vlad Gradskiy on 18.02.2024.
//

import SwiftUI

private enum Constants {
    
    enum Title {
        static let text = "Chats"
    }
    
    enum TopButtons {
        static let titleLists = "Broadcast Lists"
        static let titleGroup = "New Group"
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
        }
        .refreshable {
            viewModel.action.send(.refresh)
        }
        .scrollContentBackground(.visible)
        .safeAreaInset(edge: .top, content: { header })
        .onAppear(firstAppearAction: {
            viewModel.action.send(.performInitialRequests)
        }, reAppearAction: {
            viewModel.action.send(.refresh)
        })
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
    
    var topButtonsView: some View {
        HStack {
            Button(Constants.TopButtons.titleLists) {
                print("Lists Tapped!")
            }
            Spacer()
            Button(Constants.TopButtons.titleGroup) {
                print("Group Tapped!")
            }
        }
        .padding(.vertical, Constants.TopButtons.vPadding)
        .padding(.horizontal, Constants.TopButtons.hPadding)
        .background(.white)
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
                    .addSwipeAction(edge: .trailing) {
                        HStack(spacing: .zero) {
                            moreButton
                            archiveButton
                        }
                    }
            }
            .background(.white)
        }
    }
    
    var archiveButton: some View {
        Button {
            print("Archive Tapped!")
        } label: {
            VStack(spacing: 6) {
                Image(Resources.Images.archiveIcon)
                Text("Archive")
                    .font(.system(size: 14))
            }
        }
        .frame(width: 74)
        .frame(maxHeight: .infinity)
        .foregroundStyle(.white)
        .background(Color("buttonBlue"))
    }
    
    var moreButton: some View {
        Button {
            print("More Tapped!")
        } label: {
            VStack(spacing: 6) {
                Image(Resources.Images.moreIcon)
                Text("More")
                    .font(.system(size: 14))
            }
        }
        .frame(width: 74)
        .frame(maxHeight: .infinity)
        .foregroundStyle(.white)
        .background(Color("buttonGrey"))
    }
}


#Preview {
    ChatsListBuilder.createChatListScene()
}
