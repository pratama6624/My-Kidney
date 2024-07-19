//
//  ConsultationService.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ConsultationService {
    private let db = Firestore.firestore()
    private let collectionName = "consultations"
    
    func fetchConsultation() async throws -> [ConsultationModel] {
        let snapshot = try await db.collection(collectionName).getDocuments()
        return snapshot.documents.compactMap {
            try? $0.data(as: ConsultationModel.self)
        }
    }
    
    func addConsultation(_ consultation: ConsultationModel) async throws {
        _ = try db.collection(collectionName).addDocument(from: consultation)
    }
}

