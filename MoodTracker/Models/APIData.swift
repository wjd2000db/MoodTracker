//
//  APIData.swift
//  MoodTracker
//
//  Created by Yujin on 12/9/24.
//

import Foundation

struct AdviceResponse: Codable {
    let slip: Advice
}

struct Advice: Codable {
    let id: Int
    let advice: String
}
