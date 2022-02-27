import SwiftUI

public struct SurveyTest: View {
    @StateObject var surveyManager = SurveyManager()
    var presentingVC: UIViewController?
    func passedFunction() {
        self.presentingVC?.presentedViewController?.dismiss(animated: true)
    }
    public init(){}
    
    public var body: some View {
        VStack{
            Questions(function: self.passedFunction).environmentObject(surveyManager).frame(maxWidth:.infinity,maxHeight:.infinity).edgesIgnoringSafeArea(.all)
        }.frame(maxWidth:.infinity,maxHeight:.infinity).edgesIgnoringSafeArea(.all)
    }
}
