import SwiftUI

struct DiaryDetail: View {
    var diary: Diary
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var isEditing: Bool = false
    @State private var editedContent: String
    
    init(diary: Diary) {
        self.diary = diary
        _editedContent = State(initialValue: diary.content ?? "") 
    }
    
    var body: some View {
        ZStack {
            Color("BGColor")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text(diary.date ?? Date(), style: .date)
                    .font(.title3)
                    .bold()
                
                Text(formatTime(from: diary.date ?? Date()))
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                Image(moodImageName(for: diary.mood))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(10)
                    .padding()
                

                ScrollView {
                    if isEditing {
                        TextEditor(text: $editedContent)
                            .frame(height: 250)
                            .padding()
                            .background(
                                    RoundedRectangle(cornerRadius: 10)  // 둥근 테두리 설정
                                        .stroke(Color("ButtonColor"), lineWidth: 2) // 테두리 색깔을 "ButtonColor"로 설정
                                )
                            .padding()
                    }else {
                        Text(diary.content ?? "")
                            .font(.body)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    }
                    
                }
             
                HStack {
                    if isEditing {
                        Spacer()
                        
                        Button("Save") {
                            saveChanges()
                        }
                        .padding()
                        .background(Color("ButtonColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        Spacer()
                    } else {
                    Button("Edit") {
                           isEditing.toggle()
                       }
                       .padding()
                       .background(Color("ButtonColor"))
                       .foregroundColor(.white)
                       .cornerRadius(10)
                       
                      Spacer()
                           
                       Button("Delete") {
                           deleteDiary()
                       }
                       .padding()
                       .background(Color("ButtonColor"))
                       .foregroundColor(.white)
                       .cornerRadius(10)
                    }
                }
                .padding(.top)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    private func deleteDiary() {
        viewContext.delete(diary)
           
           do {
               try viewContext.save()
               dismiss()
               print("Diary deleted")
               } catch {
                   print("Error deleting diary: \(error.localizedDescription)")
           }
    }

    private func moodImageName(for mood: Int32) -> String {
        switch mood {
        case 1:
            return "face1"
        case 2:
            return "face2"
        case 3:
            return "face3"
        default:
            return "face4"
        }
    }

    private func formatTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }

    private func saveChanges() {
        diary.content = editedContent
        
        do {
            try viewContext.save()
            isEditing = false 
        } catch {
            print("Error saving diary: \(error.localizedDescription)")
        }
    }
}

struct DiaryDetail_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController(inMemory: true).viewContext
        
        let newDiary = Diary(context: context)
        newDiary.date = Date()
        newDiary.mood = 2
        newDiary.content = "Today was a good day. I had a lot of fun learning Swift!"
        
        do {
            try context.save()
        } catch {
            print("Error saving preview data: \(error.localizedDescription)")
        }
        
        return DiaryDetail(diary: newDiary)
            .environment(\.managedObjectContext, context)
    }
}
