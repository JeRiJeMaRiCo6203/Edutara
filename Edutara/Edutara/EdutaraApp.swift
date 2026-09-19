import SwiftUI

@main
struct EdutaraApp: App {
    @State private var appState = AppState()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
                .preferredColorScheme(appState.isDarkMode ? .dark : .light)
        }
    }
}
