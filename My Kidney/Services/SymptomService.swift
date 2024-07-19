//
//  SymptomService.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class SymptomService {
    private let db = Firestore.firestore()
    private let collectionName = "symptoms"
    
    func fetchSymptom() async throws -> [SymptomModel] {
        let snapshot = try await db.collection(collectionName).getDocuments()
        return snapshot.documents.compactMap {
            try? $0.data(as: SymptomModel.self)
        }
    }
    
    func addSymptom(_ symptom: SymptomModel) async throws -> SymptomModel {
        let ref = try db.collection(collectionName).addDocument(from: symptom)
        var newSymptom = symptom
        newSymptom.id = ref.documentID
        return newSymptom
    }
    
    func fetchSymptoms(byIDs ids: [String]) async throws -> [SymptomModel] {
        var symptoms: [SymptomModel] = []
        for id in ids {
            guard !id.isEmpty else {
                print("DEBUG: Skipping empty ID")
                continue
            }
            
            let document = try await db.collection(collectionName).document(id).getDocument()
            if let symptom = try? document.data(as: SymptomModel.self) {
                symptoms.append(symptom)
            } else {
                print("DEBUG: Failed to fetch symptom for ID: \(id)")
            }
        }
        
        return symptoms
    }
}
