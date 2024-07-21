//
//  AuthViewModel.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import AuthenticationServices
import FirebaseFirestoreSwift
import GoogleSignIn

protocol AuthFormProtocol {
    var loginFormIsValid: Bool { get }
    var registerFormIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    private var loadViewModel = LoadViewModel()
    @Published var userSession: Firebase.User?
    @Published var currentUser: UserModel?
    
    // For Login || Register
    @Published var email: String = ""
    @Published var password: String = ""
    
    // For sign in with Google
    @Published var isLoginSuccess: Bool = false
    
    // Message
    @Published var showErrorMessage: Bool = false
    @Published var errorMessage: String = ""
    
    // For Register
    let options: [UserType] = [.admin, .patient, .doctor]
    @Published var userType: UserType = .patient
    @Published var fullname: String = ""
    @Published var confirmPassword: String = ""
    @Published var isChecked: Bool = false
    @Published var address: String = ""
    @Published var telepon: String = ""
    @Published var accessStatus: Int = 0
    @Published var rule: UserType = .patient
    @Published var photoURL: String = ""
    @Published var providerId: String = ""
    // @State var dateOfBirth = Date()
    // For Doctor Register
    @Published var specialization: String = ""
    @Published var licenseNumber: String = ""
    @Published var education: String = ""
    @Published var graduatingYear: String = ""
    @Published var practicePlace: String = ""
    @Published var practiceSchedule: [String: String] = [:]
    // For Patient Register
    @Published var diagnosticHistory: [String] = []
    @Published var consultationHistory: [String] = []
    
    // Update Phone Number
    @Published var showUpdateTeleponView: Bool = false
    @Published var newPhoneNumber: String = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
            await self.logout()
        }
    }
    
    private func resetProperty() {
        email = ""
        password = ""
        userType = .patient
        fullname = ""
        confirmPassword = ""
        isChecked = false
        address = ""
        telepon = ""
        accessStatus = 0
        rule = .patient
        photoURL = ""
        providerId = ""
        // dateOfBirth = Date()
        specialization = ""
        licenseNumber = ""
        education = ""
        graduatingYear = ""
        practicePlace = ""
        practiceSchedule = [:]
        diagnosticHistory = []
        consultationHistory = []
    }
    
    func login() async throws {
        do {
            self.userSession = try await AuthServices.shared.login(withEmail: email, password: password)
            await fetchUser()
            self.resetProperty()
            self.errorMessage = ""
            print("DEBUG: Successfully login with no error")
        } catch {
            self.resetProperty()
            self.showErrorMessage("Email atau Kata sandi salah")
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
        }
    }
    
    // Sign in with Google
    func signInWithGoogle() {
        AuthServices.shared.signInWithGoogle { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.isLoginSuccess = true
                    AuthServices.shared.firebaseLogin(with: GoogleAuthProvider.credential(withIDToken: user.idToken?.tokenString ?? "", accessToken: user.accessToken.tokenString)) { result in
                        switch result {
                        case .success(let user):
                            self?.currentUser = user
                        case .failure(let error):
                            self?.errorMessage = error.localizedDescription
                        }
                    }
                    print("User signed in: \(result)")
                case .failure(let error):
                    self?.isLoginSuccess = false
                    self?.errorMessage = error.localizedDescription
                    print("Error signing in: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func showErrorMessage(_ message: String) {
        errorMessage = message
        self.showErrorMessage = true
        
        // Set a timer to reset the error message after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showErrorMessage = false
        }
    }
    
    func register() async throws {
        do {
            let additionalDetails: [String: Any] = [
                "fullname": fullname.capitalizeWords(),
                "telepon": telepon,
                "address": address,
                "dateOfBirth": "",
                "diagnosticHistory": diagnosticHistory,
                "consultationHistory": consultationHistory,
                "specialization": specialization,
                "licenseNumber": licenseNumber,
                "accessStatus": accessStatus,
                "rule": (userType == .admin ? "admin" : (userType == .patient ? "patient" : "doctor")),
                "education": education,
                "graduatingYear": graduatingYear,
                "practicePlace": practicePlace,
                "practiceSchedule": practiceSchedule,
                "photoURL": photoURL,
                "providerId": providerId
            ]
            
            self.userSession = try await AuthServices.shared.register(withEmail: email, fullname: fullname, password: password, userType: userType, additionalDetails: additionalDetails)
            await self.fetchUser()
            self.resetProperty()
            await self.logout()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func logout() async {
        do {
            try AuthServices.shared.logout()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to logout with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        do {
            self.currentUser = try await AuthServices.shared.fetchUser()
            print("DEBUG: Fetch user successfully")
        } catch {
            print("DEBUG: ViewModel failed to fetch user with error \(error.localizedDescription)")
        }
    }
    
    // Update Phone Number
    func updatePhoneNumber(userID: String) async {
        do {
            try await AuthServices.shared.updatePhoneNumber(userID: userID, newPhoneNumber: newPhoneNumber)
            print("Phone number updated successfully")
            
            // Update currentUser details in memory
            updateUIPhoneNumber()
            
            // Reset phone number
            self.newPhoneNumber = ""
        } catch {
            print("Failed to update phone number: \(error.localizedDescription)")
        }
    }
    
    // Untuk validasi password harus menggunakan setidaknya 3 karakter angka
    func validatePasswordWithNumber(inputText: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "[0-9]{3,}", options: .caseInsensitive)
        guard let matches = regex?.matches(in: inputText, options: .reportCompletion, range: NSRange(location: 0, length: inputText.count)) else {
            return false
        }
        return matches.count > 0
    }
    
    private func updateUIPhoneNumber() {
        switch self.currentUser?.userDetails {
        case .admin(var admin):
            admin.telepon = self.newPhoneNumber
            self.currentUser?.userDetails = .admin(admin)
        case .patient(var patient):
            patient.telepon = self.newPhoneNumber
            self.currentUser?.userDetails = .patient(patient)
        case .doctor(var doctor):
            doctor.telepon = self.newPhoneNumber
            self.currentUser?.userDetails = .doctor(doctor)
        case .none:
            break
        }
    }
}

extension String {
    func capitalizeWords() -> String {
        let words = self.components(separatedBy: " ")
        return words.map { word -> String in
            return String(word.prefix(1).uppercased()) + word.dropFirst()
        }.joined(separator: " ")
    }
}

extension AuthViewModel: AuthFormProtocol {
    var loginFormIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
    
    var registerFormIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !fullname.isEmpty
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && (
            (isChecked || (userType == .admin && !address.isEmpty && !telepon.isEmpty))
            || (isChecked || (userType == .patient && !address.isEmpty && !telepon.isEmpty))
            || (isChecked || (userType == .doctor && !specialization.isEmpty && !licenseNumber.isEmpty && !address.isEmpty && !telepon.isEmpty))
        )
        && (userType == .admin || userType == .patient || userType == .doctor)
    }
}

