//
//  QuizAnswersView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct QuizAnswersView: View {
    var results: [SymptonQuestionModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Jawaban anda:")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.all, 10)
                .foregroundStyle(.black)
                .background(Color.yellow)
                .cornerRadius(10)
            
            ForEach(0..<results.count, id:\.self) { index in
                HStack {
                    Text(results[index].question)
                    Spacer()
                    Text(results[index].answer)
                        .bold()
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)
            }
            
            
            
            Spacer()
        }
    }
}

#Preview {
    QuizAnswersView(results: [
        SymptonQuestionModel(question: "Pertanyaan?", answer: "Jawaban"),
        SymptonQuestionModel(question: "Pertanyaan?", answer: "Jawaban"),
        SymptonQuestionModel(question: "Pertanyaan?", answer: "Jawaban")
    ])
}
