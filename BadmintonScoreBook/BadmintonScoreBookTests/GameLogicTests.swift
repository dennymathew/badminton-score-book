import XCTest
@testable import BadmintonScoreBook

class GameLogicTests: XCTestCase {
    
    var viewModel: MatchScoringViewModel!
    var team1: Team!
    var team2: Team!
    
    override func setUp() {
        super.setUp()
        team1 = Team(name: "Team A", players: [])
        team2 = Team(name: "Team B", players: [])
        viewModel = MatchScoringViewModel(team1: team1, team2: team2)
    }
    
    func testInitialScore() {
        XCTAssertEqual(viewModel.team1Score, 0)
        XCTAssertEqual(viewModel.team2Score, 0)
        XCTAssertEqual(viewModel.currentSet, 1)
    }
    
    func testScoring() {
        viewModel.team1Scored()
        XCTAssertEqual(viewModel.team1Score, 1)
        
        viewModel.team2Scored()
        XCTAssertEqual(viewModel.team2Score, 1)
    }
    
    func testSetWin() {
        // Simulate Team 1 reaching 21 points with 2 point lead
        for _ in 0..<21 {
            viewModel.team1Scored()
        }
        
        XCTAssertEqual(viewModel.team1SetsWon, 1)
        XCTAssertEqual(viewModel.currentSet, 2)
        XCTAssertEqual(viewModel.team1Score, 0) // Score resets for new set
    }
    
    func testDeuceLogic() {
        // Reach 20-20
        for _ in 0..<20 {
            viewModel.team1Scored()
            viewModel.team2Scored()
        }
        
        XCTAssertEqual(viewModel.team1Score, 20)
        XCTAssertEqual(viewModel.team2Score, 20)
        
        // Team 1 scores -> 21-20 (No win yet)
        viewModel.team1Scored()
        XCTAssertEqual(viewModel.team1SetsWon, 0)
        
        // Team 1 scores again -> 22-20 (Win)
        viewModel.team1Scored()
        XCTAssertEqual(viewModel.team1SetsWon, 1)
    }
    
    func testMatchWin() {
        // Win Set 1
        for _ in 0..<21 {
            viewModel.team1Scored()
        }
        XCTAssertEqual(viewModel.team1SetsWon, 1)
        XCTAssertEqual(viewModel.currentSet, 2)
        
        // Win Set 2
        for _ in 0..<21 {
            viewModel.team1Scored()
        }
        XCTAssertEqual(viewModel.team1SetsWon, 2)
        XCTAssertTrue(viewModel.isGameOver)
        XCTAssertEqual(viewModel.winningTeamName, "Team A")
    }
}
