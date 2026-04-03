//
//  IconCard.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 28/03/2026.
//

internal import SwiftUI

struct IconCard: View {
    let icon: String
    let isselected: Bool
    var body: some View {
        VStack{
    Text(icon)
        .font(.custom("Didot", size: 50, relativeTo: .largeTitle))
        .bold()
    
}
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

.frame(width: 70, height: 70)
.background(RoundedRectangle(cornerRadius: 24).fill(Color(red: 0.157, green: 0.157, blue: 0.224)))
.overlay(RoundedRectangle(cornerRadius: 24)
.stroke(isselected ? Color(red: 126/255, green: 200/255, blue: 160/255)
        :Color(red: 90/255, green: 90/255, blue: 114/255)
            , lineWidth: 3))
    }
}

#Preview {
    IconCard(icon: "🎯", isselected: true)
}

