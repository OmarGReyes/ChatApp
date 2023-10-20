//
//  ContentView.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/10/23.
//

import SwiftUI

struct ChatScreen: View {
    
    @State private var messages = Message.mockMessages
    @State private var message: String = ""
    
    var body: some View {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messages) { message in
                            MessageView(message: message)
                        }
                    }
                    .onChange(of: messages) { messages in
                        guard let id = messages.last?.id else { return }
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                }
                ChatScreenTextField(messages: $messages)
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
        ChatScreen()
    }
}
