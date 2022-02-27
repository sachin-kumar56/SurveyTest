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
    
    func submitSurvey(){
        guard let url = URL(string: "http://sample.surveysparrow.test/api/internal/offline-app/v3/post-sdk-data") else{ return }
        do {
            let jsonData = try JSONEncoder().encode(collectedAnswers)
            let jsonString = String(data: jsonData, encoding: .utf8)
            let body: [String:String] = ["Answers":(jsonString)!]
            
            let finalBody = try! JSONSerialization.data(withJSONObject: body)
            
            var request = URLRequest(url: url)
            request.httpMethod="POST"
            request.httpBody=finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request){(data,response,error) in print(data)}.resume()
        } catch{
            print(error)
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
        print("obtained current question is",currentQuestion)
        if(currentQuestion.type == "Rating"){
            let ans = submitAnswer.Answer(id: currentQuestion.id, singleChoiceVal: answer as! Int, choiceValue: [], value: "")
            collectedAnswers.append(ans)
            goToNextQuestion()
        }
        else if(currentQuestion.type == "Text"){
            let ans = submitAnswer.Answer(id: currentQuestion.id, singleChoiceVal: -1 , choiceValue: [], value: answer as! String)
            collectedAnswers.append(ans)
            goToNextQuestion()
        }
        else{
            let ans = submitAnswer.Answer(id: currentQuestion.id, singleChoiceVal: -1, choiceValue: answer as! [Int], value: "")
            collectedAnswers.append(ans)
            goToNextQuestion()
        }

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
