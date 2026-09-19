import SwiftUI

struct RootView: View {
    @Environment(AppState.self) var appState
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            RadialGradient(colors: [Color.edutaraSecondary.opacity(0.08), .clear], center: .topTrailing, startRadius: 20, endRadius: 600).ignoresSafeArea()
            RadialGradient(colors: [Color.edutaraPrimary.opacity(0.04), .clear], center: .bottomLeading, startRadius: 20, endRadius: 700).ignoresSafeArea()
            if appState.currentUser == nil {
                LoginView()
            } else {
                MainTabView()
            }
        }.animation(.easeInOut(duration: 0.3), value: appState.currentUser?.id)
    }
}
#Preview { RootView().environment(AppState()) }
