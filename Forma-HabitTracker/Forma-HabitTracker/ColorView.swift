//
//  ColorView.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 28/03/2026.
//

internal import SwiftUI

struct ColorView: View {
    var accentColor: Color
    var isselected: Bool
    var body: some View {
        ZStack{
            Circle()
                .stroke(isselected ? accentColor : Color.clear, lineWidth: 6)
                                .frame(width: 50, height: 50)
            Circle()
                .fill(accentColor)
                                .frame(width: 40, height: 40)
        }
            }
}

#Preview {
    ColorView(accentColor: Color(red: 0.659, green: 0.616, blue: 0.910), isselected: true)
        .environmentObject(HabitViewModel())
}
