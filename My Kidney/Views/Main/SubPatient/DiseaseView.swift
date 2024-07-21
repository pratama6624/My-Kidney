//
//  DiseaseView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct DiseaseView: View {
    @State private var isLoading: Bool = false
    var body: some View {
        NavigationStack {
            if isLoading {
                LoadingMessageView()
                    .task {
//                        await loadData()
                    }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Health Tips
                        Text("Macam-Macam Penyakit Ginjal")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .foregroundStyle(.white)
                            .background(Color("BrandColor", bundle: Bundle.main))
                            .cornerRadius(10)
                        
                        
                        ForEach(0..<4) { _ in
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Chronic Kidney Disease - CKD")
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                    .padding(.bottom, 10)
                                Text("Penyakit ginjal yang telah berlangsung lama sehingga menyebabkan gagal ginjal. Ginjal menyaring kotoran dan kelebihan cairan dari darah. Apabila ginjal tidak berfungsi, kotoran menumpuk. Gejala berkembang perlahan dan tidak spesifik untuk penyakit ini. Sebagian orang tidak memiliki gejala sama sekali, dan didiagnosis lewat tes laboratorium. Obat-obatan membantu mengelola gejalanya. Stadium lanjut dapat memerlukan penyaringan darah dengan mesin (cuci darah) atau transplantasi.")
                                    .padding(.bottom, 10)
                                Text("1. Sering kelelahan")
                                Text("2. Pembengkakan di kaki dan tangan")
                                Text("3. Sesak Napas")
                                Text("4. Mual atau muntah")
                                Text("5. Kebingungan")
                                Text("6. Penurunan nafsu makan")
                                Text("7. Sering buang air kecil")
                                Text("8. Terdapat darah di urine")
                                
                                Text("Solusi: Transplantasi atau operasi pada ginjal")
                                    .padding(.top, 10)
                                    .padding(.bottom, 30)
                            }
                        }
                    }
                }
            }
        }
        .padding(20)
        .cornerRadius(20)
    }
}

#Preview {
    DiseaseView()
}
