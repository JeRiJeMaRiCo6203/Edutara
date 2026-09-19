import SwiftUI

struct RichTextEditorView: View {
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) var dismiss
    var materialID: UUID? = nil
    var subject: Subject = .matematika
    var editingNote: Note? = nil
    @State private var title = ""
    @State private var attributed = AttributedString("")
    @State private var plainFallback = ""
    @State private var selectedSubject: Subject = .matematika
    @State private var isBold = false
    @State private var isItalic = false
    @State private var isUnderline = false
    var isEditing: Bool { editingNote != nil }
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 16) {
                    GlassCard {
                        VStack(spacing: 12) {
                            TextField("Judul catatan", text: $title).padding(12).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.edutaraGlassStroke))
                            HStack { Text("Mata pelajaran").font(.caption.weight(.semibold)).foregroundStyle(.secondary); Spacer(); Picker("Subject", selection: $selectedSubject) { ForEach(Subject.allCases) { Text($0.rawValue).tag($0) } }.pickerStyle(.menu) }
                            HStack(spacing: 10) {
                                Button { toggleBold() } label: { Image(systemName: "bold").font(.caption.weight(.bold)).padding(8).background(isBold ? Color.edutaraSecondary : Color.clear, in: RoundedRectangle(cornerRadius: 8)).foregroundStyle(isBold ? Color.white : Color.edutaraPrimary) }.buttonStyle(.plain)
                                Button { toggleItalic() } label: { Image(systemName: "italic").font(.caption.weight(.bold)).padding(8).background(isItalic ? Color.edutaraSecondary : Color.clear, in: RoundedRectangle(cornerRadius: 8)).foregroundStyle(isItalic ? Color.white : Color.edutaraPrimary) }.buttonStyle(.plain)
                                Button { toggleUnderline() } label: { Image(systemName: "underline").font(.caption.weight(.bold)).padding(8).background(isUnderline ? Color.edutaraSecondary : Color.clear, in: RoundedRectangle(cornerRadius: 8)).foregroundStyle(isUnderline ? Color.white : Color.edutaraPrimary) }.buttonStyle(.plain)
                                Button { insertBullet() } label: { Image(systemName: "list.bullet").font(.caption.weight(.bold)).padding(8).background(Color.clear, in: RoundedRectangle(cornerRadius: 8)).foregroundStyle(Color.edutaraPrimary) }.buttonStyle(.plain)
                                Spacer()
                            }
                            if #available(iOS 26, *) {
                                TextEditor(text: $attributed).frame(minHeight: 160).padding(8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.edutaraGlassStroke)).scrollContentBackground(.hidden)
                            } else {
                                TextEditor(text: $plainFallback).frame(minHeight: 160).padding(8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.edutaraGlassStroke)).scrollContentBackground(.hidden).onChange(of: plainFallback) { _, v in attributed = AttributedString(v) }
                            }
                            if !plainFallback.isEmpty && !isAt26 {
                                Text(AttributedString(plainFallback)).hidden()
                            }
                            Button { save() } label: { Text(isEditing ? "Simpan Perubahan" : "Simpan Catatan").font(.headline.weight(.semibold)).foregroundStyle(Color.white).frame(maxWidth: .infinity).padding(.vertical, 14).background(title.trimmingCharacters(in: .whitespaces).isEmpty ? Color.gray.opacity(0.4) : Color.edutaraButton, in: RoundedRectangle(cornerRadius: 14)) }.disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                    }
                }.padding(16)
            }
        }
        .navigationTitle(isEditing ? "Edit Catatan" : "Catatan Baru").navigationBarTitleDisplayMode(.inline)
        .toolbar { ToolbarItem(placement: .topBarLeading) { Button("Batal") { dismiss() } } }
        .onAppear {
            if let n = editingNote { title = n.title; attributed = n.body; plainFallback = String(n.body.characters); selectedSubject = n.subject }
            else { selectedSubject = subject; plainFallback = String(attributed.characters) }
        }
        .onChange(of: attributed) { _, v in if !isAt26 { plainFallback = String(v.characters) } }
    }
    var isAt26: Bool { if #available(iOS 26, *) { return true } else { return false } }
    func toggleBold() { isBold.toggle(); applyStyle() }
    func toggleItalic() { isItalic.toggle(); applyStyle() }
    func toggleUnderline() { isUnderline.toggle(); applyStyle() }
    func applyStyle() {
        var a = attributed
        if isBold { a.inlinePresentationIntent = .stronglyEmphasized }
        if isItalic { a.inlinePresentationIntent = .emphasized }
        if isUnderline { a.underlineStyle = .single }
        attributed = a
        plainFallback = String(a.characters)
    }
    func insertBullet() {
        let bullet = "\n- "
        attributed += AttributedString(bullet)
        plainFallback += bullet
    }
    func save() {
        let t = title.trimmingCharacters(in: .whitespaces)
        guard !t.isEmpty else { return }
        let bodyToSave: AttributedString = isAt26 ? attributed : AttributedString(plainFallback)
        var finalBody = bodyToSave
        if isBold { finalBody.inlinePresentationIntent = .stronglyEmphasized }
        if isItalic { finalBody.inlinePresentationIntent = .emphasized }
        if isUnderline { finalBody.underlineStyle = .single }
        if let n = editingNote, let idx = appState.notes.firstIndex(where: { $0.id == n.id }) {
            appState.notes[idx].title = t; appState.notes[idx].body = finalBody; appState.notes[idx].updatedAt = Date(); appState.notes[idx].subject = selectedSubject
        } else {
            appState.notes.insert(Note(materialID: materialID, title: t, body: finalBody, updatedAt: Date(), subject: selectedSubject), at: 0)
        }
        dismiss()
    }
}
#Preview { NavigationStack { RichTextEditorView().environment(AppState()) } }
