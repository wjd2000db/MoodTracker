//
//  AddDiaryView.swift
//  MoodTracker
//
//  Created by Yujin on 12/9/24.
//

import SwiftUI

struct AddDiaryView: View {
    @Environment(\.managedObjectContext)
    private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
        sortDescriptors:
            [NSSortDescriptor(keyPath:
                                \Diary.date, ascending: true)], animation: .default)
    private var diaries: FetchedResults<Diary>
    
    @State private var diaryText: String = ""
    @State private var selectedMoodIndex: Int? = nil
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        ZStack {
            Color("BGColor")
                .ignoresSafeArea()
            VStack {
                Text("How Was Your Day?")
                    .font(.title2)
                    .foregroundColor(Color("FontColor"))
                    .bold()
                RoundedRectangle(cornerRadius: 20)
                       .stroke(Color("LineColor"), lineWidth: 3)
                       .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                       .padding()
                       .frame(width: 400, height: 500)
                       .overlay(
                           VStack {
                               Text(Date.now, format: .dateTime.day().month().weekday())
                                   .foregroundColor(.secondary)
                               MoodSelect(selectedMoodIndex: $selectedMoodIndex)
                               
                               Divider()
                               
                               TextEditor(text: $diaryText)
                                   .frame(height: 250)
                                   .padding()
                         
                                }
                           .padding()
                       )
                Button(action: {
                       saveDiary()
                   }) {
                       Text("Save")
                           .font(.headline)
                           .foregroundColor(.white)
                           .padding()
                           .frame(maxWidth: 150)
                           .background(Color("ButtonColor"))
                           .cornerRadius(10)
                           .padding(.horizontal)
                   }
                
            }
        }
        .alert(isPresented: $showAlert) {
                   Alert(title: Text("Add Diary"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        

    }
    
    private func saveDiary() {
        guard let mood = selectedMoodIndex else {
            alertMessage = "Missed Today Mood.."
            showAlert = true
            return
        }
        
        let newDiary = Diary(context: viewContext)
        newDiary.mood = Int32(mood + 1)
        newDiary.date = Date()
        newDiary.content = diaryText
        
        do {
            try viewContext.save()
            alertMessage = "Diary saved successfully!"
            showAlert = true
        } catch {
            alertMessage = "Failed to save diary: \(error.localizedDescription)"
            showAlert = true
        }

    }
}

#Preview {
    AddDiaryView()
}
