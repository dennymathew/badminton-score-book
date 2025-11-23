import SwiftUI

struct TeamAssignmentView: View {
    @State private var viewModel: TeamAssignmentViewModel
    @State private var navigateToScoring = false
    
    init(players: [Player]) {
        _viewModel = .init(wrappedValue: TeamAssignmentViewModel(players: players))
    }
    
    var body: some View {
        VStack {
            Text("Assign Teams")
                .font(.title)
                .padding()
            
            HStack {
                VStack {
                    Text("Team A")
                        .font(.headline)
                    List(viewModel.team1Players) { player in
                        Text(player.name)
                            .onTapGesture {
                                viewModel.removeFromTeam1(player)
                            }
                    }
                }
                
                VStack {
                    Text("Team B")
                        .font(.headline)
                    List(viewModel.team2Players) { player in
                        Text(player.name)
                            .onTapGesture {
                                viewModel.removeFromTeam2(player)
                            }
                    }
                }
            }
            .frame(height: 200)
            
            Text("Available Players")
                .font(.headline)
                .padding(.top)
            
            List(viewModel.availablePlayers) { player in
                HStack {
                    Text(player.name)
                    Spacer()
                    Button("Team A") {
                        viewModel.addToTeam1(player)
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Team B") {
                        viewModel.addToTeam2(player)
                    }
                    .buttonStyle(.bordered)
                }
            }
            
            NavigationLink(destination: MatchScoringView(team1: viewModel.getTeam1(), team2: viewModel.getTeam2()), isActive: $navigateToScoring) {
                EmptyView()
            }
            
            Button("Start Game") {
                navigateToScoring = true
            }
            .disabled(!viewModel.canStartGame)
            .padding()
            .buttonStyle(.borderedProminent)
        }
    }
}
