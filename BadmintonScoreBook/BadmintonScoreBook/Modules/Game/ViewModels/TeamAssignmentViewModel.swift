import Foundation

@Observable
class TeamAssignmentViewModel {
    var team1Players: [Player] = []
    var team2Players: [Player] = []
    var availablePlayers: [Player]
    
    init(players: [Player]) {
        self.availablePlayers = players
    }
    
    func addToTeam1(_ player: Player) {
        if team1Players.count < 2 {
            team1Players.append(player)
            availablePlayers.removeAll { $0.id == player.id }
        }
    }
    
    func addToTeam2(_ player: Player) {
        if team2Players.count < 2 {
            team2Players.append(player)
            availablePlayers.removeAll { $0.id == player.id }
        }
    }
    
    func removeFromTeam1(_ player: Player) {
        team1Players.removeAll { $0.id == player.id }
        availablePlayers.append(player)
    }
    
    func removeFromTeam2(_ player: Player) {
        team2Players.removeAll { $0.id == player.id }
        availablePlayers.append(player)
    }
    
    var canStartGame: Bool {
        team1Players.count == 2 && team2Players.count == 2
    }
    
    func getTeam1() -> Team {
        Team(name: "Team A", players: team1Players)
    }
    
    func getTeam2() -> Team {
        Team(name: "Team B", players: team2Players)
    }
}
