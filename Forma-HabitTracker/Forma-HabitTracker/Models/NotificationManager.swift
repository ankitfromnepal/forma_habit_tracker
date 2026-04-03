//
//  NotificationManager.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 02/04/2026.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            }
        }
    }
    
    func scheduleNotification(for habit: Habit) {
        let content = UNMutableNotificationContent()
        content.title = "Time for your habit! \(habit.habitIcon)"
        content.body = "Don't forget: \(habit.title)"
        content.sound = .default
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: habit.time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: habit.id.uuidString,            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(for habit: Habit) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [habit.id.uuidString]
        )
    }
    
    func rescheduleAll(habits: [Habit]) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        habits.forEach { scheduleNotification(for: $0) }
    }
}
