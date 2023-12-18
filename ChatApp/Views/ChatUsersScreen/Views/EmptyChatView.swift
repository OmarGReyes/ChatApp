//
//  EmptyChatView.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 23/10/23.
//

import SwiftUI

struct EmptyChatView: View {
    @Binding var isPresentingUserListSheet: Bool
    var body: some View {
        VStack {
            Text("Start to chat")
                .font(.title)
            Button {
                isPresentingUserListSheet.toggle()
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct EmptyChatView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyChatView(isPresentingUserListSheet: .constant(false))
    }
}
