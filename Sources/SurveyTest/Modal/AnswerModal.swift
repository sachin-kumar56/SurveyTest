//
//  File.swift
//  
//
//  Created by Sachin Kumar J on 27/02/22.
//

import Foundation

struct AnswerCheck: Identifiable {
    var id = UUID()
    var text: String
    var answerId: Int
}

struct submitAnswer:Codable{
    let answer : [Answer]
    struct Answer: Codable {
        var id:Int
        var singleChoiceVal:Int
        var choiceValue: [Int]
        var value : String
    }
}
