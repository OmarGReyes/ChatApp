//
//  UsersListView.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/12/23.
//

import SwiftUI

struct UsersListView: View {
    @Binding var isPresentingUserListSheet: Bool
    var usersList: [User]
    var chatScreenViewModel: (User) -> ChatScreenViewModel
    var fetchUsers: () async -> Void
    var body: some View {
        List(usersList) { user in
            NavigationLink(destination: ChatScreen(
                chatScreenViewModel: chatScreenViewModel(user), messageSent: {
                    Task {
                        await fetchUsers()
                    }
                })) {
                    UserListCell(name: user.name,
                                 lastMessage: user.lastMessage,
                                 lastMessageHour: user.lastInteractionHour)
                }
        }.overlay(alignment: .bottom, content: {
            NewMessageButton() {
                isPresentingUserListSheet.toggle()
            }
        })
    }
}

//struct UsersListView_Previews: PreviewProvider {
//
//    class MockMessageRepositoryProtocol: MessageRepositoryProtocol {
//        func fetchMessagesForUser(_ user: User) async throws -> [Message] {
//            []
//        }
//
//        func addMessage(_ message: Message) async {
//            // TODO: Nothing
//        }
//
//        func updateUserLastInteraction(userId: String, timestamp: Date, message: String) async {
//            // TODO: Nothing
//        }
//
//
//    }
//
//    static var previews: some View {
//        UsersListView(usersList: [], chatScreenViewModel: ChatScreenViewModel(user: User(name: "", imageURL: "", userId: ""), repository: MockMessageRepositoryProtocol()), fetchUsers: {})
//    }
//}
