//
//  File.swift
//  
//
//  Created by Sachin Kumar J on 27/02/22.
//

import Foundation

struct Question: Decodable {
    let question : [Ques]
    
    struct Ques:Decodable,Identifiable{
        var type : String
        var heading: String
        var subHeading: String
        var id: Int
        var choices: [Choice]
    }
    
    struct Choice:Decodable,Identifiable{
        var id: Int
        var text : String
    }
}
