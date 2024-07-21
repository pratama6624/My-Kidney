//
//  HealthTipsView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct HealthTipsView: View {
    @StateObject var adviceViewModel = AdviceViewModel()
    @State private var localAdvices: [AdviceModel] = []
    @State private var isLoading: Bool = true

    var body: some View {
        NavigationStack {
            if isLoading {
                LoadingMessageView()
                    .task {
                        await loadData()
                    }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Health Tips
                        Text("Tips Kesehatan Ginjal")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .foregroundStyle(.white)
                            .background(Color("BrandColor", bundle: Bundle.main))
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(localAdvices) { advice in
                                Text(advice.name)
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                
                                Text("\(advice.description ?? "")")
                                    .padding(.bottom, 20)
                            }
                        }
                    }
                }
            }
        }
        .padding(20)
        .cornerRadius(20)
    }
    
    func loadData() async {
        await adviceViewModel.fetchAdvice()
        localAdvices = adviceViewModel.advices
        isLoading = false
    }
}

#Preview {
    HealthTipsView()
}
