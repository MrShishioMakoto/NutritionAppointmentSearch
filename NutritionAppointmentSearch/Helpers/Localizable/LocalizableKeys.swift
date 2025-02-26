//
//  LocalizableKeys.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 24/02/2025.
//

import Foundation

enum LocalizableKeys {
    enum Navigation {
        static let professionalsTitle = "nutrition.navigation.professionals.title".localizable()
        static let professionalDetailsTitle = "nutrition.navigation.profile.details.title".localizable()
    }
    
    enum Errors {
        static let invalidURL = "nutrition.errors.invalid.url".localizable()
        static let invalidResponse = "nutrition.errors.invalid.response".localizable()
        static let decodingError = "nutrition.errors.decoding.error".localizable()
        static let unknownError = "nutrition.errors.unknown".localizable()
    }
    
    enum ProfessionalList {
        static let sortBy = "nutrition.professional.list.sort.by".localizable()
        static let bestMatch = "nutrition.professional.list.sort.best_match".localizable()
        static let rating = "nutrition.professional.list.sort.rating".localizable()
        static let mostPopular = "nutrition.professional.list.sort.most_popular".localizable()
    }
    
    enum ProfessionalDetail {
        static let languagesLabel = "nutrition.professional.detail.languages.label".localizable()
        static let expertiseLabel = "nutrition.professional.detail.expertise.label".localizable()
        static let aboutMe = "nutrition.professional.detail.about_me".localizable()
        static let showMore = "nutrition.professional.detail.show_more".localizable()
        static let showLess = "nutrition.professional.detail.show_less".localizable()
    }
    
    enum Generic {
        static let error = "nutrition.error".localizable()
        static let ok = "nutrition.ok".localizable()
    }
}

