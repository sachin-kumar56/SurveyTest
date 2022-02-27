//
//  SwiftUIView.swift
//  
//
//  Created by Sachin Kumar J on 27/02/22.
//

import SwiftUI

struct MultipleChoice: View {
    @EnvironmentObject var surveyManager : SurveyManager
    @State var currentAnswer = []
    var body: some View {
        ForEach(surveyManager.currentQuestion.choices,id: \.id){
            choice in
            HStack(spacing:20){
                Image(systemName: "circle.fill").font(.caption)
                
                Text(choice.text).bold()
                
            }.padding().frame(maxWidth:.infinity,alignment: .leading).background(currentAnswer.contains{ $0 as! Int == choice.id } ?  Color.green : Color(hex: "#808080", alpha: 0.3) ).cornerRadius(10)
            .onTapGesture {
                print("selected choice id is",choice.id,"current answer is",currentAnswer)
                if(currentAnswer.contains{ $0 as! Int == choice.id }){
                    currentAnswer = currentAnswer.filter { $0 as! Int != choice.id  }
                }
                else{
                    currentAnswer.append(choice.id)
                }
            }
        }
        Button("Next"){
            withAnimation(Animation.spring().delay(0.5)){
                surveyManager.selectedAnswer(answer:currentAnswer)
            }
        }
    }
}

