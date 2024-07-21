//
//  HomeAdminView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct HomeAdminView: View {
    var body: some View {
        NavigationView {
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
                            Text("Admin")
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
                        Section("Basis Data") {
                            NavigationLink {
                                UserManagementView(userRule: "Patient")
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "list.bullet.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    
                                    Text("Data Pasien / Masyarakat Umum")
                                        .font(.callout)
                                }
                                .padding(.vertical, 10)
                            }
                            
                            NavigationLink {
                                UserManagementView(userRule: "Doctor")
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "list.bullet.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    
                                    Text("Data Dokter / Tenaga Medis")
                                        .font(.callout)
                                }
                                .padding(.vertical, 10)
                            }
                            
                            NavigationLink {
                                DiseaseDataView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "list.bullet.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    
                                    Text("Data Penyakit")
                                        .font(.callout)
                                }
                                .padding(.vertical, 10)
                            }
                            
                            NavigationLink {
                                SymptomDataView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "list.bullet.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    
                                    Text("Data Gejala")
                                        .font(.callout)
                                }
                                .padding(.vertical, 10)
                            }
                            
                            NavigationLink {
                                AdviceDataView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "list.bullet.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    
                                    Text("Data Acara")
                                        .font(.callout)
                                }
                                .padding(.vertical, 10)
                            }
                                
                            NavigationLink {
                                AdviceDataView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "list.bullet.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    
                                    Text("Data Tips Merawat Ginjal")
                                        .font(.callout)
                                }
                                .padding(.vertical, 10)
                            }
                        }
                        
                        Section("Statistik") {
                            NavigationLink {
                                ActiveUserDataView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "list.bullet.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    
                                    Text("Data Pengguna Aktif")
                                        .font(.callout)
                                }
                                .padding(.vertical, 10)
                            }
                            
                            NavigationLink {
                                BlockedUserDataView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "list.bullet.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    
                                    Text("Data Pengguna Diblokir")
                                        .font(.callout)
                                }
                                .padding(.vertical, 10)
                            }
                            
                            NavigationLink {
                                DiagnosticDataView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "list.bullet.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    
                                    Text("Data Total Diagnosa")
                                        .font(.callout)
                                }
                                .padding(.vertical, 10)
                            }
                            
                            NavigationLink {
                                ConsultationDataView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "list.bullet.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    
                                    Text("Data Total Konsultasi")
                                        .font(.callout)
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
}

#Preview {
    HomeAdminView()
}
