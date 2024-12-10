//
//  ShowAdvice.swift
//  MoodTracker
//
//  Created by Yujin on 12/9/24.
//

import SwiftUI

struct ShowAdvice: View {
    @State private var advice: String = "Loading Advice..."
    
    var body: some View {
        Text(advice)
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding()
            .onAppear {fetchAdvice()}
    }
    
    func fetchAdvice() {
           guard let url = URL(string: "https://api.adviceslip.com/advice") else {
               print("Invalid URL")
               return
           }

           let task = URLSession.shared.dataTask(with: url) { data, response, error in
               if let error = error {
                   print("Error fetching advice: \(error.localizedDescription)")
                   return
               }
               
               if let data = data {
                   do {
                      
                       let decodedResponse = try JSONDecoder().decode(AdviceResponse.self, from: data)
                       DispatchQueue.main.async {
                           self.advice = decodedResponse.slip.advice // UI 업데이트
                       }
                   } catch {
                       print("Error decoding data: \(error)")
                   }
               }
           }
           
           task.resume()
       }
}

#Preview {
    ShowAdvice()
}
