//
//  HomePatientView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct HomePatientView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showSymptomFormView: Bool = false
    @State private var showHealthTipsView: Bool = false
    @State private var showDiseaseView: Bool = false
    @State private var showAboutApp: Bool = false
    @State private var showFeaturesView: Bool = false
    @State private var showGuideToDiagnosisView: Bool = false
    @State private var showProblemTipsView: Bool = false
    
    var body: some View {
        NavigationView {
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Image("kidney")
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 30)
                            .cornerRadius(10)
                        
                        Text("Halo \(SessionManager.shared.currentUser?.fullname ?? ""), selamat datang ")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        
                        Text(AppInfoData.myKidneyWelcome)
                            .padding(.bottom, 30)
                        
                        //                    Text("Mulai menjaga Ginjal")
                        //                        .font(.title3)
                        //                        .fontWeight(.bold)
                        //                        .padding(.bottom, 10)
                        
                        HStack {
                            Button {
                                withAnimation {
                                    showHealthTipsView.toggle()
                                }
                            } label: {
                                ZStack(alignment: .leading) {
                                    Image("leftKidney")
                                        .resizable()
                                        .scaledToFill()
                                    
                                    VStack(alignment: .leading) {
                                        Text("Tips")
                                        Text("Kesehatan")
                                        Text("Ginjal")
                                    }
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                    .foregroundStyle(Color.white)
                                }
                                .frame(width: UIScreen.main.bounds.width / 2.3, height: 100)
                                .background(Color.red)
                                .cornerRadius(10)
                            }
                            .popover(isPresented: $showHealthTipsView, arrowEdge: .top) {
                                GeometryReader { geometry in
                                    HealthTipsView()
                                }
                            }
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    showDiseaseView.toggle()
                                }
                            } label: {
                                ZStack(alignment: .trailing) {
                                    Image("rightKidney")
                                        .resizable()
                                        .scaledToFill()
                                        .opacity(0.9)
                                    
                                    VStack(alignment: .trailing) {
                                        Text("Mengenal")
                                        Text("Penyakit")
                                        Text("Ginjal")
                                    }
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                    .foregroundStyle(Color.white)
                                }
                                .frame(width: UIScreen.main.bounds.width / 2.3, height: 100)
                                .background(Color.red)
                                .cornerRadius(10)
                            }
                            .popover(isPresented: $showDiseaseView, arrowEdge: .top) {
                                GeometryReader { geometry in
                                    DiseaseView()
                                }
                            }
                        }
                        .padding(.bottom, 20)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Mengenal \"My Kidney\"")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                            
                            // Langkah-Langkah Awal
                            Button {
                                withAnimation {
                                    showAboutApp.toggle()
                                }
                            } label: {
                                HStack {
                                    Text("1. Apa itu \"My Kidney\"")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .padding()
                            .background(Color.red.opacity(0.2))
                            .cornerRadius(10)
                            .popover(isPresented: $showAboutApp, arrowEdge: .top) {
                                GeometryReader { geometry in
                                    AboutAppView()
                                }
                            }
                            
                            Button {
                                withAnimation {
                                    showFeaturesView.toggle()
                                }
                            } label: {
                                HStack {
                                    Text("2. Fitur fitur di \"My Kidney\"")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(10)
                            .popover(isPresented: $showFeaturesView, arrowEdge: .top) {
                                GeometryReader { geometry in
                                    FeaturesView()
                                }
                            }
                            
                            Button {
                                withAnimation {
                                    showGuideToDiagnosisView.toggle()
                                }
                            } label: {
                                HStack {
                                    Text("3. Cara untuk mendapatkan diagnosa")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .padding()
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(10)
                            .popover(isPresented: $showGuideToDiagnosisView, arrowEdge: .top) {
                                GeometryReader { geometry in
                                    GuideToDiagnosisView()
                                }
                            }
                            
                            Button {
                                withAnimation {
                                    showProblemTipsView.toggle()
                                }
                            } label: {
                                HStack {
                                    Text("4. Tips untuk masalah serius")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .padding()
                            .background(Color.yellow.opacity(0.2))
                            .cornerRadius(10)
                            .popover(isPresented: $showProblemTipsView, arrowEdge: .top) {
                                GeometryReader { geometry in
                                    ProblemTipsView(problemTips: AppInfoData.problemTips)
                                }
                            }
                        }
                        .padding(.bottom, 30)
                        
                        Text("Events")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<3) {_ in
                                    EventCard(event: event)
                                        .padding(.bottom, 20)
                                }
                            }
                        }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .padding(.bottom, 50)
                }
            }
        }
    }
    
    var event: Event {
        return Event(
            title: "Seminar Kesehatan Ginjal: Pencegahan dan Pengobatan",
            date: "25 Juni 2024",
            time: "10:00 AM - 12:00 PM",
            type: "offline",
            location: "Auditorium Rumah Sakit Sehat Sentosa",
            speakers: ["Dr. Andi Wijaya, Sp.PD-KGH (Konsultan Nefrologi)", "Dr. Budi Santoso, Sp.PD (Dokter Penyakit Dalam)"],
            fee: "Gratis",
            registrationDeadline: "20 Juni 2024",
            agenda: [
                "10:00 - 10:30: Registrasi dan Pembukaan",
                "10:30 - 11:15: Presentasi oleh Dr. Andi Wijaya: 'Deteksi Dini dan Pencegahan Penyakit Ginjal'",
                "11:15 - 11:45: Presentasi oleh Dr. Budi Santoso: 'Pilihan Pengobatan untuk Pasien Penyakit Ginjal'",
                "11:45 - 12:00: Sesi Tanya Jawab"
            ]
        )
    }
}

struct EventCard: View {
    let event: Event
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("JUNI")
                    .font(.footnote)
                    .bold()
                
                Text("29")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Text("Seminar Kesehatan Ginjal: Pencegahan dan Pengobatan")
                    .font(.headline)
                    .padding(.vertical, 10)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("10.00 - 12.00")
                        Text("Online")
                    }
                    .font(.footnote)
                    
                    Spacer()
                    
                    NavigationLink {
                        EventDetailView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Image(systemName: "arrow.right")
                            .bold()
                            .font(.headline)
                    }
                }
            }
            .padding(.all, 20)
            .frame(width: UIScreen.main.bounds.width / 1.5)
            .foregroundStyle(Color.white)
            .background(Color("BrandColor", bundle: Bundle.main).opacity(0.8))
            .cornerRadius(5)
        }
    }
}

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let time: String
    let type: String
    let location: String
    let speakers: [String]
    let fee: String
    let registrationDeadline: String
    let agenda: [String]
}

#Preview {
    HomePatientView()
}
