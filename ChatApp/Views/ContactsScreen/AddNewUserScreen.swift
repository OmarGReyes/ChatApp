//
//  AddNewUserScreen.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 19/11/23.
//

import SwiftUI

struct AddNewUserScreen: View {
    @State var newUserName = ""
    var viewModel: ChatUsersScreenViewModel
    
    var body: some View {
        TextField("New user name", text: $newUserName)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .padding()
        Button("Add new user") {
            Task {
                await viewModel.addNewUser(userName: newUserName)
                newUserName = ""
            }
        }.foregroundColor(.blue)
    }
}

//struct AddNewUserScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewUserScreen(viewModel: ChatUsersScreenViewModel(persistenceController: .shared, usersRepository: <#UsersRepositoryProtocol#>))
//    }
//}
