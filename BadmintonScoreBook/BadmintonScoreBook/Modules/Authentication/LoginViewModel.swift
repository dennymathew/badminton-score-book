import Foundation
import FirebaseAuth

@Observable
class LoginViewModel {
    var errorMessage: String?
    var isLoading = false
    
    private let authService = AuthenticationService.shared

    init() {}

    func signInWithGoogle() {
        isLoading = true
        errorMessage = nil
        
        authService.signInWithGoogle { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(_):
                    // Successful login is handled by the auth state listener in App
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
