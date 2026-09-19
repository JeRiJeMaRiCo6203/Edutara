import SwiftUI

struct ContinueLearningRow: View {
    @Environment(AppState.self) var appState
    var items: [Material] {
        let nonPremium = MockData.materials.filter { !$0.isPremium }
        return Array(nonPremium.prefix(3))
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Lanjutkan Belajar").font(.system(size: 17, weight: .semibold, design: .rounded)).foregroundStyle(Color.edutaraPrimary)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { m in
                        NavigationLink(value: m) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: m.subject.symbol).font(.title3).foregroundStyle(Color.edutaraSecondary)
                                    Spacer()
                                    Text(m.subject.rawValue).font(.caption2.weight(.bold)).padding(.horizontal, 8).padding(.vertical, 4).background(Color.edutaraSecondary.opacity(0.14), in: Capsule()).foregroundStyle(Color.edutaraSecondary)
                                }
                                Text(m.title).font(.subheadline.weight(.semibold)).foregroundStyle(Color.edutaraPrimary).lineLimit(2)
                                Text("\(m.educationLevel) \(m.grade) • \(m.estimatedMinutes) min").font(.caption2).foregroundStyle(.secondary)
                                GeometryReader { geo in
                                    let p: Double = m.difficulty == .beginner ? 0.7 : m.difficulty == .intermediate ? 0.45 : 0.25
                                    ZStack(alignment: .leading) {
                                        Capsule().fill(Color.edutaraSecondary.opacity(0.18)).frame(height: 6)
                                        Capsule().fill(Color.edutaraSecondary).frame(width: geo.size.width * p, height: 6).shadow(color: Color.edutaraSecondary.opacity(0.4), radius: 8)
                                    }
                                }.frame(height: 6)
                            }.padding(14).frame(width: 200, height: 140).glassCard(cornerRadius: 20)
                        }.buttonStyle(.plain)
                    }
                }.scrollTargetLayout()
            }.scrollTargetBehavior(.viewAligned).navigationDestination(for: Material.self) { m in MaterialDetailView(material: m) }
        }
    }
}
#Preview { ContinueLearningRow().environment(AppState()).padding() }
