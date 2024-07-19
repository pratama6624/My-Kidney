//
//  RegisterView.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
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
                        Text("REGISTER")
                            .foregroundStyle(Color("BrandColor", bundle: Bundle.main))
                            .font(.title3)
                            .bold()
                            .padding(.top, 10)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 20) {
                                CustomInputView(text: $authViewModel.fullname, title: "Nama lengkap")
                                CustomInputView(text: $authViewModel.email, title: "Email")
                                CustomInputView(text: $authViewModel.password, title: "Kata sandi", isSecureField: true)
                                
                                if authViewModel.password.contains(authViewModel.fullname) {
                                    Text("gunakan kata sandi yang sulit ditebak")
                                        .foregroundStyle(Color.red)
                                        .font(.callout)
                                } else if !authViewModel.validatePasswordWithNumber(inputText: authViewModel.password) && !authViewModel.password.isEmpty {
                                    Text("gunakan setidaknya 3 karakter angka")
                                        .foregroundStyle(Color.red)
                                        .font(.callout)
                                } else if authViewModel.password.count < 6 && !authViewModel.password.isEmpty {
                                    Text("minimal 6 karakter")
                                        .foregroundStyle(Color.red)
                                        .font(.callout)
                                }
                                
                                ZStack(alignment: .trailing) {
                                    CustomInputView(text: $authViewModel.confirmPassword, title: "Konfirmasi kata sandi", isSecureField: true)
                                    
                                    if !authViewModel.password.isEmpty && !authViewModel.confirmPassword.isEmpty {
                                        if authViewModel.password == authViewModel.confirmPassword {
                                            Image(systemName: "checkmark.circle.fill")
                                                .imageScale(.large)
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color("BrandColor", bundle: Bundle.main))
                                                .padding(.trailing, 10)
                                        } else {
                                            Image(systemName: "xmark.circle.fill")
                                                .imageScale(.large)
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color(.systemRed))
                                                .padding(.trailing, 10)
                                        }
                                    }
                                    
                                }
                                
                                Picker("Select an options", selection: $authViewModel.userType) {
                                    ForEach(authViewModel.options, id: \.self) { option in
                                        Text(option.rawValue == "Patient" ? "Pasien" : (option.rawValue == "Doctor" ? "Dokter" : "Admin"))
                                            .foregroundStyle(Color("BrandColor", bundle: Bundle.main))
                                            .fontWeight(.bold)
                                    }
                                }
                                .pickerStyle(.menu)
                                .padding(.bottom, -20)
                            }
                            .padding()
                            
                            if authViewModel.userType == .patient || authViewModel.userType == .admin {
                                VStack(spacing: 20) {
                                    //                CustomInputView(text: $authViewModel.dateOfBirth, title: "Tanggal Lahir")
                                    CustomInputView(text: $authViewModel.address, title: "Alamat")
                                        .disabled(authViewModel.isChecked)
                                        .opacity(authViewModel.isChecked ? 0.5 : 1.0)
                                    CustomInputView(text: $authViewModel.telepon, title: "Telepon")
                                        .disabled(authViewModel.isChecked)
                                        .opacity(authViewModel.isChecked ? 0.5 : 1.0)
                                }
                                .padding()
                                .padding(.bottom, 15)
                            } else {
                                VStack(spacing: 20) {
                                    //                CustomInputView(text: $$authViewModel.dateOfBirth, title: "Tanggal Lahir")
                                    CustomInputView(text: $authViewModel.specialization, title: "Spesialisasi")
                                        .disabled(authViewModel.isChecked)
                                        .opacity(authViewModel.isChecked ? 0.5 : 1.0)
                                    CustomInputView(text: $authViewModel.licenseNumber, title: "Nomor Lisensi")
                                        .disabled(authViewModel.isChecked)
                                        .opacity(authViewModel.isChecked ? 0.5 : 1.0)
                                    CustomInputView(text: $authViewModel.address, title: "Alamat")
                                        .disabled(authViewModel.isChecked)
                                        .opacity(authViewModel.isChecked ? 0.5 : 1.0)
                                    CustomInputView(text: $authViewModel.telepon, title: "Telepon")
                                        .disabled(authViewModel.isChecked)
                                        .opacity(authViewModel.isChecked ? 0.5 : 1.0)
                                }
                                .padding()
                                .padding(.bottom, 15)
                            }
                            
                            if authViewModel.userType == .admin || authViewModel.userType == .patient || authViewModel.userType == .doctor {
                                Button {
                                    authViewModel.isChecked.toggle()
                                    print(authViewModel.isChecked ? "true" : "false")
                                } label: {
                                    Image(systemName: authViewModel.isChecked ? "checkmark.square" : "square")
                                        .foregroundStyle(authViewModel.isChecked ? .blue : .gray)
                                    Text("Lengkapi data nanti saja")
                                        .foregroundStyle(Color.black)
                                        .font(.system(size: 14))
                                }
                                .padding(.top, -12)
                                .padding(.bottom, 5)
                            }
                            
                        }
                        
                        Button {
                            Task {
                                try await authViewModel.register()
                            }
                        } label: {
                            HStack {
                                Text("Daftar")
                                    .fontWeight(.semibold)
                            }
                            .foregroundStyle(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 90, height: 42)
                        }
                        .background(Color("BrandColor", bundle: Bundle.main))
                        .cornerRadius(5)
                        .opacity(authViewModel.registerFormIsValid ? 1.0 : 0.5)
                        .disabled(!authViewModel.registerFormIsValid)
                        .padding(.bottom, 15)
                        .padding(.top, 15)
                        
                        Spacer()
                        
                        Button {
                            dismiss()
                        } label: {
                            HStack(spacing: 5) {
                                Text("Sudah mempunyai akun?")
                                    .foregroundStyle(Color.black)
                                Text("Login")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("BrandColor", bundle: Bundle.main))
                            }
                            .font(.system(size: 14))
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

#Preview {
    RegisterView()
}
