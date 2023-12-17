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
    @Published var errorMessage = ""
    @Published var successMessage = ""
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    @Published private(set) var selectedImage: UIImage? = nil
    
    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        
        Task {
            do {
                try await AuthenticationManager.shared.createUser(email: email,
                                                                  password: password,
                                                                  imageData: selectedImage?.jpegData(compressionQuality: 0.5))
                successMessage = "User registered successfully"
                email = ""
                password = ""
                try? await Task.sleep(nanoseconds: 5_000_000_000)
                self.successMessage = ""
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
                try await AuthenticationManager.shared.signInUser(email: email,
                                                                  password: password)
                successMessage = "User logged in successfully"
                try? await Task.sleep(nanoseconds: 5_000_000_000)
                self.successMessage = ""
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
