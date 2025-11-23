import SwiftUI

struct MatchScoringView: View {
    @State private var viewModel: MatchScoringViewModel
    @State private var navigateToRanking = false
    
    init(team1: Team, team2: Team) {
        _viewModel = .init(wrappedValue: MatchScoringViewModel(team1: team1, team2: team2))
    }
    
    var body: some View {
        VStack {
            Text("Set \(viewModel.currentSet)")
                .font(.largeTitle)
                .padding()
            
            HStack {
                VStack {
                    Text(viewModel.team1.name)
                        .font(.headline)
                    Text("\(viewModel.team1Score)")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                    Button("Point") {
                        viewModel.team1Scored()
                    }
                    .buttonStyle(.borderedProminent)
                    Text("Sets: \(viewModel.team1SetsWon)")
                }
                
                Spacer()
                
                VStack {
                    Text(viewModel.team2.name)
                        .font(.headline)
                    Text("\(viewModel.team2Score)")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                    Button("Point") {
                        viewModel.team2Scored()
                    }
                    .buttonStyle(.borderedProminent)
                    Text("Sets: \(viewModel.team2SetsWon)")
                }
            }
            .padding()
            
            if viewModel.isGameOver {
                Text("\(viewModel.winningTeamName ?? "") Wins!")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding()
                
                Button("See Rankings") {
                    navigateToRanking = true
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .navigationDestination(isPresented: $navigateToRanking) {
                    RankingView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
