import SwiftUI

struct NewDiscussionView: View {
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var bodyText = ""
    @State private var subject: Subject = .matematika
    var isValid: Bool { title.trimmingCharacters(in: .whitespaces).count >= 5 && bodyText.trimmingCharacters(in: .whitespaces).count >= 10 }
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 16) {
                    GlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            TextField("Judul (min 5 karakter)", text: $title).padding(12).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.edutaraGlassStroke))
                            TextEditor(text: $bodyText).frame(minHeight: 120).padding(8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.edutaraGlassStroke)).scrollContentBackground(.hidden)
                            Text("Isi minimal 10 karakter").font(.caption2).foregroundStyle(.secondary)
                            HStack { Text("Mata pelajaran").font(.caption.weight(.semibold)).foregroundStyle(.secondary); Spacer(); Picker("Subject", selection: $subject) { ForEach(Subject.allCases) { Text($0.rawValue).tag($0) } }.pickerStyle(.menu).tint(Color.edutaraPrimary) }
                            Button { submit() } label: { Text("Kirim Diskusi").font(.headline.weight(.semibold)).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 14).background(isValid ? Color.edutaraButton : Color.gray.opacity(0.4), in: RoundedRectangle(cornerRadius: 14)) }.disabled(!isValid)
                        }
                    }
                }.padding(16)
            }
        }.navigationTitle("Diskusi Baru").navigationBarTitleDisplayMode(.inline).toolbar { ToolbarItem(placement: .topBarLeading) { Button("Batal") { dismiss() } } }
    }
    func submit() {
        guard let uid = appState.currentUser?.id else { return }
        appState.discussions.insert(Discussion(authorID: uid, title: title.trimmingCharacters(in: .whitespaces), body: bodyText.trimmingCharacters(in: .whitespaces), subject: subject, createdAt: Date(), replies: [], likes: 0), at: 0)
        dismiss()
    }
}
#Preview { NavigationStack { NewDiscussionView().environment(AppState()) } }
