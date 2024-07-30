//
//  AuthServices.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn

class AuthServices {
    static let shared = AuthServices()
    private let db = Firestore.firestore()
    private let collectionName = "users"
    
    private init() {}
    
    func login(withEmail email: String, password: String) async throws -> Firebase.User {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user
    }
    
    func register(withEmail email: String, fullname: String, password: String, userType: UserType, additionalDetails: [String: Any]) async throws -> Firebase.User {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let userDetails: [String: Any] = ["email": email, "userType": userType.rawValue, "userDetails": additionalDetails]
        try await db.collection(collectionName).document(result.user.uid).setData(userDetails)
        
        return result.user
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    func fetchUser() async throws -> UserModel? {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("DEBUG: No User ID Found")
            return nil
        }
        do {
            let snapshot = try await db.collection(collectionName).document(uid).getDocument()
            guard snapshot.exists else {
                print("DEBUG: Document does not exist")
                return nil
            }
            
            let userData = try snapshot.data(as: UserModel.self)
            return userData
        } catch {
            print("DEBUG: Service failed to fetch data with error \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchUsersByRule(rule: String, pageSize: Int, lastDocument: DocumentSnapshot? = nil) async throws -> ([UserModel], DocumentSnapshot?) {
        var query = db.collection(collectionName)
            .whereField("userType", isEqualTo: rule)
            .limit(to: pageSize)
            
        if let lastDocument = lastDocument {
            query = query.start(afterDocument: lastDocument)
        }
        
        let snapshot = try await query.getDocuments()
        let users = snapshot.documents.compactMap {
            try? $0.data(as: UserModel.self)
        }
        
        return (users, snapshot.documents.last)
    }
    
    // Update Phone Number
    func updatePhoneNumber(userID: String, newPhoneNumber: String) async throws {
        let userRef = db.collection(collectionName).document(userID)
        
        let document = try await userRef.getDocument()
        
        if let userDetails = document.data()?["userDetails"] as? [String: Any] {
            var updateDetails = userDetails
            updateDetails["telepon"] = newPhoneNumber
            
            try await userRef.updateData(["userDetails": updateDetails])
        } else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "userDetails not found"])
        }
    }
    
    // Sign in with Google
    func signInWithGoogle(completion: @escaping (Result<GIDGoogleUser, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(
            withPresenting: ApplicationUtility.rootViewController) { signInResult, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let user = signInResult?.user else {
                    completion(.failure(NSError(domain: "User not found", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get user"])))
                    return
                }
                
                completion(.success(user))
            }
    }
    
    func firebaseLogin(userrule: String, with credential: AuthCredential, completion: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let firebaseUser = result?.user else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "User not found", code: -1, userInfo: nil)))
                }
                return
            }
            
            Task {
                do {
                    let _ = try await self.saveUserToFirestore(userrule: userrule, user: firebaseUser)
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    // Coba pelajari lagi untuk data flow dibagian ini
    
    /*
     Ada banyak yang harus diperbaiki di bagian ini, coba nanti lihat lagi di chatGPT sesi terakhir dan cari tahu kenapa fungsi firebase
     login tidak terbaca di AuthViewModel
     */
    
    func saveUserToFirestore(userrule: String, user: User) async throws {
        let userRef = Firestore.firestore().collection("users").document(user.uid)
        
        let additionalDetails: [String: Any] = [
            "fullname": user.displayName ?? "",
            "telepon": user.phoneNumber ?? "",
            "address": "",
            "dateOfBirth": "",
            "diagnosticHistory": [String](),
            "consultationHistory": [String](),
            "specialization": "",
            "licenseNumber": "",
            "accessStatus": 0,
            "rule": userrule,
            "education": "",
            "graduatingYear": "",
            "practicePlace": "",
            "practiceSchedule": [String: String](),
            "photoURL": user.photoURL?.absoluteString ?? "",
            "providerId": ""
        ]
        
        print("1. Tracking error area")
        
        print("additional ada isinya: \(additionalDetails)")
        
        // Wrong Area
        // Determine the userType and userDetails based on the additionalDetails
//        guard let rule = additionalDetails["rule"] as? String else {
//            throw NSError(domain: "Invalid user data", code: -1, userInfo: [NSLocalizedDescriptionKey: "Rule not found in additionalDetails"])
//        }
        
        // Rule sementara kita bisa hardcode dulu
        let rule = "admin"
        
        var userType: UserType
        
        switch rule {
        case "admin":
            userType = .admin
            print("4. Tracking error area")
            
        case "patient":
            userType = .patient
            
        case "doctor":
            userType = .doctor
            
        default:
            throw NSError(domain: "Invalid user data", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown rule type"])
        }
        
        print("6. Tracking error area")
        
        // Prepare data to be saved
        let userData: [String: Any] = [
            "email": user.email ?? "",
            "userType": userType.rawValue,
            "userDetails": additionalDetails
        ]
        
        // Save data to Firestore
        do {
            try await userRef.setData(userData)
            print("DEBUG: User data saved to Firestore.")
        } catch {
            print("DEBUG: Failed to save user data to Firestore with error: \(error.localizedDescription)")
            throw error
        }
    }
}


