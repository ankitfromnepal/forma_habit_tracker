//
//  DailyHabitCard.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 24/03/2026.
//

internal import SwiftUI


struct DailyHabitCard: View {
    let icon: String
    let habittitle: String
    let habittime: String
    let boxcolor: Color
    let habitfrequency: String
    let isChecked: Bool
    var onToggle: () -> Void

    var body: some View {
        HStack {
            HStack {
                Text(icon)
                    .font(.system(size: 50))
            }
            .frame(width: 70, height: 70)
            .background(boxcolor)
            .cornerRadius(24)
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 10))

            VStack {
                HStack {
                    Text(habittitle)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(isChecked ? Color(red: 0.353, green: 0.353, blue: 0.447) : Color.white)
                        .strikethrough(isChecked)
                    Spacer()
                }
                HStack {
                    Text(habittime)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color(red: 0.34, green: 0.37, blue: 0.52))
                    Text("-")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color(red: 0.34, green: 0.37, blue: 0.52))
                    Text(habitfrequency)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color(red: 0.34, green: 0.37, blue: 0.52))
                    Spacer()
                }
            }

            Spacer()

            Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(isChecked
                    ? Color(red: 0.49, green: 0.78, blue: 0.63)
                    : Color(red: 0.35, green: 0.35, blue: 0.45))
                .font(.system(size: 40))
                .padding()
                .onTapGesture {
                    onToggle() 
                }
        }
        .frame(width: .infinity, alignment: .leading)
        .background(Color(red: 0.15, green: 0.15, blue: 0.20))
        .cornerRadius(35)
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
    }
}

#Preview {
    DailyHabitCard(
        icon: "📚",
        habittitle: "Read 20 pages",
        habittime: "6:30 AM",
        boxcolor: Color.blue,
        habitfrequency: "🔥 7",
        isChecked: false,
        onToggle: {}
    )
}

