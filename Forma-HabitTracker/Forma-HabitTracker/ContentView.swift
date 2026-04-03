//
//  ContentView.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 23/03/2026.
//

internal import SwiftUI

struct GaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.green
    var strokeWidth = 25.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
                        Circle()
                .stroke(Color(red: 0.15, green: 0.15, blue: 0.20), lineWidth: strokeWidth)
            
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
    }
}

struct ContentView: View {

    var body: some View {
        
        TabView{
            Tab("Home", systemImage: "house.fill"){
                NavigationStack{
                    HomeScreen()
                }
                
            }
            Tab("My Habits", systemImage: "plus.circle.fill"){
                NavigationStack{
                    AddHabit()
                }
                
            }
            Tab("Profile", systemImage: "person.crop.circle.fill"){
                NavigationStack{
Profile()                }
            }
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(HabitViewModel())
        
}
