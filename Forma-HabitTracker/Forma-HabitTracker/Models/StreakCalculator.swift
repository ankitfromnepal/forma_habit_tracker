//
//  StreakCalculator.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 02/04/2026.
//

import Foundation

struct StreakCalculator {
    
    
    static let calendar = Calendar.current
    
    
    static func startOfDay(_ date: Date) -> Date {
        calendar.startOfDay(for: date)
    }
    
    static func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }
    
    static func isYesterday(_ date: Date) -> Bool {
        calendar.isDateInYesterday(date)
    }
    
    static func todayScore(habits: [Habit]) -> (completed: Int, total: Int) {
        let completed = habits.filter { habit in
            habit.completedDates.contains { isToday($0) }
        }.count
        return (completed, habits.count)
    }
    static func todayProgress(habits: [Habit]) -> Double {
        guard !habits.isEmpty else { return 0.0 }
        let score = todayScore(habits: habits)
        return Double(score.completed) / Double(score.total)
    }
    
    
    static func currentStreak(_ habit: Habit) -> Int {
        let dates = habit.completedDates
            .map { startOfDay($0) }
            .sorted()
            .reversed()
        
        guard let mostRecent = dates.first else { return 0 }
        
        if !isToday(mostRecent) && !isYesterday(mostRecent) {
            return 0
        }
        
        var streak = 1
        var current = mostRecent
        
        for date in dates.dropFirst() {
            let expected = calendar.date(byAdding: .day, value: -1, to: current)!
            if startOfDay(date) == startOfDay(expected) {
                streak += 1
                current = date
            } else {
                break
            }
        }
        
        return streak
    }
    
    
    static func currentStreak(habits: [Habit]) -> Int {
        guard !habits.isEmpty else { return 0 }
        
        var streak = 0
        var checkDate = startOfDay(Date())
        
        for _ in 0..<365 {
            let allCompleted = habits.allSatisfy { habit in
                habit.completedDates.contains { startOfDay($0) == checkDate }
            }
            
            if allCompleted {
                streak += 1
                checkDate = calendar.date(byAdding: .day, value: -1, to: checkDate)!
            } else {
                break
            }
        }
        
        return streak
    }
    
    static func thisWeekPercentage(habits: [Habit]) -> Int {
        guard !habits.isEmpty else { return 0 }
        
        let today = startOfDay(Date())
        var totalSlots = 0
        var completedSlots = 0
        
        for dayOffset in 0..<7 {
            guard let day = calendar.date(byAdding: .day, value: -dayOffset, to: today) else { continue }
            for habit in habits {
                totalSlots += 1
                if habit.completedDates.contains(where: { startOfDay($0) == day }) {
                    completedSlots += 1
                }
            }
        }
        
        guard totalSlots > 0 else { return 0 }
        return Int((Double(completedSlots) / Double(totalSlots)) * 100)
    }
    
    
    static func remainingToday(habits: [Habit]) -> Int {
        habits.filter { habit in
            !habit.completedDates.contains { isToday($0) }
        }.count
    }
}
