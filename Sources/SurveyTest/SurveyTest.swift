import SwiftUI

public struct SurveyTest: View {
    @StateObject var surveyManager = SurveyManager()
    public init(){}
    
    public var body: some View {
        VStack{
            Questions().environmentObject(surveyManager).frame(maxWidth:.infinity,maxHeight:.infinity).edgesIgnoringSafeArea(.all)
        }.frame(maxWidth:.infinity,maxHeight:.infinity).edgesIgnoringSafeArea(.all)
    }
}
