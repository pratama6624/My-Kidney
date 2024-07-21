//
//  UpdateTeleponView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct UpdateTeleponView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Perbarui No Telepon")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.all, 10)
                        .foregroundStyle(.white)
                        .background(Color("BrandColor", bundle: Bundle.main))
                        .cornerRadius(10)
                }
                .padding(.bottom, 30)
                
                VStack {
                    VStack(spacing: 20) {
                        CustomInputView(text: $authViewModel.newPhoneNumber, title: "No Telepon Baru")
                    }
                    .padding()
                    
                    Button {
                        Task {
                            await authViewModel.updatePhoneNumber(userID: authViewModel.currentUser!.id ?? "")
                                authViewModel.showUpdateTeleponView = false
                        }
                    } label: {
                        HStack {
                            Text("Simpan")
                                .fontWeight(.semibold)
                                .font(.callout)
                        }
                        .foregroundStyle(Color.white)
                        .frame(width: UIScreen.main.bounds.width - 70, height: 42)
                    }
                    .background(Color("BrandColor", bundle: Bundle.main))
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                }
            }
        }
        .padding(20)
        .cornerRadius(20)
    }
}

#Preview {
    UpdateTeleponView()
}
