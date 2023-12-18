//
//  FirebaseAuthManager.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/12/23.
//

import Foundation

final class FirebaseAuthManager {
    let firebaseClient: FirebaseClient
    
    init(firebaseClient: FirebaseClient) {
        self.firebaseClient = firebaseClient
    }
}
