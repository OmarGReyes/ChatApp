//
//  ContentView.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/10/23.
//

import SwiftUI

struct ChatScreen: View {
    @State private var message: String = ""
    @ObservedObject var messageManager: MessageManager
    let user: User
    
    var body: some View {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messageManager.getMessageByUserId(userId: user.userId)) { message in
                            MessageView(message: message)
                        }
                    }
                    .onChange(of: messageManager.messages) { messages in
                        guard let id = messageManager.messages.last?.id else { return }
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                }
                ChatScreenTextField(messageManager: messageManager, userId: user.userId)
            }
            .navigationTitle(Text(user.name))
    }
}

extension ChatScreen {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen(messageManager: MessageManager(), user: User.sampleUsers[0])
    }
}
