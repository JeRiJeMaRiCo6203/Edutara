import SwiftUI

struct QuizPlayView: View {
    var quiz: Quiz
    var count: Int
    var showExplanation: Bool
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) var dismiss
    @State private var idx = 0
    @State private var selected: Int? = nil
    @State private var revealed = false
    @State private var correct = 0
    @State private var showResult = false
    var questions: [QuizQuestion] { Array(quiz.questions.prefix(count)) }
    var progress: Double { Double(idx) / Double(max(count,1)) }
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            VStack(spacing: 16) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color.edutaraSecondary.opacity(0.18)).frame(height: 6)
                        Capsule().fill(Color.edutaraSecondary).frame(width: geo.size.width * progress, height: 6).shadow(color: Color.edutaraSecondary.opacity(0.4), radius: 8)
                    }
                }.frame(height: 6).padding(.horizontal, 16).padding(.top, 8)
                Text("Soal \(idx+1) dari \(count)").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                if idx < questions.count {
                    let q = questions[idx]
                    ScrollView {
                        VStack(spacing: 14) {
                            Text(q.text).font(.headline.weight(.semibold)).foregroundStyle(Color.edutaraPrimary).frame(maxWidth: .infinity, alignment: .leading).padding(14).glassCard(cornerRadius: 16)
                            ForEach(Array(q.options.enumerated()), id: \.offset) { i, opt in
                                Button {
                                    if !revealed { selected = i }
                                } label: {
                                    HStack {
                                        ZStack { Circle().stroke(borderColor(i, q: q), lineWidth: 2).frame(width: 28, height: 28); if selected==i { Circle().fill(borderColor(i,q:q)).frame(width: 16, height: 16) } }
                                        Text(opt).font(.subheadline.weight(.medium)).foregroundStyle(Color.edutaraPrimary).multilineTextAlignment(.leading)
                                        Spacer()
                                        if revealed {
                                            if i==q.correctIndex { Image(systemName: "checkmark.circle.fill").foregroundStyle(Color.edutaraSuccess) }
                                            else if i==selected { Image(systemName: "xmark.circle.fill").foregroundStyle(.red) }
                                        }
                                    }.padding(14).background(bgColor(i,q:q), in: RoundedRectangle(cornerRadius: 14)).overlay(RoundedRectangle(cornerRadius: 14).stroke(borderColor(i,q:q), lineWidth: 1.5))
                                }.buttonStyle(.plain).disabled(revealed)
                            }
                            if revealed && showExplanation {
                                GlassCard(cornerRadius: 14) {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Label(selected == q.correctIndex ? "Benar!" : "Salah", systemImage: selected == q.correctIndex ? "checkmark.seal.fill" : "exclamationmark.triangle.fill").font(.caption.weight(.bold)).foregroundStyle(selected == q.correctIndex ? Color.edutaraSuccess : .red)
                                        Text(q.explanation).font(.caption).foregroundStyle(.secondary)
                                    }.frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }.padding(16)
                    }
                    Button {
                        if !revealed {
                            guard selected != nil else { return }
                            revealed = true
                            if selected == q.correctIndex { correct += 1 }
                        } else {
                            if idx+1 < count { idx += 1; selected = nil; revealed = false } else { showResult = true }
                        }
                    } label: {
                        Text(revealed ? (idx+1 < count ? "Lanjut" : "Lihat Hasil") : "Jawab").font(.headline.weight(.semibold)).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 14).background((selected==nil && !revealed) ? Color.gray.opacity(0.4) : Color.edutaraButton, in: RoundedRectangle(cornerRadius: 14)).padding(.horizontal, 16)
                    }.disabled(!revealed && selected==nil).padding(.bottom, 16)
                }
            }
        }
        .navigationTitle(quiz.title).navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(true)
        .toolbar { ToolbarItem(placement: .topBarLeading) { Button("Batal") { dismiss() } } }
        .navigationDestination(isPresented: $showResult) { QuizResultView(quiz: quiz, correct: correct, total: count) }
    }
    func borderColor(_ i: Int, q: QuizQuestion) -> Color {
        if !revealed { return selected==i ? Color.edutaraSecondary : Color.edutaraGlassStroke }
        if i==q.correctIndex { return Color.edutaraSuccess }
        if i==selected { return .red }
        return Color.edutaraGlassStroke
    }
    func bgColor(_ i: Int, q: QuizQuestion) -> Color {
        if !revealed { return selected==i ? Color.edutaraSecondary.opacity(0.10) : Color.white.opacity(0.0) }
        if i==q.correctIndex { return Color.edutaraSuccess.opacity(0.12) }
        if i==selected { return Color.red.opacity(0.10) }
        return Color.white.opacity(0.0)
    }
}
#Preview { NavigationStack { QuizPlayView(quiz: MockData.quizPecahan, count: 5, showExplanation: true).environment(AppState()) } }
