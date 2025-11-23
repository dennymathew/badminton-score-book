import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Badminton Score Book")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                
                NavigationLink(destination: PlayerSelectionView(), isActive: $viewModel.navigateToPlayerSelection) {
                    EmptyView()
                }
                
                Button(action: {
                    viewModel.createNewGame()
                }) {
                    Text("Create New Game")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarHidden(false)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        viewModel.signOut()
                    }
                }
            }
        }
    }
}
