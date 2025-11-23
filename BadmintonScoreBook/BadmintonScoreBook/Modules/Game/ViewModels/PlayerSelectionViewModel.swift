import Foundation
import FirebaseFirestore

@Observable
class PlayerSelectionViewModel {
    var players: [Player] = []
    var selectedPlayers: [Player] = []
    var isLoading = false
    var errorMessage: String?
    
    private let db = Firestore.firestore()
    
    func fetchPlayers() {
        isLoading = true
        db.collection("users").getDocuments { [weak self] snapshot, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                self?.players = documents.compactMap { document in
                    try? document.data(as: Player.self)
                }
            }
        }
    }
    
    func toggleSelection(for player: Player) {
        if selectedPlayers.contains(player) {
            selectedPlayers.removeAll { $0.id == player.id }
        } else {
            if selectedPlayers.count < 4 {
                selectedPlayers.append(player)
            }
        }
    }
    
    var canProceed: Bool {
        selectedPlayers.count == 4
    }
}
