import Foundation
import FirebaseAuth

@Observable
class RankingViewModel {
    var players: [Player] = []
    var isLoading = false
    var errorMessage: String?
    
    private let rankingService = RankingService()
    
    func fetchRankings() {
        isLoading = true
        rankingService.fetchRankings { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let players):
                    self?.players = players
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func isCurrentUser(_ player: Player) -> Bool {
        guard let currentUserEmail = Auth.auth().currentUser?.email else { return false }
        return player.email == currentUserEmail
    }
}
