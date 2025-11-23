import Foundation

@Observable
class HomeViewModel {
    var navigateToPlayerSelection = false
    
    func createNewGame() {
        navigateToPlayerSelection = true
    }
    
    func signOut() {
        AuthenticationService.shared.signOut()
    }
}
