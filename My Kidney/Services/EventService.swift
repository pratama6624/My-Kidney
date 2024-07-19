//
//  EventService.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class EventService {
    private let db = Firestore.firestore()
    private let collectionName = "events"
    
    func fetchEvent() async throws -> [EventModel] {
        let snapshot = try await db.collection(collectionName).getDocuments()
        return snapshot.documents.compactMap {
            try? $0.data(as: EventModel.self)
        }
    }
    
    func addEvent(_ event: EventModel) async throws {
        _ = try db.collection(collectionName).addDocument(from: event)
    }
}
