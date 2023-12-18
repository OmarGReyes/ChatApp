//
//  ChatUsersList.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/10/23.
//

import SwiftUI

struct ChatUsersScreen: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ChatUsersScreenViewModel
    @State var isPresentingUserListSheet = false
    var body: some View {
        
        if viewModel.state == .loading {
            // TODO: Replace this with a splashView or something
            Color.black.task {
                await viewModel.fetchUsers()
            }
        } else {
            Group {
                if !viewModel.isAnyChatAvailable() {
                    EmptyChatView(isPresentingUserListSheet: $isPresentingUserListSheet)
                } else {
                    NavigationStack {
                        List(viewModel.sortedUsers()) { user in
                            NavigationLink(destination: ChatScreen(
                                chatScreenViewModel: viewModel.createChatScreenViewModel(user: user), messageSent: {
                                    Task {
                                        await viewModel.fetchUsers()
                                    }
                                })) {
                                    UserListCell(name: user.name,
                                                 lastMessage: user.lastMessage,
                                                 lastMessageHour: user.lastInteractionHour)
                                }
                        }.toolbar {
                            Button("New chat") {
                                isPresentingUserListSheet.toggle()
                            }
                            
                            Button("Log out", role: .destructive) {
                                viewModel.logOut()
                                dismiss()
                            }
                        }
                    }.overlay(alignment: .bottom, content: {
                        NewMessageButton() {
                            isPresentingUserListSheet.toggle()
                        }
                    })
                }
            }.sheet(isPresented: $isPresentingUserListSheet) {
                ContactsScreenView(viewModel: viewModel)
            }
        }
    }
}

//struct ChatUsersScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatUsersScreen(viewModel: ChatUsersScreenViewModel(persistenceController: PersistenceController.shared))
//    }
//}
