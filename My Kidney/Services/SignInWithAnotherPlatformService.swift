//
//  SignInWithAnotherPlatformService.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import GoogleSignIn

class SignInWithAnotherPlatformService {
    static let shared = SignInWithAnotherPlatformService()
    
    // Sign in with Google
    func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(
            withPresenting: ApplicationUtility.rootViewController) { user, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard
                    let user = user?.user,
                    let idToken = user.idToken else {
                    completion(.failure(NSError(domain: "Invalid user data", code: -1, userInfo: nil)))
                    return
                }
                
                let accessToken = user.accessToken
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { res, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let user = res?.user else {
                        completion(.failure(NSError(domain: "User not found", code: -1, userInfo: nil)))
                        return
                    }
                    completion(.success(user))
                }
        }
    }
}
