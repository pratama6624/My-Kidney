//
//  SessionManager.swift
//  My Kidney
//
//  Created by Pratama One on 31/07/24.
//

import Foundation
import Firebase
import AuthenticationServices
import FirebaseFirestoreSwift

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var userSession: Firebase.User?
    @Published var currentUser: UserModel?
    
    private let db = Firestore.firestore()
    private let collectionName = "users"
    
    private init () {
        self.userSession = Auth.auth().currentUser
        if let user = userSession {
            Task {
                self.currentUser = try? await fetchUser()
            }
        }
    }
    
    func fetchUser() async throws -> UserModel? {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("DEBUG: No User ID Found")
            return nil
        }
        
        print("UID => \(uid)")
        
        do {
            let snapshot = try await db.collection(collectionName).document(uid).getDocument()
            print("Tracking area: snapshot masih aman")
            guard snapshot.exists else {
                print("DEBUG: Document does not exist")
                return nil
            }

            print("start area snapshot data")
            for (key, value) in snapshot.data()! {
                print("\(key): \(value)")
            }
            print("stop area snapshot data")
            
            let userData = try snapshot.data(as: UserModel.self)
            print("Tracking area: userData masih aman")
            return userData
        } catch {
            print("DEBUG: Service failed to fetch data with error \(error.localizedDescription)")
            return nil
        }
    }
}
