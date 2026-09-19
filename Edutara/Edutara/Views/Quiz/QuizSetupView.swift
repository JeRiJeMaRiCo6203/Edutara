import SwiftUI

struct QuizSetupView: View {
    var quiz: Quiz
    @State private var count: Double = 5
    @State private var showExplanation = true
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 16) {
                    GlassCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(quiz.title).font(.headline.weight(.bold)).foregroundStyle(Color.edutaraPrimary)
                            Text("\(quiz.subject.rawValue) • \(quiz.questions.count) soal tersedia").font(.caption).foregroundStyle(.secondary)
                            if let mid = quiz.materialID, let m = MockData.materials.first(where: { $0.id == mid }) { DifficultyPill(difficulty: m.difficulty) }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                    GlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack { Text("Jumlah soal").font(.subheadline.weight(.semibold)); Spacer(); Text("\(Int(count))").font(.subheadline.weight(.bold)).foregroundStyle(Color.edutaraSecondary) }
                            Slider(value: $count, in: 3...Double(quiz.questions.count), step: 1).tint(Color.edutaraSecondary)
                            HStack { Text("3"); Spacer(); Text("\(quiz.questions.count)") }.font(.caption2).foregroundStyle(.secondary)
                            Toggle("Tampilkan penjelasan", isOn: $showExplanation).tint(Color.edutaraSecondary)
                        }
                    }
                    NavigationLink(destination: QuizPlayView(quiz: quiz, count: Int(count), showExplanation: showExplanation)) {
                        Text("Mulai Kuis").font(.headline.weight(.semibold)).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 14).background(Color.edutaraButton, in: RoundedRectangle(cornerRadius: 14))
                    }.buttonStyle(.plain)
                }.padding(16)
            }
        }.navigationTitle("Persiapan").navigationBarTitleDisplayMode(.inline)
    }
}
#Preview { NavigationStack { QuizSetupView(quiz: MockData.quizPecahan) } }
