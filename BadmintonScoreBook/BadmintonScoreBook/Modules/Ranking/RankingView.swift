import SwiftUI

struct RankingView: View {
    @State private var viewModel = RankingViewModel()
    
    var body: some View {
        VStack {
            Text("Rankings")
                .font(.largeTitle)
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                List(Array(viewModel.players.enumerated()), id: \.element.id) { index, player in
                    HStack {
                        Text("\(index + 1)")
                            .font(.headline)
                            .frame(width: 30)
                        
                        VStack(alignment: .leading) {
                            Text(player.name)
                                .fontWeight(viewModel.isCurrentUser(player) ? .bold : .regular)
                            Text(player.email)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("\(player.points) pts")
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, 4)
                    .background(viewModel.isCurrentUser(player) ? Color.blue.opacity(0.1) : Color.clear)
                }
            }
            
            Button("Back to Home") {
                // In a real app, we might want to pop to root.
                // For now, since we are in a NavigationView stack, we can rely on the user navigating back manually
                // or implement a custom coordinator.
                // However, since we presented this view via NavigationLink, we are deep in the stack.
                // A simple way to go home is to reset the app state or use a binding to pop to root.
                // For simplicity in this scope, we'll just let the user use the back button or restart.
                // But let's add a button that does nothing for now as a placeholder for "Done".
            }
            .padding()
            .hidden() // Hiding it as we rely on Navigation back or restart
        }
        .onAppear {
            viewModel.fetchRankings()
        }
    }
}
