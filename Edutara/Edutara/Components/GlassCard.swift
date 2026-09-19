import SwiftUI

struct GlassCard<Content: View>: View {
    var cornerRadius: CGFloat = 20
    var content: Content
    init(cornerRadius: CGFloat = 20, @ViewBuilder content: () -> Content) { self.cornerRadius = cornerRadius; self.content = content() }
    var body: some View {
        content
            .padding(16)
            .glassCard(cornerRadius: cornerRadius)
    }
}

struct GlassRow<Content: View>: View {
    var content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        content
            .padding(14)
            .glassCard(cornerRadius: 16)
    }
}

struct HeroMasterCard: View {
    var title: String
    var subtitle: String
    var progress: Double
    var isPremium: Bool
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 24, style: .continuous).fill(Theme.heroGradient).frame(height: 168)
            LinearGradient(colors: [Color.edutaraPrimary.opacity(0.12), .clear], startPoint: .topLeading, endPoint: .bottomTrailing).clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous)).allowsHitTesting(false)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    if isPremium { Label("Premium", systemImage: "crown.fill").font(.caption2.weight(.bold)).padding(.horizontal, 8).padding(.vertical, 4).background(Color.edutaraSecondary, in: Capsule()).foregroundStyle(.white) }
                    Spacer()
                    Image(systemName: "play.circle.fill").foregroundStyle(.white.opacity(0.9)).font(.title3)
                }
                Text(title).font(.system(size: 20, weight: .bold, design: .rounded)).foregroundStyle(.white).lineLimit(2)
                Text(subtitle).font(.caption.weight(.medium)).foregroundStyle(.white.opacity(0.85)).lineLimit(1)
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(.white.opacity(0.22)).frame(height: 6)
                        Capsule().fill(Color.edutaraSecondary).frame(width: geo.size.width * progress, height: 6).shadow(color: Color.edutaraSecondary.opacity(0.4), radius: 8, x: 0, y: 0)
                    }
                }.frame(height: 6)
            }.padding(16)
        }.glassCard(cornerRadius: 24)
    }
}
#Preview { HeroMasterCard(title: "Turunan Fungsi", subtitle: "SMA 11 â€¢ Lanjut", progress: 0.6, isPremium: true).padding() }

