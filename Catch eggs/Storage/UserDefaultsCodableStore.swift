//
//  UserDefaultsCodableStore.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 29.12.2025.
//

import Foundation

final class UserDefaultsCodableStore<T: Codable> {

    private let defaults: UserDefaults
    private let key: String
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    init(
        defaults: UserDefaults = .standard,
        key: String
    ) {
        self.defaults = defaults
        self.key = key
    }

    func load(default value: T) -> T {
        guard
            let data = defaults.data(forKey: key),
            let decoded = try? decoder.decode(T.self, from: data)
        else {
            return value
        }
        return decoded
    }

    func save(_ value: T) {
        guard let data = try? encoder.encode(value) else { return }
        defaults.set(data, forKey: key)
    }
}
