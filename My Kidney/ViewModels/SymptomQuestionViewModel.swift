//
//  SymptomQuestionViewModel.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation

class SymptomQuestionViewModel: ObservableObject {
    @Published var currentQuestionIndex: Int = 0
    @Published var answer: String = ""
    @Published var showAlert: Bool = false
    @Published var showResults: Bool = false
    @Published var diagnosisResults = [SymptonQuestionModel]()
    
    let questions = [
        "Berkurang rasa terutama di tangan?",
        "Apakah Anda mengalami kesulitan tidur atau insomnia?",
        "Apakah Anda merasakan nyeri atau tekanan di punggung bawah atau sisi tubuh?",
        "Apakah Anda mengalami pembengkakan pada kaki, pergelangan kaki, atau tangan?",
        "Apakah Anda mengalami perubahan pada frekuensi atau jumlah buang air kecil?",
        "Apakah Anda melihat adanya darah dalam urine Anda?",
        "Apakah urine Anda terlihat berbusa atau berbuih?",
        "Apakah Anda merasakan nyeri atau sensasi terbakar saat buang air kecil?",
        "Apakah Anda mengalami mual atau muntah secara teratur?",
        "Apakah Anda mengalami kehilangan nafsu makan?",
        "Apakah kulit Anda terasa gatal atau kering?",
        "Apakah Anda sering mengalami kram otot, terutama di kaki?",
        "Apakah Anda merasa sesak napas atau mengalami kesulitan bernapas?",
        "Apakah Anda mengalami tekanan darah tinggi?",
        "Apakah Anda merasa pusing atau sering pingsan?",
        "Apakah Anda mengalami perubahan warna kulit menjadi lebih gelap atau lebih pucat?",
        "Apakah Anda mengalami kesulitan berkonsentrasi atau merasa bingung?",
        "Apakah Anda mengalami perasaan dingin, bahkan ketika berada di lingkungan yang hangat?",
        "Apakah Anda mengalami penurunan berat badan yang tidak dapat dijelaskan?",
        "Apakah Anda merasa nyeri atau perih di area sekitar ginjal (di bawah tulang rusuk)?"
    ]
    
    func saveAnswer() {
        let diagnosisResult = SymptonQuestionModel(question: questions[currentQuestionIndex], answer: answer)
        diagnosisResults.append(diagnosisResult)
    }
    
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            answer = ""
        } else {
            showResults = true
        }
    }
}

