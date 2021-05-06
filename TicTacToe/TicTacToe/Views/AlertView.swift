
import SwiftUI

struct AlertView: View {
    @StateObject private var viewModel = GameViewModel()
    @Binding var alertIsPresent: Bool
    let title: String
    let description: String
    let buttonTitle: String
    
    var body: some View {
        VStack(spacing: 10) {
 
            Text(title.uppercased())
                .bold()
                .kerning(2.0)
                .multilineTextAlignment(.center)
                .font(.footnote)
                .foregroundColor(Color("ButtonColor"))
            Text(description)
                .foregroundColor(Color("ButtonColor"))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(12)

            
            Button(action: {
                viewModel.resetGame()
                viewModel.isAlertOn = false
                
            }) {
                Text(buttonTitle)
                    .bold()
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("ButtonStrokeColor"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
            .padding()
            .frame(maxWidth: 300)
            .background(Color("BackgroundColor"))
            .cornerRadius(Constants.General.roundRectCornerRadius)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 6 )
            .transition(.scale)
    }}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(alertIsPresent: Binding.constant(true), title: "you have won", description: "Try harder next time", buttonTitle: "Try again")
    }
}
