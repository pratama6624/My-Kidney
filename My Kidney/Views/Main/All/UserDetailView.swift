//
//  UserDetailView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    var user: UserModel
    @State private var showUserProfileView: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(spacing: 15) {
                    Button {
                        showUserProfileView.toggle()
                    } label: {
                        Text("PO")
                            .foregroundColor(Color("BrandColor", bundle: Bundle.main))
                            .font(.title3)
                            .bold()
                            .frame(width: 50, height: 50)
                            .background(Color.white)
                            .cornerRadius(100)
                    }
                    .popover(isPresented: $showUserProfileView, arrowEdge: .top) {
                        GeometryReader { geometry in
                            UserProfileView()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(user.fullname)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                        Text(user.userType.rawValue)
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }
                    
                    Spacer()
                    
                    if user.isDoctor && SessionManager.shared.currentUser?.userType == .patient {
                        Image(systemName: "ellipsis.message.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .foregroundStyle(Color.white)
                    }
                }
                .padding()
                .padding(.horizontal, 4)
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 90)
            .background(Color("BrandColor", bundle: Bundle.main))
            .cornerRadius(10)
            .padding(.bottom, 10)
           
            VStack(alignment: .leading) {
                List {
                    Section("Data \(user.userType.rawValue == "Patient" ? "Pasien" : (user.userType.rawValue == "Doctor" ? "Dokter" : "Admin"))") {
                        HStack(spacing: 15) {
                            Text("Nama")
                                .frame(width: 70, alignment: .leading)
                                .font(.system(size: 14))
                            Text(":")
                                .font(.system(size: 14))
                            Text(user.fullname)
                                .font(.system(size: 14))
                        }
                        .padding(.vertical, 8)
                        
                        HStack(spacing: 15) {
                            Text("Gender")
                                .frame(width: 70, alignment: .leading)
                                .font(.system(size: 14))
                            Text(":")
                                .font(.system(size: 14))
                            Text("-")
                                .font(.system(size: 14))
                        }
                        .padding(.vertical, 8)
                        
                        HStack(spacing: 15) {
                            Text("Email")
                                .frame(width: 70, alignment: .leading)
                                .font(.system(size: 14))
                            Text(":")
                                .font(.system(size: 14))
                            Text(user.email)
                                .font(.system(size: 14))
                        }
                        .padding(.vertical, 8)
                        
                        if user.isAdmin {
                            Text("Admin User")
                        }
                        
                        if user.isPatient {
                            if case let .patient(patient) = user.userDetails {
                                if let address = patient.address {
                                    HStack(spacing: 15) {
                                        Text("Alamat")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text(address)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                                if let telepon = patient.telepon {
                                    HStack(spacing: 15) {
                                        Text("Telepon")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text(telepon)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                                if let dateOfBirth = patient.dateOfBirth {
                                    HStack(spacing: 15) {
                                        Text("Tgl Lahir")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text(dateOfBirth)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                        }
                        
                        if user.isDoctor {
                            if case let .doctor(doctor) = user.userDetails {
                                if let address = doctor.address {
                                    HStack(spacing: 15) {
                                        Text("Alamat")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text(address)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                                if let telepon = doctor.telepon {
                                    HStack(spacing: 15) {
                                        Text("Telepon")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text(telepon)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                                if let specialization = doctor.specialization {
                                    HStack(spacing: 15) {
                                        Text("Bidang")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text(specialization)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                                if let licenseNumber = doctor.licenseNumber {
                                    HStack(spacing: 15) {
                                        Text("Licensi")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text(licenseNumber)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                                if let education = doctor.education {
                                    HStack(spacing: 15) {
                                        Text("Sekolah")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text(education)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                                if let graduatingYear = doctor.graduatingYear {
                                    HStack(spacing: 15) {
                                        Text("Kelulusan")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text(graduatingYear)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                                if let practicePlace = doctor.practicePlace {
                                    HStack(spacing: 15) {
                                        Text("Praktik")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text(practicePlace)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                        }
                    }
                    
                    if user.isPatient {
                        if case let .patient(patient) = user.userDetails {
                            Section("Aktivitas User") {
                                if patient.diagnosticHistory != nil {
                                    NavigationLink {
                                        DiagnosticDataView()
                                            .navigationBarBackButtonHidden(true)
                                    } label: {
                                        HStack(spacing: 15) {
                                            Text("Riwayat Diagnosa")
                                                .font(.system(size: 14))
                                        }
                                        .padding(.vertical, 8)
                                    }
                                }
                                
                                if patient.consultationHistory != nil {
                                    NavigationLink {
                                        ConsultationDataView()
                                            .navigationBarBackButtonHidden(true)
                                    } label: {
                                        HStack(spacing: 15) {
                                            Text("Riwayat Konsultasi")
                                                .font(.system(size: 14))
                                        }
                                        .padding(.vertical, 8)
                                    }
                                }
                            }
                        }
                    }
                    
                    if user.isDoctor {
                        if case let .doctor(doctor) = user.userDetails {
                            Section("Jadwal Praktik") {
                                if doctor.practiceSchedule != nil {
                                    HStack(spacing: 15) {
                                        Text("Senin")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text("")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                    
                                    HStack(spacing: 15) {
                                        Text("Selasa")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text("")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                    
                                    HStack(spacing: 15) {
                                        Text("Rabu")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text("")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                    
                                    HStack(spacing: 15) {
                                        Text("Kamis")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text("")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                    
                                    HStack(spacing: 15) {
                                        Text("Jumat")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text("")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                    
                                    HStack(spacing: 15) {
                                        Text("Sabtu")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text("")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                    
                                    HStack(spacing: 15) {
                                        Text("Minggu")
                                            .frame(width: 70, alignment: .leading)
                                            .font(.system(size: 14))
                                        Text(":")
                                            .font(.system(size: 14))
                                        Text("")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                            
                            Section("Mulai Konsultasi") {
                                NavigationLink {
                                    DiagnosticDataView()
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    HStack(spacing: 15) {
                                        Text("Ruang Obrolan")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                                
                                NavigationLink {
                                    DiagnosticDataView()
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    HStack(spacing: 15) {
                                        Text("Form Input Gejala")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                                
                                NavigationLink {
                                    DiagnosticDataView()
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    HStack(spacing: 15) {
                                        Text("Hasil Diagnosa")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                        }
                    }
                }
            }
        }
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
}

#Preview {
    UserDetailView(
        user: UserModel(
            id: "id",
            email: "email",
            userType: .patient,
            userDetails: .patient(Patient(
                        id: "id",
                        fullname: "John Doe",
                        dateOfBirth: "01/01/1990",
                        address: "123 Main St",
                        telepon: "555-5555",
                        diagnosticHistory: ["Diabetes", "Hypertension"],
                        consultationHistory: ["01/01/2020", "01/01/2021"],
                        accessStatus: 0,
                        rule: "pasien",
                        photoURL: "",
                        providerId: "apple.com"
                    )
            ))
        )
}
