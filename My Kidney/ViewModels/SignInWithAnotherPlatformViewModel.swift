//
//  SignInWithAnotherPlatformViewModel.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import GoogleSignIn

class SignInWithAnotherPlatformViewModel: ObservableObject {
    @Published var isLoginSuccess: Bool = false
    @Published var errorMessage: String?
    
    // Sign in with Google
    func signInWithGoogle() {
        AuthServices.shared.signInWithGoogle { [weak self] result in
            switch result {
            case .success(let user):
                self?.isLoginSuccess = true
                print("User signed in: \(user)")
            case .failure(let error):
                self?.isLoginSuccess = false
                self?.errorMessage = error.localizedDescription
                print("Error signing in: \(error.localizedDescription)")
            }
        }
    }
}
