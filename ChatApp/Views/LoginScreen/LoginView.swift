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
    @StateObject private var viewModel = LoginViewModel()
    
    private var navigationTitle: String {
        isLoginMode ? "Login" : "Create Account"
    }
    
    private var buttonTitle: String {
        isLoginMode ? "Login" : "Create Account"
    }
    
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
                
                // Take this to another view
                if !isLoginMode {
                    PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
                        if let image = viewModel.selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 90, height: 90)
                                
                        } else {
                            VStack {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 64))
                                Text("Add your own image")
                            }
                        }
                    }
                }
                
                Group {
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
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
                        .background(Color.blue)
                        .padding(.top)
                }
                
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
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
