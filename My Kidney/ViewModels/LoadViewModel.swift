//
//  LoadViewModel.swift
//  My Kidney
//
//  Created by Pratama One on 19/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

enum DataCollection: String {
    case users
    case diseases
    case symptoms
    case advices
}

@MainActor
class LoadViewModel: ObservableObject {
    private var lastDocuments: [DataCollection: DocumentSnapshot] = [:]
    @Published var isRotating: Bool = false
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var isLastPage: Bool = false
    @Published var errorMessage: String?
    @Published var pageSize: Int = 1
    private let db = Firestore.firestore()
    
    // Data Collections
    @Published var users: [UserModel] = []
    // Separate collections for patients and doctors
    @Published var patients: [UserModel] = []
    @Published var doctors: [UserModel] = []
    @Published var diseases: [DiseaseModel] = []
    @Published var symptoms: [SymptomModel] = []
    @Published var advices: [AdviceModel] = []
    
    func loadPatients() async {
        await resetAndLoadData(collection: .users, rule: "Patient")
    }

    func loadMorePatients() async {
        await loadMoreData(collection: .users, rule: "Patient")
    }

    func loadDoctors() async {
        await resetAndLoadData(collection: .users, rule: "Doctor")
    }

    func loadMoreDoctors() async {
        await loadMoreData(collection: .users, rule: "Doctor")
    }
    
    // Function to reset and load data
    private func resetAndLoadData(collection: DataCollection, rule: String) async {
        resetData(collection: collection)
        await loadData(collection: collection, rule: rule)
    }
    
    // Function Load Data
    func loadData(collection: DataCollection, rule: String = "") async {
        guard !isLoading else { return }
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        do {
            switch collection {
            case .users:
                let (fetchedData, lastDocument) = try await loadUsersByRule(rule: rule, pageSize: pageSize) as ([UserModel], DocumentSnapshot?)
                if rule == "Patient" {
                    self.patients = fetchedData
                } else if rule == "Doctor" {
                    self.doctors = fetchedData
                }
                self.lastDocuments[collection] = lastDocument
                self.isLastPage = fetchedData.count < pageSize
                
            case .diseases:
                let (fetchedData, lastDocument) = try await fetchData(collection: collection, pageSize: pageSize) as ([DiseaseModel], DocumentSnapshot?)
                self.diseases = fetchedData
                self.lastDocuments[collection] = lastDocument
                self.isLastPage = fetchedData.count < pageSize
                
            case .symptoms:
                let (fetchedData, lastDocument) = try await fetchData(collection: collection, pageSize: pageSize) as ([SymptomModel], DocumentSnapshot?)
                self.symptoms = fetchedData
                self.lastDocuments[collection] = lastDocument
                self.isLastPage = fetchedData.count < pageSize
                
            case .advices:
                let (fetchedData, lastDocument) = try await fetchData(collection: collection, pageSize: pageSize) as ([AdviceModel], DocumentSnapshot?)
                self.advices = fetchedData
                self.lastDocuments[collection] = lastDocument
                self.isLastPage = fetchedData.count < pageSize
            }
        } catch {
            self.errorMessage = "Failed to load data: \(error.localizedDescription)"
        }
        
        await MainActor.run {
            self.isLoading = false
        }
    }
    
