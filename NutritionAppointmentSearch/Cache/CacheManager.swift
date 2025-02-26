//
//  CacheManager.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 23/02/2025.
//

import Foundation

final class CacheManager {
    static let shared = CacheManager()
    
    private let cache = NSCache<NSString, CacheItem>()
    
    private init() {}
    
    func cache(data: Data, forKey key: String, lifetime: TimeInterval = 120) {
        let item = CacheItem(data: data, expirationDate: Date().addingTimeInterval(lifetime))
        cache.setObject(item, forKey: key as NSString)
    }
    
    func cachedData(forKey key: String) -> Data? {
        guard let item = cache.object(forKey: key as NSString) else { return nil }
        if Date() < item.expirationDate {
            return item.data
        } else {
            cache.removeObject(forKey: key as NSString)
            return nil
        }
    }
}

final class CacheItem: NSObject {
    let data: Data
    let expirationDate: Date
    
    init(data: Data, expirationDate: Date) {
        self.data = data
        self.expirationDate = expirationDate
    }
}

enum CacheKey {
    static func professionalsCacheKey(limit: Int, offset: Int, sortBy: String) -> String {
        return "professionals_\(limit)_\(offset)_\(sortBy)"
    }
    
    static func professionalDetail(id: Int) -> String {
        "professionalDetail_\(id)"
    }
}
