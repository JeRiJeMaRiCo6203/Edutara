import SwiftUI

struct QuizResultView: View {
    var quiz: Quiz
    var correct: Int
    var total: Int
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) var dismiss
    var pct: Double { Double(correct)/Double(max(total,1)) }
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            VStack(spacing: 20) {
                ProgressRing(progress: pct).frame(width: 120, height: 120)
                Text("\(correct) / \(total) Benar").font(.system(size: 22, weight: .bold, design: .rounded)).foregroundStyle(Color.edutaraPrimary)
                Text("Skor \(Int(pct*100))%").font(.headline).foregroundStyle(.secondary)
                Text("XP +\(correct*10)").font(.subheadline.weight(.bold)).padding(.horizontal, 14).padding(.vertical, 8).background(Color.edutaraSecondary, in: Capsule()).foregroundStyle(.white)
                GlassCard {
                    VStack(spacing: 8) {
                        Text(quiz.title).font(.subheadline.weight(.semibold)).foregroundStyle(Color.edutaraPrimary)
                        Text(pct>=0.8 ? "Luar biasa! Pertahankan streak-mu 🔥" : pct>=0.5 ? "Bagus, terus latihan!" : "Jangan menyerah, coba lagi!").font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
                    }
                }
                HStack(spacing: 12) {
                    Button("Ulangi") { dismiss() }.font(.subheadline.weight(.semibold)).foregroundStyle(Color.edutaraPrimary).frame(maxWidth: .infinity).padding(.vertical, 12).glassCard(cornerRadius: 12)
                    NavigationLink(destination: QuizListView()) { Text("Kembali ke Daftar").font(.subheadline.weight(.semibold)).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 12).background(Color.edutaraButton, in: RoundedRectangle(cornerRadius: 12)) }.buttonStyle(.plain)
                }
            }.padding(20)
        }
        .navigationTitle("Hasil").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(true)
        .onAppear { appState.updateStatsAfterQuiz(correct: correct, total: total) }
    }
}
#Preview { NavigationStack { QuizResultView(quiz: MockData.quizPecahan, correct: 4, total: 5).environment(AppState()) } }
