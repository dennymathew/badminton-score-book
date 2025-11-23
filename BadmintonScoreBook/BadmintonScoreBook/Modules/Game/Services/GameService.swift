import Foundation
import FirebaseFirestore

class GameService {
    private let db = Firestore.firestore()
    
    func saveGameResult(team1: Team, team2: Team, team1SetsWon: Int, team2SetsWon: Int, completion: @escaping (Error?) -> Void) {
        let winningTeam = team1SetsWon > team2SetsWon ? team1 : team2
        let losingTeam = team1SetsWon > team2SetsWon ? team2 : team1
        
        // Update points for winning team players
        let batch = db.batch()
        
        for player in winningTeam.players {
            guard let playerId = player.id else { continue }
            let playerRef = db.collection("users").document(playerId)
            batch.updateData(["points": FieldValue.increment(Int64(1))], forDocument: playerRef)
        }
        
        // Save game record (optional, based on requirements)
        let gameRef = db.collection("games").document()
        let gameData: [String: Any] = [
            "date": Timestamp(date: Date()),
            "team1": team1.players.map { $0.name },
            "team2": team2.players.map { $0.name },
            "team1SetsWon": team1SetsWon,
            "team2SetsWon": team2SetsWon,
            "winner": winningTeam.name
        ]
        batch.setData(gameData, forDocument: gameRef)
        
        batch.commit { error in
            completion(error)
        }
    }
}
