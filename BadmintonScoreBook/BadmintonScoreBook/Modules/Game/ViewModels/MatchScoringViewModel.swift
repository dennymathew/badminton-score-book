import Foundation

@Observable
class MatchScoringViewModel {
    var team1Score = 0
    var team2Score = 0
    var currentSet = 1
    var team1SetsWon = 0
    var team2SetsWon = 0
    var isGameOver = false
    var winningTeamName: String?
    
    let team1: Team
    let team2: Team
    private let gameService = GameService()
    
    init(team1: Team, team2: Team) {
        self.team1 = team1
        self.team2 = team2
    }
    
    func team1Scored() {
        team1Score += 1
        checkSetWinner()
    }
    
    func team2Scored() {
        team2Score += 1
        checkSetWinner()
    }
    
    private func checkSetWinner() {
        if (team1Score >= 21 && team1Score - team2Score >= 2) {
            winSet(team: 1)
        } else if (team2Score >= 21 && team2Score - team1Score >= 2) {
            winSet(team: 2)
        }
    }
    
    private func winSet(team: Int) {
        if team == 1 {
            team1SetsWon += 1
        } else {
            team2SetsWon += 1
        }
        
        if team1SetsWon == 2 {
            endGame(winner: team1)
        } else if team2SetsWon == 2 {
            endGame(winner: team2)
        } else {
            startNextSet()
        }
    }
    
    private func startNextSet() {
        currentSet += 1
        team1Score = 0
        team2Score = 0
    }
    
    private func endGame(winner: Team) {
        isGameOver = true
        winningTeamName = winner.name
        
        gameService.saveGameResult(team1: team1, team2: team2, team1SetsWon: team1SetsWon, team2SetsWon: team2SetsWon) { error in
            if let error = error {
                print("Error saving game: \(error.localizedDescription)")
            }
        }
    }
}
