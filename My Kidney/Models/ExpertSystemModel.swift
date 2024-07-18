//
//  ExpertSystemModel.swift
//  My Kidney
//
//  Created by Pratama One on 18/07/24.
//

import Foundation
import FirebaseFirestoreSwift

// Model untuk Penyakit
struct DiseaseModel: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String?
    var symptomIDs: [String]
    var treatment: String? // Solusi
    
    init(id: String? = nil, name: String, description: String? = nil, symptomIDs: [String], treatment: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.symptomIDs = symptomIDs
        self.treatment = treatment
    }
}

// Model untuk Gejala
struct SymptomModel: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String?
    
    init(id: String? = nil, name: String, description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
    }
}

// Model untuk Advice atau Saran untuk menghadapi suatu penyakit pada ginjal
struct AdviceModel: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String?
    
    init(id: String? = nil, name: String, description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
    }
}

// Model untuk Diagnosa system
struct DiagnosisModel: Identifiable, Codable {
    @DocumentID var id: String?
    var userID: String
    var symptomIDs: [String]
    var diseaseID: String
    var date: Date
    
    init(id: String? = nil, userID: String, symptomIDs: [String], diseaseID: String, date: Date) {
        self.id = id
        self.userID = userID
        self.symptomIDs = symptomIDs
        self.diseaseID = diseaseID
        self.date = date
    }
}

// Model untuk Konsultasi pasien ke dokter
struct ConsultationModel: Identifiable, Codable {
    @DocumentID var id: String?
    var doctorID: String
    var patientID: String
    var date: Date
    var note: String
    
    init(id: String? = nil, doctorID: String, patientID: String, date: Date, note: String) {
        self.id = id
        self.doctorID = doctorID
        self.patientID = patientID
        self.date = date
        self.note = note
    }
}

struct Events: Identifiable, Codable {
    @DocumentID var id: String?
    
}

// Model untuk Quiz input Gejala
struct SymptonQuestionModel: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

