import Foundation
import FirebaseFirestore

struct Player: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var points: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case points
    }
}
