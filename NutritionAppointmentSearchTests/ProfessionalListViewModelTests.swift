//
//  ProfessionalListViewModelTests.swift
//  NutritionAppointmentSearchTests
//
//  Created by Gonçalo Almeida on 24/02/2025.
//

import XCTest
@testable import NutritionAppointmentSearch

final class ProfessionalListViewModelTests: XCTestCase {

    func testFetchProfessionalsSuccess() async throws {
        let response = MockResponse.professionalsSample
        let mockManager = MockNetworkManager()
        mockManager.fetchProfessionalsResult = .success(response)
        
        let viewModel = await ListViewModel(networkManager: mockManager)
        
        try await Task.sleep(nanoseconds: 200_000_000)
        
        await MainActor.run {
            XCTAssertEqual(viewModel.professionals.count, 1)
            XCTAssertEqual(viewModel.professionals.first?.name, "John Lawrence")
            XCTAssertEqual(viewModel.professionals.first?.languages, ["EN"])
        }
    }
    
    func testFetchProfessionalsFailure() async {
        let mockManager = MockNetworkManager()
        mockManager.fetchProfessionalsResult = .failure(.invalidURL)
        
        let viewModel = await ListViewModel(networkManager: mockManager)
        await viewModel.fetchProfessionals(reset: true)
        
        await MainActor.run {
            XCTAssertTrue(viewModel.hasError)
            XCTAssertTrue(viewModel.errorMessage.contains("NutritionAppointmentSearch.NutritionError"))
        }
    }
}

