//
//  SymptomDataView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct SymptomDataView: View {
    @StateObject var symptomViewModel = SymptomViewModel()
    @StateObject var diseaseViewModel = DiseaseViewModel()
    @StateObject var loadViewModel = LoadViewModel()
    @State private var hasAppeared = false
    @State private var selectedDiseaseID: String?
    @State private var textViewHeight: CGFloat = 100
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Text("Data Gejala Pada Penyakit Ginjal")
                    .foregroundStyle(Color.white)
                    .font(.headline)
                
                Spacer()
                
                Button {
                    symptomViewModel.displayInputForm.toggle()
                } label: {
                    Image(systemName: (!symptomViewModel.displayInputForm ? "plus" : "minus"))
                        .font(.headline)
                        .foregroundStyle(Color.white)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 60, height: 30)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(Color("BrandColor", bundle: Bundle.main))
            .cornerRadius(5)
            
            if symptomViewModel.displayInputForm {
                VStack(spacing: 20) {
                    CustomInputView(text: $symptomViewModel.fatigue, title: "Gejala")
                    CustomInputView(text: $symptomViewModel.description, title: "Deskripsi")
                    
                    if selectedDiseaseID == nil {
                        Text("Penyakit belum ditentukan")
                    } else {
                        Text("Penyakit ditentukan")
                    }
                    
                    // Picker to select disease
                    Picker("Pilih Penyakit", selection: $selectedDiseaseID) {
                        Text("Belum Diset").tag(String?.none) // Placeholder option
                        ForEach(diseaseViewModel.diseases, id: \.id) { disease in
                            Text(disease.name).tag(disease.id as String?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onAppear {
                        Task {
                            await diseaseViewModel.fetchDisease()
                        }
                    }
                    
                    Button {
                        Task {
                            if let newSymptom = await symptomViewModel.addSymptom(name: symptomViewModel.fatigue, description: symptomViewModel.description) {
                                if let selectedDiseaseID = selectedDiseaseID {
                                    await diseaseViewModel.addSymptomToDisease(symptomID: newSymptom.id ?? "", diseaseID: selectedDiseaseID)
                                }
                            }
                            symptomViewModel.clearForm()
                            await loadViewModel.loadData(collection: .symptoms, rule: "")
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
                    Section("Pasien / Masyarakat Umum") {
                        if loadViewModel.isLoading && loadViewModel.symptoms.isEmpty {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .onAppear {
                                        loadViewModel.isRotating = true
                                    }
                                Spacer()
                            }
                        } else if !loadViewModel.isLoading && loadViewModel.symptoms.isEmpty {
                            Text("Data Gejala Kosong")
                        } else if let errorMessage = loadViewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        } else {
                            ForEach(loadViewModel.symptoms) { symptom in
                                NavigationLink {
                                    SymptomDetailView(symptom: symptom)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    HStack(spacing: 15) {
                                        Text(symptom.name)
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                            
                            if loadViewModel.isLoadingMore {
                                ProgressView()
                                    .onAppear {
                                        Task {
                                            await loadViewModel.loadMoreData(collection: .symptoms)
                                        }
                                    }
                            } else if !loadViewModel.isLastPage {
                                Color.clear
                                    .onAppear {
                                        Task {
                                            await loadViewModel.loadMoreData(collection: .symptoms)
                                        }
                                    }
                            }
                        }
                    }
                }
                .onAppear {
                    if hasAppeared {
                        loadViewModel.resetData(collection: .symptoms)
                    } else {
                        hasAppeared = true
                    }
                    Task {
                        await loadViewModel.loadData(collection: .symptoms, rule: "")
                    }
                }
            }
            .padding(.top, -7)
            .padding(.bottom, 50)
        }
        .gesture(
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
    SymptomDataView()
}
