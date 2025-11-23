import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import SwiftUI

@main
struct BadmintonScoreBookApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
