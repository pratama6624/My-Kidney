//
//  AdviceService.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AdviceService {
    private let db = Firestore.firestore()
    private let collectionName = "advices"
    
    func fetchAdvice() async throws -> [AdviceModel] {
        let snapshot = try await db.collection(collectionName).getDocuments()
        return snapshot.documents.compactMap {
            try? $0.data(as: AdviceModel.self)
        }
    }
    
    func addAdvice(_ advice: AdviceModel) async throws {
        _ = try db.collection(collectionName).addDocument(from: advice)
    }
}
