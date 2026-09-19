import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) var appState
    @State private var showLeaderboard = false
    @State private var toast = ""
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            RadialGradient(colors: [Color.edutaraSecondary.opacity(0.08), .clear], center: .topTrailing, startRadius: 20, endRadius: 600).ignoresSafeArea()
            ScrollView {
                VStack(spacing: 18) {
                    ProfileGlassCard()
                    ContinueLearningRow()
                    DailyFactWidget(toast: $toast)
                    LeaderboardGlassView(showAll: $showLeaderboard)
                }.padding(16)
            }
        }
        .navigationTitle("Beranda")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showLeaderboard) { LeaderboardSheet() }
        .overlay { if !toast.isEmpty { VStack { Spacer(); Text(toast).font(.footnote.weight(.semibold)).padding(.horizontal, 16).padding(.vertical, 10).glassCapsule().padding(.bottom, 20) } } }
    }
}

struct LeaderboardSheet: View {
    @Environment(AppState.self) var appState
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(appState.leaderboardSorted().enumerated()), id: \.element.id) { idx, s in
                    let user = appState.user(for: s.userID)
                    HStack {
                        Text("#\(idx+1)").font(.caption.weight(.bold)).foregroundStyle(idx < 3 ? Color.edutaraSecondary : .secondary).frame(width: 36)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(user?.name ?? "-").font(.subheadline.weight(.semibold))
                            Text("Avg \(String(format: "%.1f", s.averageScore)) • \(s.quizzesCompleted) kuis").font(.caption2).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text("\(s.xp) XP").font(.caption.weight(.bold)).foregroundStyle(Color.edutaraPrimary)
                    }.listRowBackground(appState.currentUser?.id == s.userID ? Color.edutaraSecondary.opacity(0.12) : Color.clear)
                }
            }.navigationTitle("Leaderboard").navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview { NavigationStack { HomeView().environment(AppState()) } }
