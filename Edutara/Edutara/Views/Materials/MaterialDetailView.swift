import SwiftUI

struct MaterialDetailView: View {
    @Environment(AppState.self) var appState
    var material: Material
    @State private var showNoteEditor = false
    var relatedQuiz: Quiz? { MockData.quizzes.first(where: { $0.materialID == material.id }) }
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack {
                        Circle().fill(Color.edutaraSecondary.opacity(0.14)).frame(width: 72, height: 72)
                        Image(systemName: material.subject.symbol).font(.title).foregroundStyle(Color.edutaraSecondary)
                    }.frame(maxWidth: .infinity).padding(.top, 8)
                    Text(material.title).font(.system(size: 22, weight: .bold, design: .rounded)).foregroundStyle(Color.edutaraPrimary).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
                    HStack(spacing: 8) {
                        Text(material.subject.rawValue).font(.caption.weight(.semibold)).padding(.horizontal, 10).padding(.vertical, 6).background(.ultraThinMaterial, in: Capsule()).overlay(Capsule().stroke(Color.edutaraGlassStroke))
                        DifficultyPill(difficulty: material.difficulty)
                        Label("\(material.estimatedMinutes) min", systemImage: "clock").font(.caption.weight(.medium)).foregroundStyle(.secondary)
                        Spacer()
                        if material.isPremium { Label("Premium", systemImage: "crown.fill").font(.caption2.weight(.bold)).padding(.horizontal, 8).padding(.vertical, 4).background(Color.edutaraSecondary, in: Capsule()).foregroundStyle(.white) }
                    }
                    GlassCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Ringkasan").font(.subheadline.weight(.bold)).foregroundStyle(Color.edutaraPrimary)
                            Text(material.summary).font(.subheadline).foregroundStyle(.secondary)
                            Divider().opacity(0.2)
                            Text(material.content).font(.subheadline).foregroundStyle(Color.edutaraPrimary).lineSpacing(4)
                        }
                    }
                    if let q = relatedQuiz {
                        NavigationLink(destination: QuizSetupView(quiz: q)) {
                            HStack { Image(systemName: "pencil.and.ruler.fill").foregroundStyle(.white); Text("Mulai Kuis Terkait: \(q.title)").font(.subheadline.weight(.semibold)).foregroundStyle(.white); Spacer(); Image(systemName: "chevron.right").foregroundStyle(.white.opacity(0.8)) }
                            .padding(14).background(Color.edutaraButton, in: RoundedRectangle(cornerRadius: 16))
                        }.buttonStyle(.plain)
                    }
                    Button { showNoteEditor = true } label: {
                        HStack { Image(systemName: "note.text.badge.plus"); Text("Buat catatan") }.font(.subheadline.weight(.semibold)).foregroundStyle(Color.edutaraPrimary).frame(maxWidth: .infinity).padding(.vertical, 12).glassCard(cornerRadius: 14)
                    }.buttonStyle(.plain)
                    Spacer(minLength: 80)
                }.padding(16)
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { withAnimation(.spring()) { appState.toggleFavorite(material.id) } } label: {
                    Image(systemName: appState.favoriteMaterialIDs.contains(material.id) ? "heart.fill" : "heart").foregroundStyle(appState.favoriteMaterialIDs.contains(material.id) ? Color.edutaraSecondary : .secondary)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Toggle(isOn: Binding(get: { appState.favoriteMaterialIDs.contains(material.id) }, set: { _ in appState.toggleFavorite(material.id) })) { Text("Fav") }.labelsHidden().tint(Color.edutaraSecondary)
            }
        }
        .sheet(isPresented: $showNoteEditor) { NavigationStack { RichTextEditorView(materialID: material.id, subject: material.subject) } }
        .safeAreaInset(edge: .bottom) {
            if let q = relatedQuiz {
                NavigationLink(destination: QuizSetupView(quiz: q)) {
                    Text("Mulai Kuis Terkait").font(.headline.weight(.semibold)).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 14).background(Color.edutaraButton, in: RoundedRectangle(cornerRadius: 14)).padding(.horizontal, 16).padding(.vertical, 10).background(.ultraThinMaterial)
                }.buttonStyle(.plain)
            }
        }
    }
}
#Preview {
    NavigationStack {
        MaterialDetailView(material: MockData.turunanFungsi).environment(AppState())
    }
}
