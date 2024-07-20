//
//  LoadingMessageView.swift
//  My Kidney
//
//  Created by Pratama One on 20/07/24.
//

import SwiftUI

struct LoadingMessageView: View {
    var body: some View {
        Text("Loading")
            .font(.title3)
            .bold()
            .foregroundStyle(Color("BrandColor", bundle: Bundle.main))
    }
}

#Preview {
    LoadingMessageView()
}
