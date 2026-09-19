import SwiftUI

struct QuizListView: View {
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            List {
                ForEach(Subject.allCases) { subj in
                    let qs = MockData.quizzes.filter { $0.subject == subj }
                    if !qs.isEmpty {
                        Section {
                            ForEach(qs) { q in NavigationLink(destination: QuizSetupView(quiz: q)) { QuizRow(quiz: q) }.listRowBackground(Color.clear).listRowSeparator(.hidden).listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0)) }
                        } header: { Text(subj.rawValue).font(.caption.weight(.bold)).foregroundStyle(.secondary) }
                    }
                }
            }.listStyle(.insetGrouped).scrollContentBackground(.hidden)
        }.navigationTitle("Kuis")
    }
}
struct QuizRow: View {
    var quiz: Quiz
    var linkedTitle: String? { MockData.materials.first(where: { $0.id == quiz.materialID })?.title }
    var body: some View {
        HStack(spacing: 12) {
            ZStack { RoundedRectangle(cornerRadius: 12).fill(Color.edutaraSecondary.opacity(0.14)).frame(width: 44, height: 44); Image(systemName: quiz.subject.symbol).foregroundStyle(Color.edutaraSecondary) }
            VStack(alignment: .leading, spacing: 3) {
                Text(quiz.title).font(.subheadline.weight(.semibold)).foregroundStyle(Color.edutaraPrimary)
                Text("\(quiz.subject.rawValue) • \(quiz.questions.count) soal" + (linkedTitle.map { " • \($0)" } ?? "")).font(.caption2).foregroundStyle(.secondary).lineLimit(1)
            }
            Spacer(); Image(systemName: "chevron.right").font(.caption2.weight(.bold)).foregroundStyle(.secondary)
        }.padding(12).glassCard(cornerRadius: 16)
    }
}
#Preview { NavigationStack { QuizListView() } }
