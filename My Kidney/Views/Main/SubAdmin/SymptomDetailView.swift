//
//  SymptomDetailView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct SymptomDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    var symptom: SymptomModel
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text("Gagal Ginjal")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                Text("Chronic Kidney Disease - CKD")
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 20)
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 100, alignment: .leading)
            .background(Color("BrandColor", bundle: Bundle.main))
            .cornerRadius(10)
            .padding(.bottom, 10)
           
            VStack (alignment: .leading) {
//                List {
//                    Section("Data Gejala") {
//                        ForEach(dataGejala, id: \.self) { gejala in
//                            HStack(spacing: 15) {
//                                Text(gejala)
//                            }
//                            .padding(.vertical, 8)
//                        }
//                    }
//
//                    Section("Data Solusi") {
//                        HStack(spacing: 15) {
//                            Text("Transplantasi atau operasi pada ginjal")
//                        }
//                        .padding(.vertical, 8)
//                    }
//                }
            }
        }
        .padding(.bottom, 60)
    }
}

#Preview {
    SymptomDetailView(symptom: SymptomModel(name: "", description: ""))
}
