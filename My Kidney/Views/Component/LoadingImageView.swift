//
//  LoadingImageView.swift
//  My Kidney
//
//  Created by Pratama One on 20/07/24.
//

import SwiftUI

struct LoadingImageView: View {
    var body: some View {
        Image(systemName: "arrow.triangle.2.circlepath")
            .resizable()
            .scaledToFit()
            .font(.title3)
            .bold()
            .frame(width: 40, height: 40)
            .foregroundStyle(Color("BrandColor", bundle: Bundle.main))
    }
}

#Preview {
    LoadingImageView()
}
