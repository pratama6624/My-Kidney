//
//  ConsultationPatientView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct ConsultationPatientView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var userRule: String
    @State private var users: [UserModel] = []
    @State private var isLoading: Bool = true
    @State private var errorMessage: String?
    @State private var isRotating = false
    @State private var currentPage: Int = 1
    @State private var isLoadingMore: Bool = false
    @State private var isLastPage: Bool = false
    private let pageSize: Int = 1
    
    let doctorFilter: [String] = ["Konsultasi berlangsung", "Tempat praktik terdekat", "Populer", "Rating", "Laki-laki", "Perempuan"]
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(doctorFilter, id: \.self) { doctor in
                        Button(action: {}) {
                            Text(doctor)
                                .foregroundStyle(Color.white)
                                .font(.callout)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(Color("BrandColor", bundle: Bundle.main))
                        .cornerRadius(5)
                    }
                }
            }
            .cornerRadius(5)
            .frame(width: UIScreen.main.bounds.width - 40, height: 36)
            .padding(.bottom, 10)
            
            VStack (alignment: .leading) {
                if isLoading {
                    VStack {
                        LoadingImageView()
                            .rotationEffect(Angle(degrees: isRotating ? 360 : 0))
                            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isRotating)
                            .onAppear {
                                isRotating = true
                                Task {
//                                    await loadUsers()
                                }
                            }
                        
                        LoadingMessageView()
                    }
                    .padding(20)
                    .frame(height: UIScreen.main.bounds.height - 50)
                    
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List {
                        Section("Dokter Terdaftar:") {
                            ForEach(users) { user in
                                NavigationLink {
                                    UserDetailView(user: user)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    HStack(spacing: 15) {
                                        Image("yujin")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40)
                                            .cornerRadius(40)
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(user.fullname)
                                                .font(.subheadline)
                                            Text(user.practicePlace)
                                                .font(.caption)
                                        }
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                            
                            if isLoadingMore {
                                ProgressView()
                                    .onAppear {
                                        Task {
//                                            await loadMoreUsers()
                                        }
                                    }
                            } else if !isLastPage {
                                Color.clear
                                    .onAppear {
                                        Task {
//                                            await loadMoreUsers()
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
    
//    private func loadUsers() async {
//        do {
//            let fetchedUsers = try await authViewModel.loadUsersByRule(rule: userRule, pageSize: pageSize)
//            self.users = fetchedUsers
//            self.isLoading = false
//            self.isLastPage = fetchedUsers.count < pageSize
//        } catch {
//            self.errorMessage = "Failed to load users: \(error.localizedDescription)"
//            self.isLoading = false
//        }
//    }
//
//    private func loadMoreUsers() async {
//        guard !isLoadingMore && !isLastPage else { return }
//        isLoadingMore = true
//
//        do {
//            let fetchedUsers = try await authViewModel.loadUsersByRule(rule: userRule, pageSize: pageSize)
//            self.users.append(contentsOf: fetchedUsers)
//            self.isLastPage = fetchedUsers.count < pageSize
//        } catch {
//            self.errorMessage = "Failed to load more users: \(error.localizedDescription)"
//        }
//        isLoadingMore = false
//    }
}

#Preview {
    ConsultationPatientView(userRule: "")
}
