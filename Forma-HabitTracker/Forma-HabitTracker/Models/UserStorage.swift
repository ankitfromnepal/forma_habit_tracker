//
//  UserStorage.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 03/04/2026.
//

import Foundation

class UserStorage {
    private let key = "user_profile"
    
    func save(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func load() -> User {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(User.self, from: data) {
            return decoded
        }
        return User()  // default
    }
}
