//
//  MoodSelect.swift
//  MoodTracker
//
//  Created by Yujin on 12/9/24.
//

import SwiftUI

struct MoodSelect: View {
    @Binding var selectedMoodIndex: Int?
    
      let imageNames = ["face1", "face2", "face3", "face4", "face5"]
      
      var body: some View {
          HStack {
              ForEach(0..<imageNames.count, id: \.self) { index in
                  Button(action: {
                      selectedMoodIndex = index
                  }) {
                      Image(imageNames[index])
                          .resizable()
                          .scaledToFit()
                          .frame(width: 40, height: 40)
                          .padding(5)
                          .background(
                          
                            selectedMoodIndex == index ? Color.clear : Color.clear
                          )
                          .overlay(
                            selectedMoodIndex == index ?
                                  RoundedRectangle(cornerRadius: 30)
                                      .stroke(Color("BGColor"), lineWidth: 3) :
                                  nil
                          )
                          .scaleEffect(selectedMoodIndex == index ? 1.2 : 1)
                  }
                  .padding(.bottom, 10)
              }
          }
          .padding()
      }
  }

