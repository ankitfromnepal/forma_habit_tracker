//
//  HomeScreen.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 26/03/2026.
//

internal import SwiftUI

struct HomeScreen: View {
    
    
    @EnvironmentObject var vm: HabitViewModel
    @EnvironmentObject var userVM: UserViewModel
            var body: some View {
                
        ScrollView{
            let score = StreakCalculator.todayScore(habits: vm.habits)
                    let streak = StreakCalculator.currentStreak(habits: vm.habits)
                    let progress = StreakCalculator.todayProgress(habits: vm.habits)
                    let weekPct = StreakCalculator.thisWeekPercentage(habits: vm.habits)
                    let remaining = StreakCalculator.remainingToday(habits: vm.habits)
            
            // greeting text
            HStack{
                Text("Welcome, \(userVM.user.username)")
                    .font(.custom("Didot", size: 14, relativeTo: .largeTitle))
                    .foregroundStyle(Color.gray)
                    .bold()
                Spacer()
                
            
               


                
            }.frame(maxWidth: .infinity,alignment: .leading)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
            
            // your day section
            
                            HStack{
                    Text("Your")
                       
                                    .font(.custom("Didot", size: 42, relativeTo: .largeTitle))
                                    .foregroundStyle(Color.white)
                                    .bold()
                                    
                        Text("day")
                        .foregroundStyle(Color(red: 0.494, green: 0.784, blue: 0.627))
                        .font(.custom("Didot", size: 42, relativeTo: .largeTitle))
                        .bold()
                                
                                
                }.padding(EdgeInsets(top: -5, leading: 10, bottom: 5, trailing: 0))
                            .frame(maxWidth: .infinity,alignment: .leading)
                

            HStack{
                Text("starts now.")
                    .font(.custom("Didot", size: 42, relativeTo: .largeTitle))
                    .foregroundStyle(Color.white)
                    .bold()
            }.padding(EdgeInsets(top: -15, leading: 10, bottom: 5, trailing: 0))
                .frame(maxWidth: .infinity,alignment: .leading)
            
            // circular progress view
            ZStack{
                VStack{
                    ProgressView(value: progress, total: 1.0)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 150, height: 150)
                                .contentShape(Rectangle())

                    HStack{
                        Text("\(score.completed)/\(score.total)")
                        .font(.custom("Didot", size: 28, relativeTo: .largeTitle))
                        .foregroundStyle(Color(red: 0.494, green: 0.784, blue: 0.627))
                        .bold()                    }.padding(EdgeInsets(top: -111, leading: 0, bottom: 0, trailing: 0))
                    
                    HStack{
                        Text("today")
                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                        
                        .font(.custom("Didot", size: 16, relativeTo: .largeTitle))
                        .foregroundStyle(Color.gray)

                        .bold()                    }.padding(EdgeInsets(top: -110, leading: 0, bottom: 0, trailing: 0))
                    
                }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    
            }
            
            
            // container card hstack
            
            HStack{
                StatsContainer(title: "🔥\(streak)", info: "streak", textcolor: .yellow)
                    
                StatsContainer(title: "\(weekPct)%", info: "this week", textcolor: .green)
                    
                StatsContainer(title: "\(remaining)", info: "remaining", textcolor: .orange)
            }
            
            
            
            LazyVStack(spacing: 12) {
                ForEach(vm.habits) { habit in
                    DailyHabitCard(
                        icon: habit.habitIcon,
                        habittitle: habit.title,
                        habittime: habit.time.formatted(date: .omitted, time: .shortened),
                        boxcolor: habitColors[habit.colorIndex],
                        habitfrequency: "🔥 \(StreakCalculator.currentStreak(habit))",
                        isChecked: habit.completedDates.contains { Calendar.current.isDateInToday($0) },
                        onToggle: { vm.toggleCompletion(for: habit) }  // ← add this
                    )
                }
                        }
                        .padding(.top, 8)
                            
        }
        .background(LinearGradient(
            colors: [Color(red: 0.07, green: 0.07, blue: 0.12), Color(red: 0.17, green: 0.16, blue: 0.25), Color(red: 0.14, green: 0.18, blue: 0.20)], startPoint: .topLeading, endPoint: .bottomTrailing
        ))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

#Preview {
    HomeScreen()
        .environmentObject(HabitViewModel())
        .environmentObject(UserViewModel())

}
