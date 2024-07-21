//
//  DiseaseDataView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct DiseaseDataView: View {
    @StateObject var diseaseViewModel = DiseaseViewModel()
    @StateObject var loadViewModel = LoadViewModel()
    @State private var hasAppeared = false
    @State private var textViewHeight: CGFloat = 100
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Text("Data Penyakit Pada Ginjal")
                    .foregroundStyle(Color.white)
                    .font(.headline)
                
                Spacer()
                
                Button {
                    diseaseViewModel.displayInputForm.toggle()
                } label: {
                    Image(systemName: (!diseaseViewModel.displayInputForm ? "plus" : "minus"))
                        .font(.headline)
                        .foregroundStyle(Color.white)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 60, height: 30)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(Color("BrandColor", bundle: Bundle.main))
            .cornerRadius(5)
            
            if diseaseViewModel.displayInputForm {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Penyakit")
                        .foregroundStyle(Color.gray)
                        .bold()
                        .padding(.bottom, -10)
                    
                    CustomInputView(text: $diseaseViewModel.disease, title: "")
                    
                    Text("Deskripsi")
                        .foregroundStyle(Color.gray)
                        .bold()
                        .padding(.bottom, -10)
                    
                    TextEditor(text: $diseaseViewModel.description)
                        .background(GeometryReader { geometry in
                            Color.clear.preference(key: TextViewHeightPreferenceKey.self, value: geometry.size.height)
                        })
                        .frame(minHeight: textViewHeight, maxHeight: textViewHeight)
                        .onPreferenceChange(TextViewHeightPreferenceKey.self) { height in
                            textViewHeight = height
                        }
                        .padding(.horizontal, 4)
                        .foregroundStyle(Color.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(.gray), lineWidth: 1)
                        )
                    
                    Text("Solusi / Perlakuan")
                        .foregroundStyle(Color.gray)
                        .bold()
                        .padding(.bottom, -10)
                    
                    CustomInputView(text: $diseaseViewModel.treatment, title: "")
                    
                    Button {
                        Task {
                            await diseaseViewModel.addDisease(name: diseaseViewModel.disease, description: diseaseViewModel.description, symptomIDs: [], treatment: diseaseViewModel.treatment)
                            diseaseViewModel.clearForm()
                            await loadViewModel.loadData(collection: .diseases, rule: "")
                        }
                    } label: {
                        Text("Simpan")
                            .font(.headline)
                            .padding(13)
                            .foregroundStyle(Color.white)
                            .background(Color("BrandColor", bundle: Bundle.main))
                            .cornerRadius(5)
                    }
                    .opacity(diseaseViewModel.diseaseFormIsValid ? 1.0 : 0.5)
                    .disabled(!diseaseViewModel.diseaseFormIsValid)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
            }
            
            VStack (alignment: .leading) {
                List {
                    Section("Pasien / Masyarakat Umum") {
                        if loadViewModel.isLoading && loadViewModel.diseases.isEmpty {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .onAppear {
                                        loadViewModel.isRotating = true
                                    }
                                Spacer()
                            }
                        } else if !loadViewModel.isLoading && loadViewModel.diseases.isEmpty {
                            Text("Data Penyakit Kosong")
                        } else if let errorMessage = loadViewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        } else {
                            ForEach(loadViewModel.diseases) { disease in
                                NavigationLink {
                                    DiseaseDetailView(diseases: disease)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    HStack(spacing: 15) {
                                        Text(disease.name)
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                            
                            if loadViewModel.isLoadingMore {
                                ProgressView()
                                    .onAppear {
                                        Task {
                                            await loadViewModel.loadMoreData(collection: .diseases)
                                        }
                                    }
                            } else if !loadViewModel.isLastPage {
                                Color.clear
                                    .onAppear {
                                        Task {
                                            await loadViewModel.loadMoreData(collection: .diseases)
                                        }
                                    }
                            }
                        }
                    }
                }
                .onAppear {
                    if hasAppeared {
                        loadViewModel.resetData(collection: .diseases)
                    } else {
                        hasAppeared = true
                    }
                    Task {
                        await loadViewModel.loadData(collection: .diseases, rule: "")
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
    DiseaseDataView()
}
