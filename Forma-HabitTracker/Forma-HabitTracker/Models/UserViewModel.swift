//
//  UserViewModel.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 03/04/2026.
//

import Foundation
internal import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    
    @Published var user: User
    
    private let storage = UserStorage()
    
    init() {
        self.user = storage.load()
    }
    
    func updateUsername(_ name: String) {
        let updatedUser = User(username: name, createdDate: user.createdDate)
        user = updatedUser
        storage.save(user)
    }
}
