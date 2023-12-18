//
//  AuthenticationManager.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 16/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

final class FirebaseClient {
    // TODO: - Separate this
    static let shared = FirebaseClient()
    private let auth: Auth
    private let storage: Storage
    private let fireStore: Firestore
    
    private init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.fireStore = Firestore.firestore()
    }

    func getCurrentUserId() -> String? {
        auth.currentUser?.uid
    }

    func getUserInfo() async throws -> [String : Any]? {
        guard let uid = getCurrentUserId() else { throw URLError(.fileDoesNotExist) }
        let data = try await fireStore.collection("users").document(uid).getDocument().data()
        return data
    }

    func createUser(email: String, password: String, imageData: Data?) async throws {
        do {
        // TODO: Make this two parallel
            try await persistImageToStorage(data: imageData, email: email)
            try await auth.createUser(withEmail: email, password: password)
        } catch {
            throw error
        }
    }
    
    func signInUser(email: String, password: String) async throws {
        try await auth.signIn(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try auth.signOut()
    }
    
    func persistImageToStorage(data: Data?, email: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid,
              let data = data else { return }
        let ref = storage.reference(withPath: uid)
        
        // En paralelo estas dos
        let _ = try await ref.putDataAsync(data)
        
        
        let url = try await ref.downloadURL()
        
        try await storeUserInformation(imageProfileURL: url, email: email)
        print("Image saved successfully")
    }
    
    func storeUserInformation(imageProfileURL: URL, email: String) async throws {
        guard let uid = auth.currentUser?.uid else { throw URLError(.cancelled) }
        let userData = ["email" : email, "uid": uid, "profileImageURL": imageProfileURL.absoluteString]
        try await fireStore.collection("users").document(uid).setData(userData)
    }
}
