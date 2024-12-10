import SwiftUI

struct DiaryRow: View {
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Diary.date, ascending: true)],
        animation: .default)
    private var diaries: FetchedResults<Diary>

    var body: some View {
        ZStack {
            Color("BGColor")
                .ignoresSafeArea()
            
            VStack {
                ForEach(diaries, id: \.self) { diary in
                    NavigationLink(destination: DiaryDetail(diary: diary)) {
                        VStack(alignment: .leading) {
                            Text(diary.date ?? Date(), style: .date)
                                .font(.headline)
                            
                            Text(formatTime(from: diary.date ?? Date()))
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Image(moodImageName(for: diary.mood))
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                            
                            Text(diary.content ?? "")
                                .font(.footnote)
                                .lineLimit(3)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
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

struct DiaryRow_Previews: PreviewProvider {
    static var previews: some View {
        // Create an in-memory context for the preview
        let context = PersistenceController(inMemory: true).viewContext
        
        // Insert example data into the context
        let newDiary = Diary(context: context)
        newDiary.date = Date()
        newDiary.mood = 1
        newDiary.content = "This is a sample diary entry for preview."
        
        do {
            try context.save()
        } catch {
            print("Error saving preview data: \(error.localizedDescription)")
        }
        
        return DiaryRow()
            .environment(\.managedObjectContext, context) // Provide the context to the preview
    }
}
