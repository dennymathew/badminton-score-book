import XCTest
@testable import BadmintonScoreBook

class ViewModelTests: XCTestCase {
    
    func testTeamAssignment() {
        let player1 = Player(id: "1", name: "P1", email: "p1@test.com")
        let player2 = Player(id: "2", name: "P2", email: "p2@test.com")
        let player3 = Player(id: "3", name: "P3", email: "p3@test.com")
        let player4 = Player(id: "4", name: "P4", email: "p4@test.com")
        
        let viewModel = TeamAssignmentViewModel(players: [player1, player2, player3, player4])
        
        viewModel.addToTeam1(player1)
        viewModel.addToTeam1(player2)
        
        XCTAssertEqual(viewModel.team1Players.count, 2)
        XCTAssertEqual(viewModel.availablePlayers.count, 2)
        
        viewModel.addToTeam2(player3)
        viewModel.addToTeam2(player4)
        
        XCTAssertEqual(viewModel.team2Players.count, 2)
        XCTAssertTrue(viewModel.canStartGame)
    }
    
    func testPlayerSelection() {
        let viewModel = PlayerSelectionViewModel()
        let player1 = Player(id: "1", name: "P1", email: "p1@test.com")
        
        viewModel.toggleSelection(for: player1)
        XCTAssertTrue(viewModel.selectedPlayers.contains(player1))
        
        viewModel.toggleSelection(for: player1)
        XCTAssertFalse(viewModel.selectedPlayers.contains(player1))
    }
}
