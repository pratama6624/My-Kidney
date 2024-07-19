//
//  AdviceViewModel.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AdviceFormInput {
    var formIsValid: Bool { get }
}

@MainActor
class AdviceViewModel: ObservableObject {
    @Published var advices: [AdviceModel] = []
    private var adviceService = AdviceService()
    
    func fetchAdvice() async {
        do {
            self.advices = try await adviceService.fetchAdvice()
        } catch {
            print("DEBUG: Failed to fetch Advice with error \(error.localizedDescription)")
        }
    }
    
    func addAdvice(name: String, description: String) async {
        let advice = AdviceModel(name: name, description: description)
        do {
            try await adviceService.addAdvice(advice)
            await fetchAdvice()
        } catch {
            print("DEBUG: Failed to add Advice with error \(error.localizedDescription)")
        }
    }
}
