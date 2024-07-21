//
//  SymptomFormView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct SymptomFormView: View {
    @StateObject var symptomViewModel = SymptomQuestionViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Hello, Pratama")
                        .font(.title)
                        .bold()
                    Text("Berikut adalah gejalapenyakit ginjal yang bisa anda pilih sesuai dengan apa yang anda rasakan")
                        .padding(.bottom, 20)
                    Text("Klik Submit setelah menjawab semua pertanyaan dan mendapatkan hasil diagnosa, saran, dan solusi")
                        .padding(.bottom, 20)
                    
                    if symptomViewModel.showResults {
                        QuizAnswersView(results: symptomViewModel.diagnosisResults)
                    } else {
                        
                        Text("Pertanyaan \(symptomViewModel.currentQuestionIndex + 1)")
                            .font(.title2)
                        Text(symptomViewModel.questions[symptomViewModel.currentQuestionIndex])
                            .font(.headline)
                        
                        HStack(spacing: 20) {
                            Button {
                                symptomViewModel.answer = "Iya"
                                symptomViewModel.saveAnswer()
                                symptomViewModel.nextQuestion()
                            } label: {
                                Text("Iya")
                                    .font(.headline)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 18)
                                    .foregroundStyle(Color.white)
                                    .background(Color("BrandColor", bundle: Bundle.main))
                                    .cornerRadius(5)
                            }
                            
                            Button {
                                symptomViewModel.answer = "Tidak"
                                symptomViewModel.saveAnswer()
                                symptomViewModel.nextQuestion()
                            } label: {
                                Text("Tidak")
                                    .font(.headline)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 18)
                                    .foregroundStyle(Color.white)
                                    .background(Color("BrandColor", bundle: Bundle.main))
                                    .cornerRadius(5)
                            }
                            
                            Spacer()
                            
                            Text("Reset")
                        }
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .padding(20)
        .cornerRadius(20)
    }
}

#Preview {
    SymptomFormView()
}
