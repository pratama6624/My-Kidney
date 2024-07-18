//
//  RuleModel.swift
//  My Kidney
//
//  Created by Pratama One on 18/07/24.
//

import Foundation
import FirebaseFirestoreSwift

// Note: Collections antara pasien, dokter, dan admin dijadikan satu (users)
enum UserType: String, Codable {
    case admin = "Admin"
    case patient = "Patient"
    case doctor = "Doctor"
}

// Admin Collections
struct Admin: Identifiable, Codable {
    @DocumentID var id: String?
    var fullname: String
    var address: String?
    var telepon: String?
    var accessStatus: Int
    var rule: String
    var photoURL: String?
    var providerId: String?
}

// Patient Collections
struct Patient: Identifiable, Codable {
    @DocumentID var id: String?
    var fullname: String
    var dateOfBirth: String?
    var address: String?
    var telepon: String?
    var diagnosticHistory: [String]?
    var consultationHistory: [String]?
    var accessStatus: Int
    var rule: String
    var photoURL: String?
    var providerId: String?
}

// Doctor Collections
struct Doctor: Identifiable, Codable {
    @DocumentID var id: String?
    var fullname: String
//    var email: String // ini kayanya yang bikin tabrakan
//    (di UserModel uda ada tapi disini ada lagi) coba cek tar sore
    var address: String?
    var telepon: String?
    var specialization: String?
    var licenseNumber: String?
    var accessStatus: Int
    var rule: String
    var education: String?
    var graduatingYear: String?
    var practicePlace: String?
    var practiceSchedule: [String: String]?
    var photoURL: String?
    var providerId: String?
}

struct UserModel: Identifiable, Codable {
    @DocumentID var id: String?
    var email: String
    var userType: UserType
    var userDetails: UserDetails
    
    var fullname: String {
        switch userDetails {
        case .patient(let patient):
            return patient.fullname
        case .doctor(let doctor):
            return doctor.fullname
        case .admin(let admin):
            return admin.fullname
        }
    }
    
    var practicePlace: String {
        switch userDetails {
        case .patient(_):
            return ""
        case .doctor(let doctor):
            return doctor.practicePlace ?? "-"
        case .admin(_):
            return ""
        }
    }
    
    var isAdmin: Bool {
        if case .admin = userDetails {
            return true
        }
        return false
    }
    
    var isPatient: Bool {
        if case .patient = userDetails {
            return true
        }
        return false
    }
    
    var isDoctor: Bool {
        if case .doctor = userDetails {
            return true
        }
        return false
    }
}

// Dari decode UserModel ke encode Firebase
enum UserDetails: Codable {
    case admin(Admin)
    case patient(Patient)
    case doctor(Doctor)
    
    // Decode UserModel
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // Admin decode
        if let admin = try? container.decode(Admin.self), admin.rule == "admin" {
            print("DEBUG: Decoded as Admin")
            self = .admin(admin)
            return
        }
        // Patient decode
        if let patient = try? container.decode(Patient.self), patient.rule == "patient" {
            print("DEBUG: Decoded as Patient")
            self = .patient(patient)
            return
        }
        //Doctor decode
        if let doctor = try? container.decode(Doctor.self), doctor.rule == "doctor" {
            print("DEBUG: Decoded as Doctor")
            self = .doctor(doctor)
            return
        }
        throw DecodingError.typeMismatch(UserDetails.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type user detail"))
    }
    
    // Encode UserModel
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .admin(let admin):
            try container.encode(admin)
        case .patient(let patient):
            try container.encode(patient)
        case .doctor(let doctor):
            try container.encode(doctor)
        }
    }
}

