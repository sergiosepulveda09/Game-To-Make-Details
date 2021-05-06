
import SwiftUI

struct PlayerIndicator: View {
    
    var systemImageName: String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(Color("ButtonColor"))
    }
}

struct PlayerIndicator_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
