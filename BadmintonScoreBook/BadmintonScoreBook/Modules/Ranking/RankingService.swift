import Foundation
import FirebaseFirestore

class RankingService {
    private let db = Firestore.firestore()
    
    func fetchRankings(completion: @escaping (Result<[Player], Error>) -> Void) {
        db.collection("users")
            .order(by: "points", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                let players = documents.compactMap { try? $0.data(as: Player.self) }
                completion(.success(players))
            }
    }
}