    func loadMoreData(collection: DataCollection, rule: String = "") async  {
        guard !isLoadingMore && !isLastPage else {
            return
        }
        await MainActor.run {
            self.isLoadingMore = true
            self.errorMessage = nil
        }
        
        do {
            switch collection {
            case .users:
                let (fetchedData, lastDocument) = try await loadUsersByRule(rule: rule, pageSize: pageSize, lastDocument: self.lastDocuments[collection] ?? nil) as ([UserModel], DocumentSnapshot?)
                if fetchedData.isEmpty {
                    self.isLastPage = true
                } else {
                    if rule == "Patient" {
                        self.patients.append(contentsOf: fetchedData.filter { newUser in !self.patients.contains(where: { $0.id == newUser.id }) })
                    } else if rule == "Doctor" {
                        self.doctors.append(contentsOf: fetchedData.filter { newUser in !self.doctors.contains(where: { $0.id == newUser.id }) })
                    }
                }
                self.lastDocuments[collection] = lastDocument
                self.isLastPage = fetchedData.count < pageSize
                
            case .diseases:
                let (fetchedData, lastDocument) = try await fetchData(collection: collection, pageSize: pageSize, lastDocument: self.lastDocuments[collection] ?? nil) as ([DiseaseModel], DocumentSnapshot?)
                if fetchedData.isEmpty {
                    self.isLastPage = true
                } else {
                    self.diseases.append(contentsOf: fetchedData.filter { newDisease in !self.diseases.contains(where: { $0.id == newDisease.id }) })
                }
                self.lastDocuments[collection] = lastDocument
                self.isLastPage = fetchedData.count < pageSize
                
            case .symptoms:
                let (fetchedData, lastDocument) = try await fetchData(collection: collection, pageSize: pageSize, lastDocument: self.lastDocuments[collection] ?? nil) as ([SymptomModel], DocumentSnapshot?)
                if fetchedData.isEmpty {
                    self.isLastPage = true
                } else {
                    self.symptoms.append(contentsOf: fetchedData.filter { newSymptom in !self.symptoms.contains(where: { $0.id == newSymptom.id }) })
                }
                self.lastDocuments[collection] = lastDocument
                self.isLastPage = fetchedData.count < pageSize
                
            case .advices:
                let (fetchedData, lastDocument) = try await fetchData(collection: collection, pageSize: pageSize, lastDocument: self.lastDocuments[collection] ?? nil) as ([AdviceModel], DocumentSnapshot?)
                if fetchedData.isEmpty {
                    self.isLastPage = true
                } else {
                    self.advices.append(contentsOf: fetchedData.filter { newAdvice in !self.advices.contains(where: { $0.id == newAdvice.id }) })
                }
                self.lastDocuments[collection] = lastDocument
                self.isLastPage = fetchedData.count < pageSize
            }
        } catch {
            self.errorMessage = "Failed to load data: \(error.localizedDescription)"
        }
        
        await MainActor.run {
            self.isLoadingMore = false
        }
    }
    
    // Get data by rule (Patient or Doctor)
    func loadUsersByRule(rule: String, pageSize: Int, lastDocument: DocumentSnapshot? = nil) async throws -> ([UserModel], DocumentSnapshot?) {
        let (users, lastDocument) = try await AuthServices.shared.fetchUsersByRule(rule: rule, pageSize: pageSize, lastDocument: lastDocument) as ([UserModel], DocumentSnapshot?)
        print("ISI USERS: \(users)")
        print("LAST DOCUMENT: \(String(describing: lastDocument))")
        return (users, lastDocument)
    }
    
    private func fetchData<T: Decodable>(collection: DataCollection, pageSize: Int, lastDocument: DocumentSnapshot? = nil) async throws -> ([T], DocumentSnapshot?) {
        var query: Query = db.collection(collection.rawValue).limit(to: pageSize)
        
        if let lastDocument = lastDocument {
            query = query.start(afterDocument: lastDocument)
        }
        
        let snapshot = try await query.getDocuments()
        let data = snapshot.documents.compactMap { try? $0.data(as: T.self)}
        let lastDocument = snapshot.documents.last
        
        return (data, lastDocument)
    }
    
    func resetData(collection: DataCollection) {
        switch collection {
        case .users:
            self.users = []
            self.patients = []
            self.doctors = []
        case .diseases:
            self.diseases = []
        case .symptoms:
            self.symptoms = []
        case .advices:
            self.advices = []
        }
        
        self.lastDocuments[collection] = nil
        self.isLoading = false
        self.isLoadingMore = false
        self.isLastPage = false
    }
}
