//
//  SwiftUIView 2.swift
//  
//
//  Created by Sachin Kumar J on 27/02/22.
//

import SwiftUI

struct Rating: View {
    @EnvironmentObject var surveyManager : SurveyManager
    @State var selected = -1
    var body: some View {
        VStack{
            Text("From new rating")
            HStack(spacing:10,content:{
                ForEach(0..<5){i in
                    Image(systemName: "star.fill").resizable().frame(width: 30, height: 30).foregroundColor(self.selected >= i ? .yellow : .gray).onTapGesture {
                            surveyManager.selectedAnswer(answer: i)
                            self.selected = i
                    }
                }
            })
        }
    }
}
