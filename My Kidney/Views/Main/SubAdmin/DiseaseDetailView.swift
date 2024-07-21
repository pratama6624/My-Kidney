//
//  DiseaseDetailView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct DiseaseDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var symptomViewModel = SymptomViewModel()
    @StateObject var diseaseViewModel = DiseaseViewModel()
    @StateObject var loadViewModel = LoadViewModel()
    var diseases: DiseaseModel
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 10) {
                Text(diseases.name)
                    .foregroundStyle(Color.white)
                    .font(.headline)
                
                Spacer()
                
                Button {
                    diseaseViewModel.displayInputFormAddSymptom.toggle()
                } label: {
                    Image(systemName: (!diseaseViewModel.displayInputFormAddSymptom ? "plus" : "minus"))
                        .font(.headline)
                        .foregroundStyle(Color.white)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 60, height: 30)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(Color("BrandColor", bundle: Bundle.main))
            .cornerRadius(5)
            
            if diseaseViewModel.displayInputFormAddSymptom {
                VStack(spacing: 20) {
                    Text("Tambahkan gejala untuk penyakit ini")
                        .foregroundStyle(Color.black)
                        .font(.callout)
                    
                    CustomInputView(text: $symptomViewModel.fatigue, title: "Gejala")
                    CustomInputView(text: $symptomViewModel.description, title: "Deskripsi")
                    
                    Button {
                        Task {
                            if let newSymptom = await symptomViewModel.addSymptom(name: symptomViewModel.fatigue, description: symptomViewModel.description, fromSingleDisease: true) {
                                await diseaseViewModel.addSymptomToDisease(symptomID: newSymptom.id ?? "", diseaseID: diseases.id ?? "")
                                symptomViewModel.appendSymptomsIDs(diseases.symptomIDs)
                                symptomViewModel.newSymptomsIDs.append(newSymptom.id ?? "")
                                await symptomViewModel.fetchSymptoms(byIDs: symptomViewModel.newSymptomsIDs)
                            }
                            symptomViewModel.clearForm()
                        }
                    } label: {
                        Text("Simpan")
                            .font(.headline)
                            .padding(13)
                            .foregroundStyle(Color.white)
                            .background(Color("BrandColor", bundle: Bundle.main))
                            .cornerRadius(5)
                    }
                    .opacity(symptomViewModel.formIsValid ? 1.0 : 0.5)
                    .disabled(!symptomViewModel.formIsValid)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
            }
            
            VStack (alignment: .leading) {
                List {
                    Section("Deskripsi") {
                        HStack(spacing: 15) {
                            Text("\(diseases.name) adalah \(diseases.description ?? "")")
                        }
                        .padding(.vertical, 8)
                    }
                    
                    Section("Data Gejala") {
                        if loadViewModel.isLoading {
                            ForEach(symptomViewModel.symptoms) { gejala in
                                HStack(spacing: 15) {
                                    Text(gejala.name)
                                }
                                .padding(.vertical, 8)
                            }
                        } else {
                            ProgressView()
                        }
                    }
                    
                    Section("Data Solusi") {
                        HStack(spacing: 15) {
                            Text(diseases.treatment ?? "")
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
        }
        .padding(.bottom, 60)
        .onAppear {
            Task {
                loadViewModel.isLoading = false
                symptomViewModel.appendSymptomsIDs(diseases.symptomIDs)
                await symptomViewModel.fetchSymptoms(byIDs: symptomViewModel.newSymptomsIDs)
                loadViewModel.isLoading = true
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
    }
}

#Preview {
    DiseaseDetailView(diseases: DiseaseModel(name: "", symptomIDs: ["", ""]))
}
