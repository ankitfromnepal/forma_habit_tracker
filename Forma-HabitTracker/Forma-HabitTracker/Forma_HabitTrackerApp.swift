//
//  Forma_HabitTrackerApp.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 23/03/2026.
//

internal import SwiftUI

@main
struct Forma_HabitTrackerApp: App {
    init() {
            NotificationManager.shared.requestPermission()
        }

    @StateObject var vm = HabitViewModel()
    @StateObject var userVM = UserViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .environmentObject(userVM)
        }
    }
}
