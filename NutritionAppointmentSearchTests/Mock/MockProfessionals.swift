//
//  MockProfessionalResponse.swift
//  NutritionAppointmentSearchTests
//
//  Created by Gonçalo Almeida on 24/02/2025.
//

import Foundation
@testable import NutritionAppointmentSearch

enum MockResponse {
    static var professionalsSample: Professionals {
        let sampleProfessional = Professional(
            id: 1,
            name: "John Lawrence",
            rating: 4.5,
            ratingCount: 100,
            languages: ["EN"],
            expertise: ["Nutrition"],
            profilePictureURL: "https://example.com/johndoe.jpg"
        )
        
        return Professionals(
            count: 1,
            offset: 0,
            limit: 4,
            professionals: [sampleProfessional]
        )
    }
    
    static var detailsSample: Details {
        return Details(
            id: 1,
            name: "John Lawrence",
            rating: 4.5,
            ratingCount: 100,
            languages: ["EN"],
            expertise: ["Nutrition"],
            profilePictureURL: "https://example.com/johndoe.jpg",
            aboutMe: "About John Lawrence"
        )
    }
}
