//
//  NutritionError.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 22/02/2025.
//

import Foundation

enum NutritionError: String, Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case unknownError

    var localizedDescription: String {
        switch self {
        case .invalidURL: return LocalizableKeys.Errors.invalidURL
        case .invalidResponse: return LocalizableKeys.Errors.invalidResponse
        case .decodingError: return LocalizableKeys.Errors.decodingError
        case .unknownError: return  LocalizableKeys.Errors.unknownError
        }
    }
}

