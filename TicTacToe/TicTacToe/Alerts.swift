
import SwiftUI


struct AlertItem: Identifiable {
    let id = UUID()
    var title: String
    var message: String
    var buttonTitle: String
}

struct AlertContext {
    static let humanWin = AlertItem(title: "You win!",
                             message: "Congratulations!",
                             buttonTitle: "Play Again")
    static let computerWin = AlertItem(title: "You lost!",
                             message: "Try harder next time",
                             buttonTitle: "Rematch")
    static let draw = AlertItem(title: "It is a draw",
                             message: "Well done. You didn't lose",
                             buttonTitle: "Try again")
}
