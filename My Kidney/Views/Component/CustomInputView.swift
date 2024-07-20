//
//  CustomInputView.swift
//  My Kidney
//
//  Created by Pratama One on 20/07/24.
//

import SwiftUI

struct CustomInputView: View {
    @Binding var text: String
    let title: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !isSecureField {
                TextField(title, text: $text)
                    .foregroundStyle(Color.gray)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.gray), lineWidth: 1)
                    )
            } else {
                SecureField(title, text: $text)
                    .foregroundStyle(Color.gray)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.gray), lineWidth: 1)
                    )
            }
        }
    }
}

#Preview {
    CustomInputView(text: .constant(""), title: "Email")
}
