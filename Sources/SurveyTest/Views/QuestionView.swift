//
//  SwiftUIView.swift
//  
//
//  Created by Sachin Kumar J on 27/02/22.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var surveyManager : SurveyManager
    var body: some View {
        VStack(spacing: 40){
            VStack(alignment: .leading, content: {
                Text(surveyManager.currentQuestion.heading).font(.system(size:20))
                Text(surveyManager.currentQuestion.subHeading).font(.system(size:20))
                if(surveyManager.currentQuestion.type == "Rating"){
                    Rating().environmentObject(surveyManager)

                }
                if(surveyManager.currentQuestion.type == "Text"){
                    TextQuestion().environmentObject(surveyManager)
                }
                if(surveyManager.currentQuestion.type == "Multiple Choice"){
                    MultipleChoice().environmentObject(surveyManager)
                }
            })
        }.frame(maxWidth:.infinity,maxHeight:.infinity).edgesIgnoringSafeArea(.all)
    }
}


