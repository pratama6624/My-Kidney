//
//  ConsultationVewModel.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class ConsultationViewModel: ObservableObject {
    @Published var consultations: [ConsultationModel] = []
    private let consultationService = ConsultationService()
    
    func fetchConsultation() async {
        do {
            self.consultations = try await consultationService.fetchConsultation()
        } catch {
            print("DEBUG: Failed to fetch Consultation with error \(error.localizedDescription)")
        }
    }
    
    func addConsultation(doctorID: String, patientID: String, date: Date, note: String) async throws {
        let consultation = ConsultationModel(doctorID: doctorID, patientID: patientID, date: date, note: note)
        do {
            try await consultationService.addConsultation(consultation)
            await fetchConsultation()
        } catch {
            print("DEBUG: Failed to add Consultation with error \(error.localizedDescription)")
        }
    }
}

