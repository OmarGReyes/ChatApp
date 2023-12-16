//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/10/23.
//

import SwiftUI
import Firebase

@main
struct ChatAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    // Fix this to inject the dependencies from outside
    let usersRepository = UsersRepository(
        usersLocalDataManager: CoreDataLocalManager(
            coreDataClient: CoreDataClient(PersistenceController.shared.viewContext)
        )
    )
    var body: some Scene {
        WindowGroup {
            // This could be an environmentObject
//            ChatUsersScreen(viewModel: ChatUsersScreenViewModel(
//                persistenceController: PersistenceController.shared,
//                usersRepository: usersRepository)
//            )
            LoginView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
