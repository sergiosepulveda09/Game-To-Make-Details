import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea(.all)
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.resetGame()
                        }, label: {
                            ButtonView(systemName: "arrow.counterclockwise")
                        })
                    }
                    Spacer()
                    LazyVGrid(columns: viewModel.columns, spacing: 5) {
                        ForEach(0..<9) { i in
                            ZStack {
                                GameCircleView(proxy: geometry)
                                PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                            }
                            .onTapGesture {
                                viewModel.proccessPlayerMove(for: i)
                            }
                        }
                    }
                    Spacer()
                }
                .disabled(viewModel.isGameboardDisabled)
                .padding()
                .alert(item: $viewModel.alertItem, content: {  alertItem in
                    Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: .default(Text(alertItem.buttonTitle), action: { viewModel.resetGame() }))
                })
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

