import SwiftUI

final class GameViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var alertItem: AlertItem?
    @Published var isAlertOn: Bool = false
    func proccessPlayerMove(for position: Int) {
        if isSquareOccupied(in: moves, forIndex: position) {
            return
        }
        else {
            //Human moves
            moves[position] = Move(player: .human, boardIndex: position)
            if checkWinCondition(for: .human, in: moves) {
                alertItem = AlertContext.humanWin
                toggleAlert()
                return
            }
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                toggleAlert()
                return
            }
            isGameboardDisabled = true
            
            //Computer moves
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                let computerPosition = determineComputerMovePosition(in: moves)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                isGameboardDisabled = false
                if checkWinCondition(for: .computer, in: moves) {
                    alertItem = AlertContext.computerWin
                    toggleAlert()
                    return
                }
                if checkForDraw(in: moves) {
                    alertItem = AlertContext.draw
                    toggleAlert()
                    return
                }
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        
        //If Ai can win, then win
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer}
        let computerPositions = Set(computerMoves.map { $0.boardIndex})
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable {
                    return winPositions.first!
                }
            }
        }
        
        //If AI can't win, then block
        
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human}
        let humanPositions = Set(humanMoves.map { $0.boardIndex})
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable {
                    return winPositions.first!
                }
            }
        }
        
        //If I Can't block, then take middle square
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {
            return centerSquare
        }
        

        
        //If ai cant take middle, take any random
        var movePosition = Int.random(in: 0..<9)
        while isSquareOccupied(in: moves, forIndex: movePosition) {
             movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player}
        let playerPosition = Set(playerMoves.map { $0.boardIndex})
        
        for pattern in winPatterns where pattern.isSubset(of: playerPosition) {
            return true
        }
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{ $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
    func toggleAlert() {
        self.isAlertOn.toggle()
    }

    
}


