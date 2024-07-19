//
//  DiseaseService.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class DiseaseService {
    private let db = Firestore.firestore()
    private let collectionName = "diseases"
    
    // Fetch Diseases
    func fetchDisease() async throws -> [DiseaseModel] {
        let snapshot = try await db.collection(collectionName).getDocuments()
        return snapshot.documents.compactMap {
            try? $0.data(as: DiseaseModel.self)
        }
    }
    
    // Add Disease
    func addDisease(_ disease: DiseaseModel) async throws {
        _ = try db.collection(collectionName).addDocument(from: disease)
    }
    
    // Delete Disease
    func removeDisease() {
        
    }
    
    func addSymptomToDisease(symptomID: String, diseaseID: String) async throws {
        let diseaseRef = db.collection("diseases").document(diseaseID)
        
        _ = try await db.runTransaction { (transaction, errorPointer) -> Any? in
            let diseaseDocument: DocumentSnapshot
            do {
                try diseaseDocument = transaction.getDocument(diseaseRef)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            
            guard let diseaseData = diseaseDocument.data() else {
                let error = NSError(domain: "app", code: 0, userInfo: [
                    NSLocalizedDescriptionKey: "Unable to retrieve disease data."
                ])
                errorPointer?.pointee = error
                return nil
            }
            
            var symptomIDs = diseaseData["symptomIDs"] as? [String] ?? []
            if !symptomIDs.contains(symptomID) {
                symptomIDs.append(symptomID)
            }
            
            transaction.updateData(["symptomIDs": symptomIDs], forDocument: diseaseRef)
            
            return nil
        }
    }
}
