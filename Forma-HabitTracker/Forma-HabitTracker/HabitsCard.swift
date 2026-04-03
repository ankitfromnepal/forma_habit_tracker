//
//  HabitsCard.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 27/03/2026.
//

internal import SwiftUI

struct HabitsCard: View {
    @EnvironmentObject var vm: HabitViewModel

    let habit: Habit
    
    @State var isChecked: Bool

    var onEdit: ()-> Void
    
    var body: some View {
        HStack{
            HStack{
                Text(habit.habitIcon)
                    .font(.system(size: 50))
                    
            }.frame(width: 70, height: 70)
            
                .background(habitColors[habit.colorIndex])
            .cornerRadius(24)
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 10))
            
            VStack{
                HStack{
                    Text(habit.title)
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(isChecked == false ? Color.white
                                         : Color(red: 0.353, green: 0.353, blue: 0.447))
                        .strikethrough(isChecked)
                    Spacer()

                }.frame(alignment: .leading)
                HStack{
                    Text(habit.time, style: .time)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color(red: 0.34, green: 0.37, blue: 0.52))
                        .frame(alignment: .leading)
                    Text("-")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color(red: 0.34, green: 0.37, blue: 0.52))
                        .frame(alignment: .center)
                                            
                    Text("daily")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color(red: 0.34, green: 0.37, blue: 0.52))
                        .frame(alignment: .leading)
                                            Spacer()
                }
                
            }
            .frame(alignment: .center)
            Spacer()
            Text("\(Image(systemName: "pencil"))")
                                .font(.system(size: 22))
                .foregroundStyle(Color.green)
                .onTapGesture {
                    onEdit()
                }
            HStack{
                Text("\(Image(systemName: "trash"))")
                    .padding(.trailing)
                    .font(.system(size: 22))
                    .foregroundStyle(Color.red)
                
                    
            }.padding()
                .onTapGesture {
                    vm.removeHabit(by: habit.id)
                }
            
                

        
                    }
        
        .frame(width: .infinity, alignment: .leading)
        .background(Color(red: 0.15, green: 0.15, blue: 0.20))
        .cornerRadius(35)
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
    }
}

#Preview {
    HabitsCard(
        habit: Habit(
            title: "Morning Run",
            habitIcon: "🏃", time: Date(),
            colorIndex: 0,
        ), isChecked: false, onEdit: {}
    )
}
