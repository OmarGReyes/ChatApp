//
//  CustomUserBar.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/12/23.
//

import SwiftUI

struct CustomUserBar: View {
//    @Binding var shouldShowLogout: Bool
//    @Binding var isUserCurrentlyLoggedOut: Bool
    var userName: String?
    var imageURL: String?
    var logOutCallback: (() -> Void)?
    var logInCallback: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 16) {
            if let imageURL {
                AsyncImage(url: URL(string: imageURL)) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 70, maxHeight: 70)
                    } else if phase.error != nil {
                        Image(systemName: "person.fill")
                            .font(.system(size: 34, weight: .heavy))
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "person.fill")
                            .font(.system(size: 34, weight: .heavy))
                            .foregroundColor(.blue)
                    }
                }
            } else {
                Image(systemName: "person.fill")
                    .font(.system(size: 34, weight: .heavy))
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(userName ?? "")
                    .font(.system(size: 24, weight: .bold))
                HStack {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.green)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                }
            }
            Spacer()
            Button {
//                shouldShowLogout.toggle()
            } label: {
                Image(systemName: "gear")
            }
        }
        .padding()
        // Add this to mainView later
//        .confirmationDialog("Settings", isPresented: $shouldShowLogout, actions: {
//            VStack {
//                Button(role: .destructive) {
//                    logOutCallback?()
//                } label: {
//                    Text("Log out")
//                }
//            }
//        }, message: {
//            VStack {
//                Text("Settings\n What do you want to do?")
//            }
//        })
    }
}

struct CustomUserBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomUserBar()
    }
}
