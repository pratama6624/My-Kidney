//
//  UserManagementView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct UserManagementView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var loadViewModel = LoadViewModel()
    @Environment(\.presentationMode) var presentationMode
    var userRule: String = ""
    @State private var hasAppeared = false
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 10) {
                Text(userRule == "Patient" ? "Data Pasien" : "Dokter")
                    .foregroundStyle(Color.white)
                    .font(.headline)
            }
            .frame(width: UIScreen.main.bounds.width - 60, height: 30)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(Color("BrandColor", bundle: Bundle.main))
            .cornerRadius(5)
            
            VStack (alignment: .leading) {
                if loadViewModel.isLoading && (userRule == "Patient" ? loadViewModel.patients.isEmpty : loadViewModel.doctors.isEmpty) {
                    VStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .onAppear {
                                loadViewModel.isRotating = true
                            }
                        Spacer()
                    }
                } else if let errorMessage = loadViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List {
                        ForEach(userRule == "Patient" ? loadViewModel.patients : loadViewModel.doctors) { user in
                            NavigationLink {
                                UserDetailView(user: user)
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Image("yujin")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35)
                                        .cornerRadius(40)
                                    
                                    Text(user.fullname)
                                        .font(.subheadline)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        
                        if loadViewModel.isLoadingMore {
                            ProgressView()
                                .onAppear {
                                    Task {
                                        await loadMoreUsersBasedOnRule()
                                    }
                                }
                        } else if !loadViewModel.isLastPage {
                            Color.clear
                                .onAppear {
                                    Task {
                                        await loadMoreUsersBasedOnRule()
                                    }
                                }
                        }
                    }
                }
            }
            .padding(.top, -10)
            .gesture (
                DragGesture()
                    .onEnded { value in
                        if value.startLocation.x < 30 && value.translation.width > 100 {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
            )
            .padding(.bottom, 50)
        }
        .onAppear {
            if hasAppeared {
                loadViewModel.resetData(collection: .users)
            } else {
                hasAppeared = true
            }
            Task {
                await loadUsersBasedOnRule()
            }
        }
    }
    
    private func loadUsersBasedOnRule() async {
        if userRule == "Patient" {
            await loadViewModel.loadPatients()
        } else if userRule == "Doctor" {
            await loadViewModel.loadDoctors()
        }
    }
    
    private func loadMoreUsersBasedOnRule() async {
        if userRule == "Patient" {
            await loadViewModel.loadMorePatients()
        } else if userRule == "Doctor" {
            await loadViewModel.loadMoreDoctors()
        }
    }
    
}

#Preview {
    UserManagementView(userRule: "")
        .environmentObject(AuthViewModel())
}
