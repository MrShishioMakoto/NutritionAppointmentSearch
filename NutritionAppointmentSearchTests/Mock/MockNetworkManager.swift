//
//  MockNetworkManager.swift
//  NutritionAppointmentSearchTests
//
//  Created by Gonçalo Almeida on 24/02/2025.
//

import Foundation
@testable import NutritionAppointmentSearch

enum MockError: Error {
    case unknown
}

final class MockNetworkManager: NetworkManagerProtocol {
    var fetchProfessionalsResult: Result<Professionals, NutritionError>?
    var fetchProfessionalDetailsResult: Result<Details, NutritionError>?
    
    func fetchProfessionals(limit: Int, offset: Int, sortBy: String) async throws -> Professionals {
        if let result = fetchProfessionalsResult {
            switch result {
            case .success(let response):
                return response
            case .failure(let error):
                throw error
            }
        }
        throw MockError.unknown
    }
    
    func fetchProfessionalDetails(id: Int) async throws -> Details {
        if let result = fetchProfessionalDetailsResult {
            switch result {
            case .success(let detail):
                return detail
            case .failure(let error):
                throw error
            }
        }
        throw MockError.unknown
    }
}
