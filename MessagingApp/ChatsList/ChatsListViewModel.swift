//
//  ChatsListViewModel.swift
//  MessagingApp
//
//  Created by Vlad Gradskiy on 18.02.2024.
//

import SwiftUI
import Combine

final class ChatsListViewModel: ObservableObject {
    
    // MARK: Public Properties
    @Published private(set) var state = State()
    let action = PassthroughSubject<Action, Never>()
    
    // MARK: Private properties
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Init
    
    init() {
        action
            .sink(receiveValue: { [unowned self] in
                self.didChange($0)
            })
            .store(in: &subscriptions)
    }
    
    // MARK: Private Methods
    
    private func didChange(_ action: Action) {
        switch action {
        case .performInitialRequests:
            state.isLoading = true
            print("Loading...")
            fetchAllConversations()
        case .chatTapped(let chatroom):
            print(chatroom)
            break
        case .editButtonTapped:
            print("Edit Tapped!")
        case .newChatButtonTapped:
            print("New Tapped!")
        case .refresh:
            // TODO: - Create pagination
            print("Refreshing...")
            fetchAllConversations()
        }
    }
    
    private func fetchAllConversations() {
        Task(priority: .high) { @MainActor [unowned self] in
            do {
                try await Task.sleep(nanoseconds: 1000)
                state.chatRooms = ChatRoomInfo.mocChatRooms
                state.isLoading = false
            } catch {
                state.isLoading = false
            }
        }
    }
}

// MARK: - ViewModel Actions & State

extension ChatsListViewModel {
    
    enum Action {
        case performInitialRequests
        case chatTapped(ChatRoomInfo)
        case editButtonTapped
        case newChatButtonTapped
        case refresh
    }
    
    struct State {
        var viewHasAppeared = false
        var isLoading = true
        var chatRooms = [ChatRoomInfo]()
    }
}
