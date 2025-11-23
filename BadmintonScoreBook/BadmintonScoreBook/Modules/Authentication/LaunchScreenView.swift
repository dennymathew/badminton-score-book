import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct LaunchScreenView: View {
    @State private var isActive = false
    private var authService = AuthenticationService.shared
    
    var body: some View {
        Group {
            if isActive {
                if authService.user != nil {
                    HomeView()
                } else {
                    LoginView()
                }
            } else {
                VStack {
                    Image(systemName: "sportscourt.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    Text("Badminton Score Book")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                }
                .onAppear {
                    setupApp()
                }
            }
        }
    }
    
    private func setupApp() {
        // Configure Firebase if not already configured
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        // Configure Auth Service
        authService.configure()
        
        // Check for previous sign-in
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let user = user {
                // We don't need to manually set user here as the listener in configure() will handle it
                // But restorePreviousSignIn is needed for GIDSignIn state
            }
            
            // Artificial delay for launch screen effect (optional)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
