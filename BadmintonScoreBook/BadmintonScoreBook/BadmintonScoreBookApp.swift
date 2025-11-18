import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import SwiftUI

@main
struct BadmintonScoreBookApp: App {
    @State private var isShowingLogin = false
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .onOpenURL { url in
                        GIDSignIn.sharedInstance.handle(url)
                    }
                    .onAppear {
                        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                            if let user {
                                print("USER LOGGED IN...", user.profile?.email ?? "EMAIL NOT AVAILABLE")
                            } else {
                                isShowingLogin = true
                            }
                        }
                    }
                    .fullScreenCover(isPresented: $isShowingLogin) {
                        LoginView()
                    }

            }
        }
    }
}
