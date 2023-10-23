//
//  UserListCell.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/10/23.
//

import SwiftUI

struct UserListCell: View {
    let name: String
    let lastMessage: String
    let lastMessageHour: String
    var body: some View {
        HStack {
            Image(systemName: "star")
            VStack(alignment: .leading) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(lastMessage)
                    .font(.caption2)
            }
            Spacer()
            Text(lastMessageHour)
                .font(.caption)
        }
        .padding(.vertical, 4)
    }
}

struct UserListCell_Previews: PreviewProvider {
    static var previews: some View {
        UserListCell(name: "Omar", lastMessage: "¿Qué más?", lastMessageHour: "12:30")
    }
}
