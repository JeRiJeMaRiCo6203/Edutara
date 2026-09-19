import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack { HomeView() }.tabItem { Label("Beranda", systemImage: "house.fill") }
            NavigationStack { MaterialListView() }.tabItem { Label("Materi", systemImage: "books.vertical.fill") }
            NavigationStack { QuizListView() }.tabItem { Label("Kuis", systemImage: "pencil.and.ruler.fill") }
            NavigationStack { ForumListView() }.tabItem { Label("Forum", systemImage: "bubble.left.and.bubble.right.fill") }
            NavigationStack { ProfileView() }.tabItem { Label("Profil", systemImage: "person.crop.circle.fill") }
        }.tint(Color.edutaraSecondary)
    }
}
#Preview { MainTabView().environment(AppState()) }
