//
//  SwiftUIView.swift
//  
//
//  Created by Sachin Kumar J on 27/02/22.
//

import SwiftUI

struct Questions: View {
    @EnvironmentObject var surveyManager : SurveyManager
    var body: some View {
        let _ = print("called print in question view",surveyManager.currentQuestion)
        if(surveyManager.isFirstQuestion){
            WelcomePage().environmentObject(surveyManager).transition(.move(edge: .leading)).animation(.easeInOut)
        }
        if(surveyManager.showQuestionList){
            QuestionView().environmentObject(surveyManager).id(surveyManager.currentQuestion.id).transition(.move(edge: .leading)).animation(.easeInOut)
        }
        if(surveyManager.allQuestionAnswered){
            Button("Submit"){
                print("Answers Collected SO far is",surveyManager.collectedAnswers)
            }
        }
    }
}

