//
//  TriviaManager.swift
//  BMI Calculator
//
//  Created by Sachin Kumar J on 13/02/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import SwiftUI

class SurveyManager: ObservableObject {
    private(set) var survey: [Question.Ques] = []
    @Published private(set) var collectedAnswers:[submitAnswer.Answer] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var currentQuestion = Question.Ques(type: "", heading: "", subHeading: "", id: 0, choices: [])
    @Published private(set) var progress: CGFloat = 0.0
    @Published private(set) var allQuestionAnswered = false
    @Published private(set) var isFirstQuestion = true
    @Published private(set) var showQuestionList = false
    
    
    init() {
        fetchSurvey()
    }
    
    func fetchSurvey() {
        if let url = URL(string: "http://sample.surveysparrow.test/api/internal/offline-app/v3/get-sdk-data" ){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            task.resume()
        }
    }
    
    func handle(data:Data?,response:URLResponse?,error:Error?){
        let decoder = JSONDecoder()
        if error != nil{
            print(error ?? "some error occured in handling the featched response from server")
            return
        }
        if let safeData = data {
            _ = String(data:safeData,encoding: .utf8)
          
            do {
                let decodedData = try decoder.decode(Question.self, from: safeData)
                DispatchQueue.main.async {
                    self.survey = decodedData.question
                    self.length = self.survey.count
                    self.setQuestion()
                }
                print(decodedData.question[0].heading)
            } catch{
                print(error)
            }
       
        }
    }
    
    func goToNextQuestion(){
        if index + 1 < length {
            index += 1
            setQuestion()
        }else{
            setShowThankYouPage()
        }
    }
    
    func setQuestion(){
        answerSelected = false
        progress = CGFloat(Double(index+1)/Double(length)*350)
        
        if index<length{
            currentQuestion = survey[index]
        }

    }
    
    func selectedAnswer(answer:Any){
        let ans = submitAnswer.Answer(id: currentQuestion.id, value: answer)
        collectedAnswers.append(ans)
        goToNextQuestion()
    }
    
    func setShowQuestionList(){
        isFirstQuestion = false
        showQuestionList = true
    }
    func setShowThankYouPage(){
        showQuestionList = false
        allQuestionAnswered = true
    }
}
