//
//  AddHabit.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 26/03/2026.
//

internal import SwiftUI

struct AddHabit: View {
    
    @EnvironmentObject var vm: HabitViewModel
    @State var habitToEdit: Habit? = nil
    @State var showAddSheet: Bool = false
    var body: some View {
        
        ZStack{
            LinearGradient(
                colors: [Color(red: 0.07, green: 0.07, blue: 0.12), Color(red: 0.17, green: 0.16, blue: 0.25), Color(red: 0.14, green: 0.18, blue: 0.20)], startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack{
                // your habit text
                HStack{
        Text("Your")
            /*font(.system(.largeTitle, weight: .heavy))*/
                        .font(.custom("Didot", size: 42, relativeTo: .largeTitle))
                        .foregroundStyle(Color.white)
                        .bold()
                        
            Text("habits")
            .foregroundStyle(Color(red: 0.494, green: 0.784, blue: 0.627))
            .font(.custom("Didot", size: 42, relativeTo: .largeTitle))
            .bold()
                    
                    
    }.padding(EdgeInsets(top: 0, leading: 00, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity,alignment: .center)
                
                
                // add habit button
                
                HStack{
                    Button(action:{
                        habitToEdit = nil
                        showAddSheet = true
                    }){
                        Label("", systemImage: "plus.circle.fill")
                    }.foregroundStyle(Color.white)
                        .font(.system(size: 35))
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                
                ScrollView{

                    LazyVStack(spacing: 12) {
                        ForEach(vm.habits) { habit in
                            HabitsCard(habit: habit, isChecked: false, onEdit: {
                                habitToEdit = habit
                                
})
                                .environmentObject(vm)
                        }
                    }
                }
                
            }
            

            }
        .sheet(item: $habitToEdit) { habit in
            BottomAddSheet(vm: vm, habitToEdit: habit)
                .presentationDetents([.large])
                .presentationDragIndicator(.automatic)
        }
        .sheet(isPresented: $showAddSheet) {
            BottomAddSheet(vm: vm, habitToEdit: nil)
                .presentationDetents([.large])
                .presentationDragIndicator(.automatic)
        }

    }}

#Preview {
    AddHabit()
}
