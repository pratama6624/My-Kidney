//
//  FeaturesView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct FeaturesView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Fitur-Fitur di \"My Kidney\"")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.all, 10)
                        .foregroundStyle(.white)
                        .background(Color("BrandColor", bundle: Bundle.main))
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 40) {
                        ForEach(AppInfoData.features, id: \.0) { category in
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(category.1, id: \.0) { item in
                                    Text("\(item.0) (\(category.0))")
                                        .font(.headline)
                                    Text(item.1)
                                }
                            }
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
    FeaturesView()
}
