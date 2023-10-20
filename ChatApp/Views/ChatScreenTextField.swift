//
//  ChatScreenTextField.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 19/10/23.
//

import SwiftUI

struct ChatScreenTextField: View {
    @State private var message: String = ""
    @Binding private(set) var messages: [Message]
    var body: some View {
        HStack {
            TextField("Enter text", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocorrectionDisabled(true)
                .keyboardType(.asciiCapable)
                .onSubmit {
                    messages.append(Message(message: message,
                                            received: false,
                                            timestamp: Date(), userId: ""))
                    message = ""
                }
            Button {
                messages.append(Message(message: message,
                                        received: false,
                                        timestamp: Date(), userId: ""))
                message = ""
                
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

struct ChatScreenTextField_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreenTextField(messages: .constant(Message.mockMessages))
    }
}
