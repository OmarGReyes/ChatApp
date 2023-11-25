//
//  ContactsScreenView.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 3/11/23.
//

import SwiftUI

struct ContactsScreenView: View {
    @ObservedObject var viewModel: ChatUsersScreenViewModel
    @State var newUserName: String = ""
    var body: some View {
        NavigationStack {
            if viewModel.users.isEmpty {
                AddNewUserScreen(viewModel: viewModel)
            } else {
                List(viewModel.sortedUsersAlphabetically()) { user in
                    NavigationLink(destination:
                                    ChatScreen(chatScreenViewModel: viewModel.createChatScreenViewModel(user: user),
                                               messageSent: {
                        Task {
                            await viewModel.fetchUsers()
                        }
                    })) {
                        UserListCell(name: user.name,
                                     lastMessage: user.lastMessage,
                                     lastMessageHour: user.lastInteractionHour,
                                     isNewChatList: true)
                    }.swipeActions {
                        Button {
                            viewModel.deleteUser(user: user)
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                    }

                }
                AddNewUserScreen(viewModel: viewModel)
            }
        }
    }
}

extension ContactsScreenView {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//struct ContactsScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactsScreenView(viewModel: ChatUsersScreenViewModel(persistenceController: PersistenceController.shared))
//    }
//}
