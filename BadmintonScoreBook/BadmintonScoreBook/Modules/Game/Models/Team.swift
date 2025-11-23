import Foundation

struct Team: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var players: [Player]
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        lhs.id == rhs.id
    }
}
