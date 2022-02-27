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

struct submitAnswer{
    let answer : [Answer]
    struct Answer {
        var id:Int
        var value: Any
    }
}
