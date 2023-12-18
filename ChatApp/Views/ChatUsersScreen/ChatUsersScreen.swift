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
            CustomUserBar(userName: viewModel.user?.name ?? "", imageURL: viewModel.user?.imageURL ?? "")
            Color.black.task {
                await viewModel.fetchUsers()
            }
        } else {
            Group {
                if !viewModel.isAnyChatAvailable() {
                    VStack {
                        CustomUserBar(userName: viewModel.user?.name ?? "", imageURL: viewModel.user?.imageURL ?? "")
                        EmptyChatView(isPresentingUserListSheet: $isPresentingUserListSheet)
                    }.task {
                        await viewModel.fetchCurrentUserInfo()
                    }
                } else {
                    NavigationStack {
                        CustomUserBar(userName: viewModel.user?.name ?? "", imageURL: viewModel.user?.imageURL ?? "")
                        UsersListView(isPresentingUserListSheet: $isPresentingUserListSheet,
                                      usersList: viewModel.sortedUsers(),
                                      chatScreenViewModel: viewModel.createChatScreenViewModel(user:),
                                      fetchUsers: {
                            Task {
                                await viewModel.fetchUsers()
                            }
                        }).toolbar {
                            Button("Log out", role: .destructive) {
                                viewModel.logOut()
                                dismiss()
                            }
                        }
                    }.task {
                        await viewModel.fetchCurrentUserInfo()
                    }
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
