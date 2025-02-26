//
//  DetailsViewModel.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 23/02/2025.
//

import Foundation

@MainActor
final class DetailsViewModel: ObservableObject {
    @Published var professionalDetail: Details?
    @Published var isLoading = false
    @Published var hasError = false
    @Published var errorMessage = ""
    
    private let networkManager: NetworkManagerProtocol
    let professionalID: Int
    
    init(professionalID: Int, networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.professionalID = professionalID
        self.networkManager = networkManager
        fetchProfessionalDetail()
    }
    
    func fetchProfessionalDetail() {
        isLoading = true
        Task {
            do {
                let detail = try await networkManager.fetchProfessionalDetails(id: professionalID)
                professionalDetail = detail
            } catch {
                hasError = true
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
