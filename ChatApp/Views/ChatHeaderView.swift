//
//  ChatHeaderView.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/10/23.
//

import SwiftUI

struct ChatHeaderView: View {
    var body: some View {
        NavigationView {
            HStack {
                Image(systemName: "star")
                VStack(alignment: .leading) {
                    Text("Omar")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text("Online")
                        .font(.caption2)
                }
                Spacer()
                Image(systemName: "info.circle")
            }
        }
    }
}

struct ChatHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ChatHeaderView()
    }
}
