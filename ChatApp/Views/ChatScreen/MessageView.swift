//
//  MessageView.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/10/23.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    @State private var displayHour: Bool = false
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing) {
            HStack {
                Text(message.message)
                    .font(.system(size: 15))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.all, 12)
            }
            .background {
                Color(message.received ? .lightGray : .systemBlue)
                    .cornerRadius(15)
            }
            .frame(minWidth: 15, maxWidth: 300, alignment: alignment)
            
            if displayHour {
                Text(message.hour)
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding(.top, 0)
            }
        }
        .frame(maxWidth: .infinity, alignment: alignment)
        .padding( alignment == .leading ? .leading : .trailing, 4)
        .onTapGesture {
            displayHour.toggle()
        }
    }
    
    private var alignment: Alignment {
        message.received ? .leading : .trailing
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(
            message: "Hola sdjfsskdjfhsdkjfhsdkfhlsdfhdsflskdfhsdlkfsdklfjhdsjkfhlkxjvxcklvjlvxkjcvh",
            received: true,
            timestamp: Date(), userId: ""))
    }
}
