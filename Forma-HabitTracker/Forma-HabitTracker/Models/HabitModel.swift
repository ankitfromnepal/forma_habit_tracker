//
//  HabitModel.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 29/03/2026.
//

internal import SwiftUI
import Foundation

struct Habit: Identifiable, Codable{
    var id = UUID()
    var title: String
    var habitIcon: String
    var time: Date
    var colorIndex: Int
    var completedDates: [Date] = []  
}


