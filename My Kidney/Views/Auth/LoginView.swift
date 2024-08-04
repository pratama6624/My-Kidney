//
//  LoginView.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var loadViewModel = LoadViewModel()
    @AppStorage ("log_Status") private var logStatus: Bool = false
    
    var body: some View {
        if loadViewModel.isLoading {
            VStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        loadViewModel.isRotating = true
                    }
                Spacer()
            }
        } else {
            NavigationStack {
                ZStack {
                    VStack {
                        VStack {
                            
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.0)
                        
                        VStack {
                            
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.2)
                        .background(Color("BrandColor", bundle: Bundle.main))
                    }
                    .ignoresSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        Image("LoginLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350, height: 200)
                            .padding(.bottom, 20)
                        
                        Spacer()
                        
                        VStack {
                            Text(authViewModel.showErrorMessage ? authViewModel.errorMessage : "LOGIN")
                                .foregroundStyle(authViewModel.showErrorMessage ? Color.red : Color("BrandColor", bundle: Bundle.main))
                                .font(.title3)
                                .bold()
                                .padding(.top, 10)
                            
                            VStack(spacing: 20) {
                                CustomInputView(text: $authViewModel.email, title: "Email")
                                CustomInputView(text: $authViewModel.password, title: "Kata sandi", isSecureField: true)
                            }
                            .padding()
                            
                            Button {
                                Task {
                                    loadViewModel.isLoading = true
                                    try await authViewModel.login()
                                    loadViewModel.isLoading = false
                                }
                            } label: {
                                HStack {
                                    Text("Masuk")
                                        .fontWeight(.semibold)
                                        .font(.callout)
                                }
                                .foregroundStyle(Color.white)
                                .frame(width: UIScreen.main.bounds.width - 90, height: 42)
                            }
                            .background(Color("BrandColor", bundle: Bundle.main))
                            .cornerRadius(5)
                            .opacity(authViewModel.loginFormIsValid ? 1.0 : 0.5)
                            .disabled(!authViewModel.loginFormIsValid)
                            .padding(.bottom, 20)

                            Text("Atau login dengan")
                                .font(.system(size: 14))
                                .padding(.bottom, 20)
                            
                            HStack(spacing: 30) {
                                Button {
                                    // Skip aja dulu (harus join Apple Developer Program 1,6 juta / Year)
                                    // authWithAppleID.handleSignInWithApple()
                                } label: {
                                    HStack {
                                        Image(systemName: "apple.logo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                    }
                                    .padding(10)
                                    .background(Color("BrandColor", bundle: Bundle.main))
                                    .cornerRadius(5)
                                    .foregroundStyle(Color.white)
                                }
                                
                                Button {
                                    authViewModel.signInWithGoogle()
                                } label: {
                                    HStack {
                                        Image(systemName: "g.square.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                    }
                                    .padding(10)
                                    .background(Color("BrandColor", bundle: Bundle.main))
                                    .cornerRadius(5)
                                    .foregroundStyle(Color.white)
                                }
                                .alert(isPresented: $authViewModel.showRoleSelectionAlert) {
                                    Alert(
                                        title: Text("Pilih Rule"),
                                        message: Text("Silahkan pilih peran anda"),
                                        primaryButton: .default(Text("Pasien"), action: {
                                            authViewModel.finalizeGoogleSignIn(userrule: "patient")
                                        }),
                                        secondaryButton: .default(Text("Dokter"), action: {
                                            authViewModel.finalizeGoogleSignIn(userrule: "doctor")
                                        })
                                    )
                                }
                                .onAppear {
                                    authViewModel.checkCurrentUser()
                                }
                                
                                HStack {
                                    Image(systemName: "f.square.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                .padding(10)
                                .background(Color("BrandColor", bundle: Bundle.main))
                                .cornerRadius(5)
                                .foregroundStyle(Color.white)
                            }
                            .padding(.bottom, 20)
                            
                            HStack(spacing: 20) {
                                NavigationLink {
                                    RegisterView()
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    HStack(spacing: 5) {
                                        Text("Lupa kata sandi?")
                                            .foregroundStyle(Color("BrandColor", bundle: Bundle.main))
                                    }
                                    .font(.system(size: 14))
                                }
                                
                                NavigationLink {
                                    RegisterView()
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    HStack(spacing: 5) {
                                        Text("Buat akun")
                                            .foregroundStyle(Color("BrandColor", bundle: Bundle.main))
                                            .bold()
                                    }
                                    .font(.system(size: 14))
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 15)
                        .padding(.bottom, 10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 5)
                    }
                    .padding(.vertical, 40)
                    .frame(width: UIScreen.main.bounds.width - 40)
                }
                .ignoresSafeArea(.all)
            }
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    LoginView()
}
