//
//  ProblemTipsView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct ProblemTipsView: View {
    var problemTips: [String] = []
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Saran untuk masalah serius")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.all, 10)
                        .foregroundStyle(.white)
                        .background(Color("BrandColor", bundle: Bundle.main))
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(0..<problemTips.count, id: \.self) { index in
                            Text(problemTips[index])
                        }
                    }
                    .padding(.bottom, 20)
                }
                .padding(.bottom, 30)
            }
        }
        .padding(20)
        .cornerRadius(20)
    }
}

#Preview {
    ProblemTipsView(problemTips: [])
}
