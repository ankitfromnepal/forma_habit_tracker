//
//  HabitIcons.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 28/03/2026.
//

import Foundation

struct Icon: Identifiable{
    let id = UUID()
    let icon: String
    
    
}
let icons = [
    Icon(icon: "🏃"),
    Icon(icon: "📚"),
    Icon(icon: "🖋️"),
    Icon(icon: "🎯"),
    Icon(icon: "🧘"),
    Icon(icon: "🍀"),
    Icon(icon: "💪"),
    Icon(icon: "💧"),
]
