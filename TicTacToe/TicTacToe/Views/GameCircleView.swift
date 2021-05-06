
import SwiftUI

struct GameCircleView: View {
    var proxy: GeometryProxy
    var body: some View {
        Circle()
//            .foregroundColor(.blue).opacity(0.5)
            .strokeBorder(Color("ButtonStrokeColor"), lineWidth: Constants.General.strokeWidth)
            .frame(width: proxy.size.width/3 - 15, height: proxy.size.width/3 - 15)
    }
}

struct GameCircleView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
