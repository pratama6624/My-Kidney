//
//  SettingsView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var loadViewModel = LoadViewModel()
    var rule: String = ""
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                HStack (spacing: 15) {
                    Text("PO")
                        .foregroundStyle(Color("BrandColor", bundle: Bundle.main))
                        .font(.title3)
                        .bold()
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .cornerRadius(100)
                    VStack(alignment: .leading) {
                        Text("Pratama One")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                        Text(rule)
                            .foregroundStyle(Color.white)
                            .font(.headline)
                    }
                    Spacer()
                }
                .padding()
                .padding(.horizontal, 4)
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 90)
            .background(Color("BrandColor", bundle: Bundle.main))
            .cornerRadius(10)
            .padding(.bottom, 20)
            
            VStack (alignment: .leading) {
                List {
                    Section() {
                        Button {
                            withAnimation {
                                authViewModel.showUpdateTeleponView.toggle()
                            }
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "phone")
                                    .frame(width: 30)
                                
                                switch authViewModel.currentUser?.userDetails {
                                case .admin(let admin):
                                    if let telepon = admin.telepon {
                                        Text(telepon)
                                            .font(.callout)
                                    }
                                case .patient(let patient):
                                    if let telepon = patient.telepon {
                                        Text(telepon)
                                            .font(.callout)
                                    }
                                case .doctor(let doctor):
                                    if let telepon = doctor.telepon {
                                        Text(telepon)
                                            .font(.callout)
                                    }
                                case nil:
                                    Text("phone")
                                        .font(.callout)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.gray)
                            }
                            .padding(.vertical, 10)
                        }
                        .foregroundStyle(Color.black)
                        .popover(isPresented: $authViewModel.showUpdateTeleponView, arrowEdge: .top) {
                            GeometryReader { geometry in
                                UpdateTeleponView()
                                    .frame(width: geometry.size.width, height: geometry.size.height / 2)
                                    .environmentObject(authViewModel)
                            }
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "lock.open")
                                    .frame(width: 30)
                                
                                Text("Change Password")
                                    .font(.callout)
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    
                    Section() {
                        NavigationLink {
                            
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "bell")
                                    .frame(width: 30)
                                
                                Text("Notifications")
                                    .font(.callout)
                            }
                            .padding(.vertical, 10)
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "message")
                                    .frame(width: 30)
                                
                                Text("Consultation Settings")
                                    .font(.callout)
                            }
                            .padding(.vertical, 10)
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "lock")
                                    .frame(width: 30)
                                
                                Text("Privacy")
                                    .font(.callout)
                            }
                            .padding(.vertical, 10)
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "flag")
                                    .frame(width: 30)
                                
                                Text("Language")
                                    .font(.callout)
                            }
                            .padding(.vertical, 10)
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "trash")
                                    .frame(width: 30)
                                
                                Text("Delete Account")
                                    .font(.callout)
                            }
                            .padding(.vertical, 10)
                        }
                        
                        Button {
                            Task {
                                loadViewModel.isLoading = true
                                await authViewModel.logout()
                                loadViewModel.isLoading = false
                            }
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .frame(width: 30)
                                
                                Text("Logout")
                                    .font(.callout)
                            }
                            .padding(.vertical, 10)
                        }
                        .foregroundStyle(Color.black)
                    }
                    
                    Section("About") {
                        NavigationLink {
                            
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "questionmark.circle")
                                    .frame(width: 30)
                                Text("Version")
                                    .font(.callout)
                                Spacer()
                                Text("1.1.0")
                                    .font(.callout)
                                    .padding(.trailing, 10)
                            }
                            .padding(.vertical, 10)
                        }
                    }
                }
            }
            .padding(.top, -7)
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    SettingsView(rule: "")
}
