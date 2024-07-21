//
//  AboutAppView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct AboutAppView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Apa itu \"My Kidney\"")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.all, 10)
                        .foregroundStyle(.white)
                        .background(Color("BrandColor", bundle: Bundle.main))
                        .cornerRadius(10)
                    
                    Text(AppInfoData.aboutMyKidney)
                        .padding(.bottom, 20)
                    
                    Text("Untuk siapa aplikasi ini?")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(AppInfoData.madeFor, id: \.0) { item in
                            Text(item.0)
                                .font(.headline)
                            
                            Text(item.1)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    Text("Mengapa memilih \"My Kidney\"?")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(AppInfoData.whyChooseUs, id: \.0) { item in
                            Text(item.0)
                                .font(.headline)
                            
                            Text(item.1)
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
    AboutAppView()
}
