//
//  Details.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 22/02/2025.
//

import Foundation

struct Details: Identifiable, Codable {
    let id: Int
    let name: String
    let rating: Double
    let ratingCount: Int
    let languages: [String]
    let expertise: [String]
    let profilePictureURL: String
    let aboutMe: String

    private enum CodingKeys: String, CodingKey {
        case id, name, rating, languages, expertise
        case ratingCount = "rating_count"
        case profilePictureURL = "profile_picture_url"
        case aboutMe = "about_me"
    }

    var formattedRating: String {
        return "\(rating) / 5 (\(ratingCount))"
    }
}


