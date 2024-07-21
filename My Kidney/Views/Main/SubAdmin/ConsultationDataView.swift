//
//  ConsultationDataView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct ConsultationDataView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(spacing: 15) {
                    Text("PO")
                        .foregroundColor(Color("BrandColor", bundle: Bundle.main))
                        .font(.title3)
                        .bold()
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .cornerRadius(100)
                    
                    VStack(alignment: .leading) {
                        Text("Pratama")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                        Text("Pasien")
                            .font(.headline)
                            .foregroundColor(Color.white)
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
                    Section("Pasien / Masyarakat Umum") {
                        ForEach(0..<10) { _ in
                            NavigationLink {
//                                DiseaseDetailView()
//                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 15) {
                                    Text("Data Riwayat Consultasi")
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    }
                }
                .onAppear {
                    Task {
                        // Do Something
                    }
                }
            }
            .padding(.top, -7)
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
    ConsultationDataView()
}
