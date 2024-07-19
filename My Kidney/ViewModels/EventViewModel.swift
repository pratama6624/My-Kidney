//
//  EventViewModel.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol EventFormInput {
    var eventFormIsValid: Bool { get }
}

@MainActor
class EventViewModel: ObservableObject {
    @Published var events: [EventModel] = []
    private var eventService = EventService()
    
    func fetchEvent() async {
        do {
            self.events = try await eventService.fetchEvent()
        } catch {
            print("DEBUG: Failed to fetch Event with error \(error.localizedDescription)")
        }
    }
    
    func addEvent(title: String, date: Date, time: String, type: EventType, location: String, speakers: [String], fee: Bool, price: Double, registrationDeadline: Date, quota: Int, agenda: [String: String]) async {
        let event = EventModel(title: title, date: date, time: time, type: type, location: location, speakers: speakers, fee: fee, price: price, registrationDeadline: registrationDeadline, quota: quota, agenda: agenda)
        do {
            try await eventService.addEvent(event)
            await fetchEvent()
        } catch {
            print("DEBUG: Failed to add Event with error \(error.localizedDescription)")
        }
    }
}

