//
//  ContentView.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/10/23.
//

import SwiftUI

struct ChatScreen: View {
    @State private var message: String = ""
    @ObservedObject var chatUserScreenViewModel: ChatUserScreenViewModel
    let user: User
    
    var body: some View {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(chatUserScreenViewModel.getMessagesByUserId(userId: user.userId)) { message in
                            MessageView(message: message)
                        }
                    }
                    .onChange(of: chatUserScreenViewModel.messages) { messages in
                        gotoLastMessage(proxy: proxy)
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .onAppear {
                        gotoLastMessage(proxy: proxy)
                    }
                }
                ChatScreenTextField(chatUserScreenViewModel: chatUserScreenViewModel, userId: user.userId)
            }
            .navigationTitle(Text(user.name))
    }
    
    private func gotoLastMessage(proxy: ScrollViewProxy) {
        guard let id = chatUserScreenViewModel.getMessagesByUserId(userId: user.userId).last?.id else { return }
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

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen(chatUserScreenViewModel: ChatUserScreenViewModel(messageManager: MessageManager()), user: User.sampleUsers[0])
    }
}
