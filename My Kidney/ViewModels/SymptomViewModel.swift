//
//  SymptomViewModel.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol SymptomFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class SymptomViewModel: ObservableObject {
    @Published var symptoms: [SymptomModel] = []
    @Published var newSymptomsIDs: [String] = []
    private let symptomService = SymptomService()
    
    @Published var fatigue = ""
    @Published var description = ""
    @Published var displayInputForm: Bool = false
    
    // Untuk append load realtime data gejala pada penyakit jika anda masih berada di halaman yang sama
    func appendSymptomsIDs(_ ids: [String]) {
        // Gabungkan arrays dan hapus duplikat
        let uniqueIDs = Array(Set(newSymptomsIDs + ids))
        newSymptomsIDs = uniqueIDs
    }
    
    // Fetch Symptom
    func fetchSymptom() async {
        do {
            self.symptoms = try await symptomService.fetchSymptom()
        } catch {
            print("DEBUG: Failed to fetch Symptom with error \(error.localizedDescription)")
        }
    }
    
    // Save atau Add Symptom
    func addSymptom(name: String, description: String, fromSingleDisease: Bool = false) async -> SymptomModel? {
        let symptom = SymptomModel(name: name, description: description)
        do {
            let newSymptom = try await symptomService.addSymptom(symptom)
            if !fromSingleDisease {
                await fetchSymptom()
            }
            return newSymptom
        } catch {
            print("DEBUG: Failed to add symptom with error \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchSymptoms(byIDs ids: [String]) async {
        do {
            self.symptoms = try await symptomService.fetchSymptoms(byIDs: ids)
        } catch {
            print("DEBUG: Failed to fetch Symptoms by IDs with error \(error.localizedDescription)")
        }
    }
    
    func clearForm() {
        fatigue = ""
        description = ""
        displayInputForm = false
    }
}

extension SymptomViewModel: @preconcurrency SymptomFormProtocol {
    var formIsValid: Bool {
        return !fatigue.isEmpty
        && !description.isEmpty
    }
}
