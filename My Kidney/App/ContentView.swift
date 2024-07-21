//
//  ContentView.swift
//  My Kidney
//
//  Created by Pratama One on 18/07/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            // Note: Tendang keluar jika ada user yang mencoba akses rule admin tanpa kode izin akses
            if authViewModel.userSession != nil {
                if let currentUser = authViewModel.currentUser {
                    TabView(
                        rule: currentUser.userType.rawValue,
                        adminAccessPermission: getAccessStatus(from: currentUser.userDetails)
                    )
                }
            } else {
                LoginView()
            }
        }
    }
    
    func getAccessStatus(from userDetails: UserDetails) -> Int {
            switch userDetails {
            case .admin(let admin):
                return admin.accessStatus
            case .patient, .doctor:
                return 0
            }
        }
}

#Preview {
    ContentView()
}
