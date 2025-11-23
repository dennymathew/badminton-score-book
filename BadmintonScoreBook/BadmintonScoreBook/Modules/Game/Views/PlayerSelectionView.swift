import SwiftUI

struct PlayerSelectionView: View {
    @State private var viewModel = PlayerSelectionViewModel()
    @State private var navigateToTeamAssignment = false
    
    var body: some View {
        VStack {
            Text("Select 4 Players")
                .font(.title2)
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                List(viewModel.players) { player in
                    HStack {
                        Text(player.name)
                        Spacer()
                        if viewModel.selectedPlayers.contains(player) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.toggleSelection(for: player)
                    }
                }
            }
            
            NavigationLink(destination: TeamAssignmentView(players: viewModel.selectedPlayers), isActive: $navigateToTeamAssignment) {
                EmptyView()
            }
            
            Button("Next") {
                navigateToTeamAssignment = true
            }
            .disabled(!viewModel.canProceed)
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            viewModel.fetchPlayers()
        }
    }
}
