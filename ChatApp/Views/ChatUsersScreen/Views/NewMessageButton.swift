//
//  NewMessageButton.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/12/23.
//

import SwiftUI

import SwiftUI

struct NewMessageButton: View {
    var buttonAction: (() -> Void)?
    var body: some View {
        Button {
            buttonAction?()
        } label: {
            Text("New message")
                .font(.system(size: 16, weight: .semibold))
                .padding(12)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
                .padding()
                .shadow(radius: 15)
        }
    }
}

struct NewMessageButton_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageButton()
    }
}
