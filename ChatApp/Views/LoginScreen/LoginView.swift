//
//  LoginView.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 16/12/23.
//

import SwiftUI
import PhotosUI

struct LoginView: View {
    @State private var isLoginMode = false
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                Picker("Something", selection: $isLoginMode) {
                    Text("Login")
                        .tag(true)
                    Text("Register")
                        .tag(false)
                }
                .pickerStyle(.segmented)
                .padding()

                if !isLoginMode {
                    PhotoPickerLoginView(
                        imageSelection: $viewModel.imageSelection,
                        selectedImage: viewModel.selectedImage
                    )
                }
                
                Group {
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    // TODO: Add this modification later
//                    if !isLoginMode {
//                        TextField("Name", text: $viewModel.name)
//                    }
                    SecureField("Password", text: $viewModel.password)
                }
                .padding(12)
                .background(Color.white)
                
                Button {
                    isLoginMode ? viewModel.login() : viewModel.signUp()
                } label: {
                    Text(buttonTitle)
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(buttonBackgroundColor())
                        .cornerRadius(10)
                        .padding(.top)
                }.disabled(isLoginMode ? !viewModel.isLoginButtonEnabled() : !viewModel.isRegisterButtonEnabled())
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 14, weight: .semibold))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                }
                
                if !viewModel.successMessage.isEmpty {
                    Text(viewModel.successMessage)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 14, weight: .semibold))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                }
            }
            .padding()
            .navigationTitle(navigationTitle)
            .background(Color(white: 0.92))
            .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
                viewModel.createUsersScreen()
            }
        }
    }
}

// MARK: - Computed properties
extension LoginView {
    private var navigationTitle: String {
        isLoginMode ? "Login" : "Create Account"
    }
    
    private var buttonTitle: String {
        isLoginMode ? "Login" : "Create Account"
    }
    
    private func buttonBackgroundColor() -> Color {
        if isLoginMode && viewModel.isLoginButtonEnabled() {
            return .blue
        } else if !isLoginMode && viewModel.isRegisterButtonEnabled() {
            return .blue
        } else {
            return .gray
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(repository: FirebaseAuthManager(firebaseClient: FirebaseClient.shared)))
    }
}
