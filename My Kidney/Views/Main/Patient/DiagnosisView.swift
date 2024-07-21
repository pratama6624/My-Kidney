//
//  DiagnosisView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct DiagnosisView: View {
    @State private var showSymptomForm: Bool = false
    @State private var showDiagnosisResultView: Bool = false
    @State private var showProblemTipsView: Bool = false
    @State private var showDiagnosisHistoryView: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Image("diagnosisLogo")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 20)
                        .cornerRadius(10)
                    
                    Text("Langkah-Langkah Awal:")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Button {
                            withAnimation {
                                showSymptomForm.toggle()
                            }
                        } label: {
                            HStack {
                                Text("1. Isi Kuesioner")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .padding()
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(10)
                        .popover(isPresented: $showSymptomForm, arrowEdge: .top) {
                            GeometryReader { geometry in
                                SymptomFormView()
                            }
                        }
                        
                        Button {
                            withAnimation {
                                showDiagnosisResultView.toggle()
                            }
                        } label: {
                            HStack {
                                Text("2. Analisis AI")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(10)
                        .popover(isPresented: $showDiagnosisResultView, arrowEdge: .top) {
                            GeometryReader { geometry in
                                DiagnosisResultView()
                            }
                        }
                        
                        Button {
                            withAnimation {
                                showProblemTipsView.toggle()
                            }
                        } label: {
                            HStack {
                                Text("3. Saran Tindakan Lanjut")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .padding()
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(10)
                        .popover(isPresented: $showProblemTipsView, arrowEdge: .top) {
                            GeometryReader { geometry in
                                ProblemTipsView(problemTips: [])
                            }
                        }
                        
                        Text("Tahap Lanjutan:")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.vertical, 15)
                        
                        Button {
                            withAnimation {
                                showDiagnosisHistoryView.toggle()
                            }
                        } label: {
                            HStack {
                                Text("4. Riwayat Diagnosa")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .popover(isPresented: $showDiagnosisHistoryView, arrowEdge: .top) {
                            GeometryReader { geometry in
                                DiagnosisHistoryView()
                            }
                        }
                    }
                    .padding(.bottom, 30)
                }
                .frame(width: UIScreen.main.bounds.width - 40)
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    DiagnosisView()
}
