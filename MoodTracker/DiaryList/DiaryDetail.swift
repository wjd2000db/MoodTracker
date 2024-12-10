import SwiftUI

struct DiaryDetail: View {
    var diary: Diary
    @Environment(\.managedObjectContext) private var viewContext
    
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
                    Text(diary.content ?? "")
                        .font(.body)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding()
            .navigationBarTitleDisplayMode(.inline)
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
}

struct DiaryDetail_Previews: PreviewProvider {
    static var previews: some View {
        // Create an in-memory context for the preview
        let context = PersistenceController(inMemory: true).viewContext
        
        // Insert example data into the context
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
