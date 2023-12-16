//
//  ContentView.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/10/23.
//

import SwiftUI

// TODO: - Sobreescribir navigation y colocar acción a back button
// TODO: - UnitTesting a viewModel y echar ojo a UITesting
// TODO: - Sign in y sign uop with firebase
struct ChatScreen: View {
    @State private var message: String = ""
    @ObservedObject var chatScreenViewModel: ChatScreenViewModel
    var messageSent: (() -> Void)?
    
    var body: some View {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(chatScreenViewModel.messages) { message in
                            MessageView(message: message)
                        }
                    }
                    .onChange(of: chatScreenViewModel.messages) { messages in
                        gotoLastMessage(proxy: proxy)
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .onAppear {
                        gotoLastMessage(proxy: proxy)
                    }
                }
                ChatScreenTextField(chatScreenViewModel: chatScreenViewModel,
                                    userId: chatScreenViewModel.user.userId) {
                    messageSent?()
                }
            }
            .task {
                await chatScreenViewModel.fetchMessages()
            }
            .navigationTitle(Text(chatScreenViewModel.user.name))
    }
    
    private func gotoLastMessage(proxy: ScrollViewProxy) {
        guard let id = chatScreenViewModel.messages.last?.id else { return }
        withAnimation {
            proxy.scrollTo(id, anchor: .bottom)
        }
    }
}

extension ChatScreen {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//struct ChatScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatScreen(chatScreenViewModel: ChatScreenViewModel(user: User.sampleUsers.first!), messageSent: nil)
//    }
//}
