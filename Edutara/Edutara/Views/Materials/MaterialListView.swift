import SwiftUI

struct MaterialListView: View {
    @Environment(AppState.self) var appState
    @State private var search = ""
    @State private var selectedSubject: Subject? = nil
    @State private var onlyFav = false
    @State private var levelFilter = "All"
    @State private var sort: SortOpt = .title
    enum SortOpt: String, CaseIterable { case title = "Judul A-Z", duration = "Durasi", difficulty = "Tingkat kesulitan" }
    var filtered: [Material] {
        var r = MockData.materials
        if !search.isEmpty { r = r.filter { $0.title.localizedCaseInsensitiveContains(search) || $0.summary.localizedCaseInsensitiveContains(search) } }
        if let s = selectedSubject { r = r.filter { $0.subject == s } }
        if onlyFav { r = r.filter { appState.favoriteMaterialIDs.contains($0.id) } }
        if levelFilter != "All" { r = r.filter { $0.educationLevel == levelFilter } }
        switch sort {
        case .title: r.sort { $0.title < $1.title }
        case .duration: r.sort { $0.estimatedMinutes < $1.estimatedMinutes }
        case .difficulty: r.sort { $0.difficulty.sortOrder < $1.difficulty.sortOrder }
        }
        return r
    }
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        chip("All", selected: levelFilter=="All") { levelFilter="All" }
                        ForEach(["SD","SMP","SMA"], id: \.self) { lv in chip(lv, selected: levelFilter==lv) { levelFilter=lv } }
                    }.padding(.horizontal, 16).padding(.vertical, 8)
                }
                if filtered.isEmpty {
                    ContentUnavailableView("Tidak ada materi", systemImage: "books.vertical", description: Text("Coba ubah filter atau pencarian."))
                } else {
                    List {
                        ForEach(filtered) { m in
                            NavigationLink(value: m) { MaterialRow(material: m) }.listRowBackground(Color.clear).listRowSeparator(.hidden).listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                        }
                    }.listStyle(.plain).scrollContentBackground(.hidden)
                }
            }
        }
        .navigationTitle("Materi")
        .searchable(text: $search, prompt: "Cari materi...")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Picker("Subject", selection: $selectedSubject) {
                        Text("Semua").tag(Optional<Subject>(nil))
                        ForEach(Subject.allCases) { Text($0.rawValue).tag(Optional($0)) }
                    }
                    Toggle("Hanya favorit", isOn: $onlyFav)
                    Picker("Urutkan", selection: $sort) { ForEach(SortOpt.allCases, id: \.self) { Text($0.rawValue).tag($0) } }
                } label: { Image(systemName: "line.3.horizontal.decrease.circle") }
            }
        }
        .navigationDestination(for: Material.self) { m in MaterialDetailView(material: m) }
    }
    func chip(_ title: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title).font(.caption.weight(.semibold)).padding(.horizontal, 14).padding(.vertical, 8)
                .foregroundStyle(selected ? .white : .edutaraPrimary)
                .background(selected ? AnyShapeStyle(Color.edutaraSecondary) : AnyShapeStyle(.ultraThinMaterial), in: Capsule())
                .overlay(Capsule().stroke(selected ? Color.edutaraSecondary : Color.edutaraGlassStroke, lineWidth: 1))
        }.buttonStyle(.plain)
    }
}

struct MaterialRow: View {
    @Environment(AppState.self) var appState
    var material: Material
    var body: some View {
        HStack(spacing: 12) {
            Circle().fill(material.subject.displayColor).frame(width: 10, height: 10)
            VStack(alignment: .leading, spacing: 4) {
                Text(material.title).font(.subheadline.weight(.semibold)).foregroundStyle(Color.edutaraPrimary).lineLimit(1)
                Text("\(material.subject.rawValue) â€¢ \(material.educationLevel) \(material.grade) â€¢ \(material.estimatedMinutes) min").font(.caption2).foregroundStyle(.secondary)
                HStack(spacing: 6) { DifficultyPill(difficulty: material.difficulty); if material.isPremium { Label("Premium", systemImage: "crown.fill").font(.caption2.weight(.bold)).foregroundStyle(Color.edutaraSecondary) } }
            }
            Spacer()
            Image(systemName: appState.favoriteMaterialIDs.contains(material.id) ? "heart.fill" : "heart").foregroundStyle(appState.favoriteMaterialIDs.contains(material.id) ? Color.edutaraSecondary : .secondary)
        }.padding(14).glassCard(cornerRadius: 16)
    }
}
#Preview { NavigationStack { MaterialListView().environment(AppState()) } }

