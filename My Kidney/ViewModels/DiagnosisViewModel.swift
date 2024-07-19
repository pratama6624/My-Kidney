//
//  DiagnosisViewModel.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class DiagnosisViewModel: ObservableObject {
    @Published var diagnosis: [DiagnosisModel] = []
    private let diagnosisService = DiagnosisService()
    
    func fetchDiagnosis() async {
        do {
            self.diagnosis = try await diagnosisService.fetchDiagnosis()
        } catch {
            print("DEBUG: Failed to fetch Diagnosis with error \(error.localizedDescription)")
        }
    }
    
    func addDiagnosis(userID: String, symptomIDs: [String], diseaseID: String, date: Date) async {
        let diagnosis = DiagnosisModel(userID: userID, symptomIDs: symptomIDs, diseaseID: diseaseID, date: date)
        do {
            try await diagnosisService.addDiagnosis(diagnosis)
            await fetchDiagnosis()
        } catch {
            print("DEBUG: Failed to add Diagnosis with error \(error.localizedDescription)")
        }
    }
}
