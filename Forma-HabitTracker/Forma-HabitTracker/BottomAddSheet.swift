//
//  BottomAddSheet.swift
//  Forma-HabitTracker
//
//  Created by Ankit Kandel on 27/03/2026.
//

internal import SwiftUI

struct BottomAddSheet: View {
    @FocusState private var titleFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    @ObservedObject var vm: HabitViewModel
    @State private var selectedColor: Color? = nil
    @State var dailyRemainder = false
    @State var reminderDate: Date = Date()
    @State var showingPicker: Bool = false
    
    @State private var selectedColorIndex: Int = 0
    @State private var selectedIcon: String = ""
    @State private var selectedIconID: UUID?
    @State var habitText: String = ""
    var habitToEdit: Habit? = nil
    var isEditing: Bool { habitToEdit != nil }
    var body: some View {
        ZStack{
            LinearGradient(
                colors: [Color(red: 0.07, green: 0.07, blue: 0.12), Color(red: 0.17, green: 0.16, blue: 0.25), Color(red: 0.14, green: 0.18, blue: 0.20)], startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack{
                
                HStack{
                    Button("Cancel"){
                        // action cancel
                        dismiss()
                    }.foregroundStyle(Color(red: 90/255, green: 90/255, blue: 114/255))
                        .font(.system(size: 18))
                        .padding(.leading)
                        .bold()
                    Spacer()
                    Text(isEditing ? "Edit Habit" : "New Habit")
                        .font(.custom("Didot", size: 42, relativeTo: .largeTitle))
                        .foregroundStyle(Color.white)
                        .bold()
                    Spacer()
                    Button("Save"){
                        // action done
                        if !habitText.trimmingCharacters(in: .whitespaces).isEmpty && !selectedIcon.isEmpty {
                            // Add the habit
                            if isEditing, let habit = habitToEdit {
                                                                vm.editHabit(
                                    id: habit.id,
                                    title: habitText,
                                    habitIcon: selectedIcon,
                                    time: reminderDate,
                                    colorIndex: selectedColorIndex
                                )
                            } else {
                                vm.addHabit(
                                    title: habitText,
                                    habitIcon: selectedIcon,
                                    time: reminderDate,
                                    colorIndex: selectedColorIndex
                                )
                            }
                            dismiss()
                        } else {
                           
                            showAlert = true
                        }
                        
                        
                    }.foregroundStyle(Color(red: 126/255, green: 200/255, blue: 160/255))
                        .font(.system(size: 20))
                        .padding(.trailing)
                        .bold()
                        .alert("Please add habit title and select habit icon", isPresented: $showAlert) {
                            Button("OK", role: .cancel) { }
                        }
                    
                    
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                
                ScrollView{
                    HStack{
                        Text("Choose Icon")
                            .foregroundStyle(Color(red: 90/255, green: 90/255, blue: 114/255))
                            .font(.system(size: 22))
                            .padding(.leading)
                            .padding(.top)
                            .bold()
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(icons){ icon in IconCard(icon: icon.icon, isselected: selectedIconID == icon.id).onTapGesture {
                                selectedIconID = icon.id
                                selectedIcon = icon.icon
                            }
                            }                    }
                        .padding()
                    }
                    HStack{
                        Text("Habit Name")
                            .foregroundStyle(Color(red: 90/255, green: 90/255, blue: 114/255))
                            .font(.system(size: 22))
                            .padding(.leading)
                            .padding(.top)
                            .bold()
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        TextField("", text: $habitText, prompt: Text("Enter habit name").foregroundStyle(Color.white))
                            .keyboardType(.default)
                            .foregroundStyle(Color.white)
                            .font(.system(size: 22))
                            .focused($titleFieldFocused)
                            .padding()
                            .padding(.leading)
                            .padding(.trailing)
                            .background(RoundedRectangle(cornerRadius: 24).fill(Color(red: 0.157, green: 0.157, blue: 0.224)))
                            .overlay(RoundedRectangle(cornerRadius: 24)
                                .stroke(Color(red: 90/255, green: 90/255, blue: 114/255)
                                        , lineWidth: 1.5))
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    HStack{
                        Text("Color")
                            .foregroundStyle(Color(red: 90/255, green: 90/255, blue: 114/255))
                            .font(.system(size: 22))
                            .padding(.leading)
                            .padding(.top)
                            .bold()
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        Text("Pick\nAccent")
                            .foregroundStyle(Color(red: 90/255, green: 90/255, blue: 114/255))
                            .font(.system(size: 22))
                            .padding(.leading)
                            .padding(.top)
                            .bold()
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 1){
                               
                                
                                ForEach(habitColors.indices, id: \.self) { index in
                                    let color = habitColors[index]
                                    
                                    ColorView(
                                        accentColor: color,
                                        isselected: selectedColorIndex == index
                                    )
                                    .onTapGesture {
                                        selectedColorIndex = index
                                    }
                                }
                                
                            }
                            .padding()
                        }
                        
                    }
                    
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 24).fill(Color(red: 0.157, green: 0.157, blue: 0.224)))
                    .overlay(RoundedRectangle(cornerRadius: 24)
                        .stroke(Color(red: 90/255, green: 90/255, blue: 114/255)
                                , lineWidth: 3))
                    .padding(.leading)
                    .padding(.trailing)
                    HStack{
                        Text("Daliy reminder at:")
                            .foregroundStyle(Color(red: 90/255, green: 90/255, blue: 114/255))
                            .font(.system(size: 22))
                            .padding(.leading)
                            .padding(.top)
                            .bold()
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        
                        DatePicker("Pick Time", selection: $reminderDate, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .environment(\.locale, Locale(identifier: "en_US_POSIX"))
                            .colorScheme(.dark)
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 24).fill(Color(red: 0.157, green: 0.157, blue: 0.224)))
                    .overlay(RoundedRectangle(cornerRadius: 24)
                        .stroke(Color(red: 90/255, green: 90/255, blue: 114/255)
                                , lineWidth: 3))
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)
                    
                    
                    
                    Spacer()
                    
                    
                }
                
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
        }
        .onTapGesture {
            titleFieldFocused = false
        }
        .onAppear{
            if let habit = habitToEdit {
                            habitText = habit.title
                            selectedIcon = habit.habitIcon
                            selectedColorIndex = habit.colorIndex
                            reminderDate = habit.time
                                                        selectedIconID = icons.first(where: { $0.icon == habit.habitIcon })?.id
                        }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                titleFieldFocused = true        }
            
        }
    }
}
#Preview {
    BottomAddSheet(vm: HabitViewModel())
}


