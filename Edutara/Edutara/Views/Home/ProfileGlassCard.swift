import SwiftUI

struct ProfileGlassCard: View {
    @Environment(AppState.self) var appState
    var body: some View {
        let user = appState.currentUser ?? MockData.budi
        let stats = appState.statsForCurrentUser() ?? MockData.statsBudi
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous).fill(Theme.heroGradient)
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.white.opacity(0.92)).frame(width: 56, height: 56)
                        Text(appState.initials(for: user.name)).font(.headline.weight(.bold)).foregroundStyle(Color.edutaraPrimary)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Halo, \(user.name)").font(.system(size: 18, weight: .bold, design: .rounded)).foregroundStyle(.white)
                        Text("\(user.educationLevel) Kelas \(user.grade) - \(user.favoriteSubject.rawValue)").font(.caption.weight(.medium)).foregroundStyle(.white.opacity(0.85))
                    }
                    Spacer()
                }
                HStack(spacing: 10) {
                    Text("\(stats.xp) XP").font(.caption.weight(.bold)).padding(.horizontal, 10).padding(.vertical, 6).background(Color.edutaraSecondary, in: Capsule()).foregroundStyle(Color.edutaraPrimary)
                    Label("\(stats.streakDays) hari", systemImage: "flame.fill").font(.caption.weight(.semibold)).foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "sparkles").foregroundStyle(.white.opacity(0.9))
                }
            }.padding(16)
        }.frame(height: 148).clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous)).overlay(RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(Color.white.opacity(0.18), lineWidth: 1)).shadow(color: .black.opacity(0.10), radius: 24, x: 0, y: 8)
    }
}
#Preview { ProfileGlassCard().environment(AppState()).padding() }
