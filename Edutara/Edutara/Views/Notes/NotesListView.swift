import SwiftUI

struct NotesListView: View {
    @Environment(AppState.self) var appState
    @State private var search = ""
    @State private var filterSubject: Subject? = nil
    @State private var showEditor = false
    @State private var editingNote: Note? = nil
    var filtered: [Note] {
        var r = appState.notes.sorted { $0.updatedAt > $1.updatedAt }
        if let s = filterSubject { r = r.filter { $0.subject == s } }
        if !search.isEmpty { r = r.filter { $0.title.localizedCaseInsensitiveContains(search) || String($0.body.characters).localizedCaseInsensitiveContains(search) } }
        return r
    }
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        Button { filterSubject=nil } label: { Text("Semua").font(.caption.weight(.semibold)).padding(.horizontal, 14).padding(.vertical, 8).foregroundStyle(filterSubject==nil ? .white : .edutaraPrimary).background(filterSubject==nil ? AnyShapeStyle(Color.edutaraSecondary) : AnyShapeStyle(.ultraThinMaterial), in: Capsule()).overlay(Capsule().stroke(filterSubject==nil ? Color.edutaraSecondary : Color.edutaraGlassStroke, lineWidth: 1)) }.buttonStyle(.plain)
                        ForEach(Subject.allCases) { s in Button { filterSubject=s } label: { Text(s.rawValue).font(.caption.weight(.semibold)).padding(.horizontal, 14).padding(.vertical, 8).foregroundStyle(filterSubject==s ? .white : .edutaraPrimary).background(filterSubject==s ? AnyShapeStyle(Color.edutaraSecondary) : AnyShapeStyle(.ultraThinMaterial), in: Capsule()).overlay(Capsule().stroke(filterSubject==s ? Color.edutaraSecondary : Color.edutaraGlassStroke, lineWidth: 1)) }.buttonStyle(.plain) }
                    }.padding(.horizontal, 16).padding(.vertical, 8)
                }
                if filtered.isEmpty {
                    ContentUnavailableView("Belum ada catatan", systemImage: "note.text", description: Text("Buat catatan baru dari materi atau tombol +"))
                } else {
                    List {
                        ForEach(filtered) { n in
                            Button { editingNote = n; showEditor = true } label: { NoteRow(note: n) }.listRowBackground(Color.clear).listRowSeparator(.hidden).listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)).swipeActions(edge: .trailing, allowsFullSwipe: true) { Button(role: .destructive) { if let idx = appState.notes.firstIndex(where: { $0.id == n.id }) { appState.notes.remove(at: idx) } } label: { Label("Hapus", systemImage: "trash") } }
                        }
                    }.listStyle(.plain).scrollContentBackground(.hidden)
                }
            }
        }
        .navigationTitle("Catatan")
        .searchable(text: $search, prompt: "Cari catatan...")
        .toolbar { ToolbarItem(placement: .topBarTrailing) { Button { editingNote=nil; showEditor=true } label: { Image(systemName: "plus") } } }
        .sheet(isPresented: $showEditor) { NavigationStack { RichTextEditorView(editingNote: editingNote) } }
    }
}

struct NoteRow: View {
    var note: Note
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack { Text(note.title).font(.subheadline.weight(.semibold)).foregroundStyle(Color.edutaraPrimary).lineLimit(1); Spacer(); Text(note.subject.rawValue).font(.caption2.weight(.bold)).padding(.horizontal, 8).padding(.vertical, 4).background(Color.edutaraSecondary.opacity(0.14), in: Capsule()).foregroundStyle(Color.edutaraSecondary) }
            Text(String(note.body.characters)).font(.caption).foregroundStyle(.secondary).lineLimit(2)
            Text(Helpers.dateString(note.updatedAt)).font(.caption2).foregroundStyle(.secondary)
        }.padding(14).glassCard(cornerRadius: 16)
    }
}
#Preview { NavigationStack { NotesListView().environment(AppState()) } }
