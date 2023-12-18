//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 16/12/23.
//

import SwiftUI
import PhotosUI

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var errorMessage = ""
    @Published var successMessage = ""
    @Published var isLoggedIn: Bool
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    @Published private(set) var selectedImage: UIImage? = nil
    let repository: LoginRepositoryProtocol

    init(repository: LoginRepositoryProtocol) {
        self.repository = repository
        self.isLoggedIn = repository.isUserLoggedIn()
    }

    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        Task {
            do {
                try await repository.createUser(email: email,
                                                                  password: password,
                                                                  imageData: selectedImage?.jpegData(compressionQuality: 0.5))
                email = ""
                password = ""
                isLoggedIn = true
            } catch {
                self.errorMessage = error.localizedDescription
                try? await Task.sleep(nanoseconds: 5_000_000_000)
                self.errorMessage = ""
            }
        }
    }
    
    func login() {
        Task {
            do {
                try await repository.logInUser(email: email,
                                              password: password)
                isLoggedIn = true
            } catch {
                self.errorMessage = error.localizedDescription
                try? await Task.sleep(nanoseconds: 5_000_000_000)
                self.errorMessage = ""
            }
        }
    }
    
    func isRegisterButtonEnabled() -> Bool {
        return selectedImage != nil && !email.isEmpty && !password.isEmpty
    }
    
    func isLoginButtonEnabled() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    func createUsersScreen() -> ChatUsersScreen {
        let coreDataClient = CoreDataClient(PersistenceController.shared.viewContext)
        let localDataManager = CoreDataLocalManager(coreDataClient: coreDataClient)
        let userRepository = UsersRepository(usersLocalDataManager: localDataManager)
        let viewModel = ChatUsersScreenViewModel(usersRepository: userRepository)
        return ChatUsersScreen(viewModel: viewModel)
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                if let uiImage = UIImage(data: data!) {
                    selectedImage = uiImage
                }
            } catch {
                self.errorMessage = error.localizedDescription
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                self.errorMessage = ""
            }
        }
    }
}
