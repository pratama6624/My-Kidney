//
//  EventModel.swift
//  My Kidney
//
//  Created by Pratama One on 18/07/24.
//

import Foundation
import FirebaseFirestoreSwift

enum EventType: String, Codable {
    case online = "online"
    case offline = "offline"
}

// Model untuk Event
struct EventModel: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var date = Date()
    var time: String
    var type: EventType
    var location: String
    var speakers: [String] = []
    var fee: Bool = false
    var price: Double = 0.0
    var registrationDeadline = Date()
    var quota: Int = 0
    var agenda: [String: String] = [:]
    
    init(id: String? = nil, title: String, date: Date, time: String, type: EventType, location: String, speakers: [String], fee: Bool, price: Double, registrationDeadline: Date, quota: Int, agenda: [String: String]) {
        self.id = id
        self.title = title
        self.date = date
        self.time = time
        self.type = type
        self.location = location
        self.speakers = speakers
        self.fee = fee
        self.price = price
        self.registrationDeadline = registrationDeadline
        self.quota = quota
        self.agenda = agenda
    }
}

