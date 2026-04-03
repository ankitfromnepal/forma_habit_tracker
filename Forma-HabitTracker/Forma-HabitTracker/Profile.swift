//
//  Profile.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 26/03/2026.
//

internal import SwiftUI

struct Profile: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var showEditAlert = false
    @State private var name: String = ""
    @State private var newUsername = ""

    var body: some View {
        VStack{
            HStack{
                ZStack {
                    Circle()
                        .fill(Color(red: 0.463, green: 0.773, blue: 0.722))
                        .frame(width: 150, height: 150)
                    
                    Text(String(userVM.user.username.prefix(1)).uppercased())
                        .font(.custom("Didot", size: 60, relativeTo: .largeTitle))
                        
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
            }.frame(maxWidth: .infinity)
            HStack{
                Text("\(userVM.user.username)")
                    .font(.custom("Didot", size: 30, relativeTo: .largeTitle))
                    .foregroundColor(.white)
                Text("\(Image(systemName: "pencil"))")
                                    .font(.system(size: 30))
                    .foregroundStyle(Color.blue)
                    .onTapGesture {
                        newUsername = userVM.user.username // preload current name
                            showEditAlert = true

                    }

            }

            Spacer()
        }
        .background(LinearGradient(
            colors: [Color(red: 0.07, green: 0.07, blue: 0.12), Color(red: 0.17, green: 0.16, blue: 0.25), Color(red: 0.14, green: 0.18, blue: 0.20)], startPoint: .topLeading, endPoint: .bottomTrailing
        ))
        .frame(maxWidth: .infinity, maxHeight: .infinity, )
        .onAppear {
            name = userVM.user.username
        }
        .alert("Edit Username", isPresented: $showEditAlert) {
            
            TextField("Enter new username", text: $newUsername)
            
            Button("Cancel", role: .cancel) {}
            
            Button("Save") {
                if !newUsername.trimmingCharacters(in: .whitespaces).isEmpty {
                    userVM.updateUsername(newUsername)
                }
            }
        }

    }
}

#Preview {
    Profile()
        .environmentObject(UserViewModel())
}
