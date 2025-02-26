//
//  CacheManagerTests.swift
//  NutritionAppointmentSearchTests
//
//  Created by Gonçalo Almeida on 24/02/2025.
//

import XCTest
@testable import NutritionAppointmentSearch

final class CacheManagerTests: XCTestCase {
    
    func testCacheExpiration() {
        let cacheKey = "testKey"
        let testData = "Test".data(using: .utf8)!
        
        CacheManager.shared.cache(data: testData, forKey: cacheKey, lifetime: 1)
        let cachedData = CacheManager.shared.cachedData(forKey: cacheKey)
        XCTAssertNotNil(cachedData)
        
        let expectation = expectation(description: "Wait for cache to expire")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        
        let expiredData = CacheManager.shared.cachedData(forKey: cacheKey)
        XCTAssertNil(expiredData)
    }
}

