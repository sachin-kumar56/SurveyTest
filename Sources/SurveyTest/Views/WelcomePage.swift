//
//  SwiftUIView.swift
//  
//
//  Created by Sachin Kumar J on 27/02/22.
//

import SwiftUI

struct WelcomePage: View {
    @EnvironmentObject var surveyManager : SurveyManager
    var body: some View {
        VStack(spacing:40){
            VStack(spacing: 20){
                Text("Welcome Page").font(.title).fontWeight(.heavy).foregroundColor(Color.red)
                Text("Some Description for welcome page").foregroundColor(Color.red)
            }
            Text("Next").foregroundColor(.white).padding().padding(.horizontal).background(Color.green).cornerRadius(30).shadow(radius:10).onTapGesture {
                withAnimation() {
                    surveyManager.setShowQuestionList()
                }
            }
        }
    }
}

