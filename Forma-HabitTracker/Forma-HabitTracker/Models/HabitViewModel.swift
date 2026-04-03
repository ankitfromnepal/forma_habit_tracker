//
//  HabitViewModel.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 29/03/2026.
//

import Foundation
internal import SwiftUI
import Combine

class HabitViewModel: ObservableObject {

    @Published var habits: [Habit] = []
    private let storage = HabitStorage()

    init() {
        loadHabits()
    }

    func loadHabits() {
        habits = storage.load()
    }

    func addHabit(title: String, habitIcon: String, time: Date, colorIndex: Int) {
        let newHabit = Habit(title: title, habitIcon: habitIcon, time: time, colorIndex: colorIndex)
        habits.append(newHabit)
        storage.save(habits)
    }

    func editHabit(id: UUID, title: String, habitIcon: String, time: Date, colorIndex: Int) {
        if let index = habits.firstIndex(where: { $0.id == id }) {
            habits[index].title = title
            habits[index].habitIcon = habitIcon
            habits[index].time = time
            habits[index].colorIndex = colorIndex
            storage.save(habits)
        }
    }

    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        storage.save(habits)
    }

    func removeHabit(by id: UUID) {
        habits.removeAll { $0.id == id }
        storage.save(habits)
    }

    func toggleCompletion(for habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        let today = Calendar.current.startOfDay(for: Date())

        if habits[index].completedDates.contains(where: { Calendar.current.startOfDay(for: $0) == today }) {
            habits[index].completedDates.removeAll {
                Calendar.current.startOfDay(for: $0) == today
            }
        } else {
            habits[index].completedDates.append(Date())
        }

        storage.save(habits)
    }

    func markCompleted(id: UUID) {
        guard let index = habits.firstIndex(where: { $0.id == id }) else { return }
        let today = Calendar.current.startOfDay(for: Date())
        let alreadyDone = habits[index].completedDates.contains {
            Calendar.current.startOfDay(for: $0) == today
        }
        if !alreadyDone {
            habits[index].completedDates.append(Date())
            storage.save(habits)
        }
    }

    func unmarkCompleted(id: UUID) {
        guard let index = habits.firstIndex(where: { $0.id == id }) else { return }
        let today = Calendar.current.startOfDay(for: Date())
        habits[index].completedDates.removeAll {
            Calendar.current.startOfDay(for: $0) == today
        }
        storage.save(habits)
    }
}
