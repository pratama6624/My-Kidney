//
//  DiagnosisService.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class DiagnosisService {
    private let db = Firestore.firestore()
    private let collectionName = "diagnosis"
    
    // Fecth Diagnosis
    func fetchDiagnosis() async throws -> [DiagnosisModel] {
        let snapshot = try await db.collection(collectionName).getDocuments()
        return snapshot.documents.compactMap {
            try? $0.data(as: DiagnosisModel.self)
        }
    }
    
    func addDiagnosis(_ diagnosis: DiagnosisModel) async throws {
        _ = try db.collection(collectionName).addDocument(from: diagnosis)
    }
}
