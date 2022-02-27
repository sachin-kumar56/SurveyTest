//
//  SwiftUIView.swift
//  
//
//  Created by Sachin Kumar J on 27/02/22.
//

import SwiftUI

struct TextQuestion: View {
    @EnvironmentObject var surveyManager : SurveyManager
    @State var textAnswer:String = ""
    
    var body: some View {
        HStack(spacing:10,content:{
            TextField("Please enter your Response",text: $textAnswer)
            Button("Next"){
                surveyManager.selectedAnswer(answer:textAnswer)
                print("text answer is",textAnswer)
            }
        }).frame(maxWidth:200)
    }
}
