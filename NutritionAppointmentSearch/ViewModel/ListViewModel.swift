//
//  ListViewModel.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 23/02/2025.
//

import Foundation
import SwiftUI

@MainActor
final class ListViewModel: ObservableObject {
    @Published var professionals: [Professional] = []
    @Published var sortBy: String = LocalizableKeys.ProfessionalList.bestMatch
    @Published var isLoading = false
    @Published var hasError = false
    @Published var errorMessage = ""
    
    private let networkManager: NetworkManagerProtocol
    
    private var offset = 0
    private let limit = 4
    private var totalCount = 0
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
        Task {
            await fetchProfessionals(reset: true)
        }
    }
    
    func fetchProfessionals(reset: Bool = false) async {
        if reset {
            offset = 0
            professionals.removeAll()
        } else if offset >= totalCount && totalCount != 0 {
            return
        }
        
        isLoading = true
        
        do {
            let response = try await networkManager.fetchProfessionals(limit: limit, offset: offset, sortBy: sortBy)
            totalCount = response.count
            professionals.append(contentsOf: response.professionals)
            offset += limit
        } catch {
            hasError = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func refresh() {
        Task {
            await fetchProfessionals(reset: true)
        }
    }
    
    func changeSort(to newSort: String) {
        sortBy = newSort
        Task {
            await fetchProfessionals(reset: true)
        }
    }
}
