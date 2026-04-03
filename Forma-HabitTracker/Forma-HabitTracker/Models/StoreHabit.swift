//
//  StoreHabit.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 29/03/2026.
//

import Foundation

class HabitStorage {
    
    private let key = "habits"
    
    func save(_ habits: [Habit]) {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func load() -> [Habit] {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
            return decoded
        }
        return []
    }
}
