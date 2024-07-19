//
//  DiseaseViewModel.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol DiseaseFormProtocol {
    var diseaseFormIsValid: Bool { get }
}

@MainActor
class DiseaseViewModel: ObservableObject {
    @Published var diseases: [DiseaseModel] = []
    private let diseaseService = DiseaseService()
    
    // Disease Data View
    @Published var disease = ""
    @Published var description = ""
    @Published var treatment = ""
    @Published var displayInputForm: Bool = false
    @Published var displayInputFormAddSymptom: Bool = false
    
    func fetchDisease() async {
        do {
            self.diseases = try await diseaseService.fetchDisease()
        } catch {
            print("DEBUG: Failed to fetch Disease with error \(error.localizedDescription)")
        }
    }
    
    func addDisease(name: String, description: String, symptomIDs: [String], treatment: String) async {
        let disease = DiseaseModel(name: name, description: description, symptomIDs: symptomIDs, treatment: treatment)
        do {
            try await diseaseService.addDisease(disease)
            await fetchDisease()
        } catch {
            print("DEBUG: Failed to add Symptom with error \(error.localizedDescription)")
        }
    }
    
    func addSymptomToDisease(symptomID: String, diseaseID: String) async {
        do {
            try await diseaseService.addSymptomToDisease(symptomID: symptomID, diseaseID: diseaseID)
            if let index = diseases.firstIndex(where: { $0.id == diseaseID }) {
                diseases[index].symptomIDs.append(symptomID)
            }
            await fetchDisease()
            self.displayInputFormAddSymptom = false
        } catch {
            print("DEBUG: Failed to add Symptom to Disease with error \(error.localizedDescription)")
        }
    }
    
    func clearForm() {
        disease = ""
        description = ""
        treatment = ""
        displayInputForm = false
    }
}

extension DiseaseViewModel: DiseaseFormProtocol {
    var diseaseFormIsValid: Bool {
        return !disease.isEmpty
        && !description.isEmpty
        && !treatment.isEmpty
    }
}
