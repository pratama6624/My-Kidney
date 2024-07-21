//
//  AdviceDataView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct AdviceDataView: View {
    @StateObject var adviceViewModel = AdviceViewModel()
    @State private var name = ""
    @State private var description = ""
    @State private var displayInputForm: Bool = false
    @State private var textViewHeight: CGFloat = 100
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Text("Data Tips Kesehatan Ginjal")
                    .foregroundStyle(Color.white)
                    .font(.headline)
                
                Spacer()
                
                Button {
                    displayInputForm.toggle()
                } label: {
                    Image(systemName: (!displayInputForm ? "plus" : "minus"))
                        .font(.headline)
                        .foregroundStyle(Color.white)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 60, height: 30)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(Color("BrandColor", bundle: Bundle.main))
            .cornerRadius(5)
            
            if displayInputForm {
                VStack(alignment: .leading, spacing: 20) {
                    CustomInputView(text: $name, title: "Tips")
                    
                    Text("Deskripsi")
                        .foregroundStyle(Color.gray)
                        .bold()
                        .padding(.bottom, -10)
                    
                    TextEditor(text: $description)
                        .background(GeometryReader { geometry in
                            Color.clear.preference(key: TextViewHeightPreferenceKey.self, value: geometry.size.height)
                        })
                        .frame(minHeight: textViewHeight, maxHeight: textViewHeight)
                        .onPreferenceChange(TextViewHeightPreferenceKey.self) { height in
                            textViewHeight = height
                        }
                        .padding(.horizontal, 4)
                        .foregroundStyle(Color.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(.gray), lineWidth: 1)
                        )
                    
                    Button {
                        Task {
                            await adviceViewModel.addAdvice(name: name, description: description)
                            clearForm()
                        }
                    } label: {
                        Text("Simpan")
                            .font(.headline)
                            .padding(13)
                            .foregroundStyle(Color.white)
                            .background(Color("BrandColor", bundle: Bundle.main))
                            .cornerRadius(5)
                    }
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .disabled(!formIsValid)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
            }
            
            VStack (alignment: .leading) {
                List {
                    ForEach(adviceViewModel.advices) { advice in
                        Section() {
                            VStack(alignment: .leading, spacing: 15) {
                                Text(advice.name)
                                Text(advice.description ?? "")
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                .onAppear {
                    Task {
                        await adviceViewModel.fetchAdvice()
                    }
                }
            }
            .padding(.top, -7)
        }
        .background(Color.white)
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.startLocation.x < 30 && value.translation.width > 100 {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
        )
    }
    
    private func clearForm() {
        name = ""
        description = ""
        displayInputForm = false
    }
}

extension AdviceDataView: AdviceFormInput {
    var formIsValid: Bool {
        return !name.isEmpty
        && !description.isEmpty
    }
}

#Preview {
    AdviceDataView()
}
