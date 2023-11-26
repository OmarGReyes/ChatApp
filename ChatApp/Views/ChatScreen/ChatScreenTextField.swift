//
//  ChatScreenTextField.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 19/10/23.
//

import SwiftUI

struct ChatScreenTextField: View {
    @State private var message: String = ""
    @ObservedObject private(set) var chatScreenViewModel: ChatScreenViewModel
    var userId: String
    var messagedSent: (() -> Void)?
    var body: some View {
        HStack {
            TextField("Enter text", text: $message, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocorrectionDisabled(true)
                .keyboardType(.alphabet)
                .onSubmit {
                    guard !message.isEmpty else { return }
                    Task {
                        let date = Date()
                        await chatScreenViewModel.addMessage(message: Message(message: message,
                                                                   received: false,
                                                                   timestamp: date,
                                                                   userId: userId))
                        message = ""
                        messagedSent?()
                    }
                }
            Button {
                Task {
                    let date = Date()
                    await chatScreenViewModel.addMessage(message: Message(message: message,
                                                               received: false,
                                                               timestamp: date,
                                                               userId: userId))
                    message = ""
                    messagedSent?()
                }
            } label: {
                Image(systemName: "paperplane")
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .background(message.isEmpty ? .gray : .blue)
                    .clipShape(Circle())
            }
            .disabled(message.isEmpty)
            
        }
        .padding(.horizontal)

    }
}

//struct ChatScreenTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        let user = User.sampleUsers.first!
//        ChatScreenTextField(chatScreenViewModel: ChatScreenViewModel(user: user), userId: user.userId)
//    }
//}
