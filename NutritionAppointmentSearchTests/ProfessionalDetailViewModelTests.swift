//
//  ProfessionalDetailViewModelTests.swift
//  NutritionAppointmentSearchTests
//
//  Created by Gonçalo Almeida on 24/02/2025.
//

import XCTest
@testable import NutritionAppointmentSearch

final class ProfessionalDetailViewModelTests: XCTestCase {

    func testFetchProfessionalDetailSuccess() async throws {
        let response = MockResponse.detailsSample
        
        let mockManager = MockNetworkManager()
        mockManager.fetchProfessionalDetailsResult = .success(response)
        
        let viewModel = await DetailsViewModel(professionalID: 1, networkManager: mockManager)
        
        try await Task.sleep(nanoseconds: 200_000_000)
        
        await MainActor.run {
            XCTAssertNotNil(viewModel.professionalDetail)
            XCTAssertEqual(viewModel.professionalDetail?.name, "John Lawrence")
            XCTAssertNotNil(viewModel.professionalDetail?.aboutMe)
        }
    }
    
    func testFetchProfessionalDetailFailure() async {
        let mockManager = MockNetworkManager()
        mockManager.fetchProfessionalDetailsResult = .failure(.invalidResponse)
        
        let viewModel = await DetailsViewModel(professionalID: 1, networkManager: mockManager)
        
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        await MainActor.run {
            XCTAssertTrue(viewModel.hasError)
            XCTAssertTrue(viewModel.errorMessage.contains("NutritionAppointmentSearch.NutritionError"))
        }
    }
}

