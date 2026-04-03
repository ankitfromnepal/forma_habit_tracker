//
//  StatsContainer.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 24/03/2026.
//

internal import SwiftUI

struct StatsContainer: View {
    let title: String
    let info: String
    let textcolor: Color
    var body: some View {
                    VStack{
                Text(title)
                    .font(.custom("Didot", size: 24, relativeTo: .largeTitle))
                    .foregroundStyle(textcolor)
                    .bold()
                Text(info)
                    .font(.custom("Didot", size: 18, relativeTo: .largeTitle))
                    .foregroundStyle(Color.gray)
                    .bold()
            }
        
        .frame(width: 120, height: 110)
        .background(RoundedRectangle(cornerRadius: 34).fill(Color(red: 0.118, green: 0.118, blue: 0.165)))
        .overlay(RoundedRectangle(cornerRadius: 34)
            .stroke(Color(red: 0.18, green: 0.18, blue: 0.23), lineWidth: 5))
//        .glassEffect(in: .rect(cornerRadius: 24.0))
//        .border(Color(red: 0.208, green: 0.208, blue: 0.255))
        
    }
}

#Preview {
    StatsContainer(title: "🔥14", info: "streak", textcolor: .orange)
}
