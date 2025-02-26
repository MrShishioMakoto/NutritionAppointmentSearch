//
//  Endpoint.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 22/02/2025.
//

import Foundation

struct Endpoint {
    static let baseUrl = "https://nutrisearch.vercel.app/professionals"
    
    static func professionalsURL(limit: Int, offset: Int, sortBy: String) -> URL? {
        return URL(string: "\(baseUrl)/search?limit=\(limit)&offset=\(offset)&sort_by=\(sortBy)")
    }
    
    static func professionalDetailURL(id: Int) -> URL? {
        return URL(string: "\(baseUrl)/\(id)")
    }
}


