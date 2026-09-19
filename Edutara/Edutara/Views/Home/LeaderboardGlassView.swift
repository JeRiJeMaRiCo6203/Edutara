import SwiftUI

struct LeaderboardGlassView: View {
    @Environment(AppState.self) var appState
    @Binding var showAll: Bool
    var top5: [Stats] { Array(appState.leaderboardSorted().prefix(5)) }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Leaderboard").font(.system(size: 17, weight: .semibold, design: .rounded)).foregroundStyle(Color.edutaraPrimary)
                Spacer()
                Button("Lihat semua") { showAll = true }.font(.caption.weight(.semibold)).foregroundStyle(Color.edutaraSecondary)
            }
            VStack(spacing: 8) {
                ForEach(Array(top5.enumerated()), id: \.element.id) { idx, s in
                    let user = appState.user(for: s.userID)
                    let isCurrent = appState.currentUser?.id == s.userID
                    HStack(spacing: 10) {
                        ZStack {
                            Circle().fill(idx < 3 ? Color.edutaraSecondary.opacity(0.18) : Color.clear).frame(width: 30, height: 30)
                            Text("\(idx+1)").font(.caption.weight(.bold)).foregroundStyle(idx < 3 ? Color.edutaraSecondary : .secondary)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text(user?.name ?? "-").font(.subheadline.weight(.semibold)).foregroundStyle(Color.edutaraPrimary).lineLimit(1)
                            Text("\(s.xp) XP • \(s.streakDays) streak").font(.caption2).foregroundStyle(.secondary)
                        }
                        Spacer()
                        if isCurrent { Image(systemName: "star.fill").font(.caption2).foregroundStyle(Color.edutaraSecondary) }
                    }.padding(.horizontal, 12).padding(.vertical, 10)
                    .background(isCurrent ? Color.edutaraSecondary.opacity(0.12) : Color.clear, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(isCurrent ? Color.edutaraSecondary.opacity(0.22) : Color.clear, lineWidth: 1))
                }
            }.padding(6).glassCard(cornerRadius: 20)
        }
    }
}
#Preview { LeaderboardGlassView(showAll: .constant(false)).environment(AppState()).padding() }
