//
//  NetworkManager.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 22/02/2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchProfessionals(limit: Int, offset: Int, sortBy: String) async throws -> Professionals
    func fetchProfessionalDetails(id: Int) async throws -> Details
}

final class NetworkManager: NetworkManagerProtocol {
    
    func fetchProfessionals(limit: Int, offset: Int, sortBy: String) async throws -> Professionals {
        let cacheKey = CacheKey.professionalsCacheKey(limit: limit, offset: offset, sortBy: sortBy)
        if let cached = CacheManager.shared.cachedData(forKey: cacheKey) {
            return try JSONDecoder().decode(Professionals.self, from: cached)
        }
        guard let url = Endpoint.professionalsURL(limit: limit, offset: offset, sortBy: sortBy) else {
            throw NutritionError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NutritionError.invalidResponse
        }
        CacheManager.shared.cache(data: data, forKey: cacheKey)
        do {
            return try JSONDecoder().decode(Professionals.self, from: data)
        } catch {
            throw NutritionError.decodingError
        }
    }
    
    func fetchProfessionalDetails(id: Int) async throws -> Details {
        let cacheKey = CacheKey.professionalDetail(id: id)
        if let cached = CacheManager.shared.cachedData(forKey: cacheKey) {
            return try JSONDecoder().decode(Details.self, from: cached)
        }
        guard let url = Endpoint.professionalDetailURL(id: id) else {
            throw NutritionError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NutritionError.invalidResponse
        }
        CacheManager.shared.cache(data: data, forKey: cacheKey)
        do {
            return try JSONDecoder().decode(Details.self, from: data)
        } catch {
            throw NutritionError.decodingError
        }
    }
}
