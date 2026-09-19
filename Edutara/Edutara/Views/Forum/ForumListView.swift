import SwiftUI

struct ForumListView: View {
    @Environment(AppState.self) var appState
    @State private var search = ""
    @State private var filterSubject: Subject? = nil
    @State private var showNew = false
    var filtered: [Discussion] {
        var r = appState.discussions
        if let s = filterSubject { r = r.filter { $0.subject == s } }
        if !search.isEmpty { r = r.filter { $0.title.localizedCaseInsensitiveContains(search) || $0.body.localizedCaseInsensitiveContains(search) } }
        return r.sorted { $0.createdAt > $1.createdAt }
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
                    ContentUnavailableView("Tidak ada diskusi", systemImage: "bubble.leftAndBubbleRight", description: Text("Coba ubah filter atau buat diskusi baru."))
                } else {
                    List {
                        ForEach(filtered) { d in
                            NavigationLink(destination: DiscussionDetailView(discussionID: d.id)) { ForumRow(discussion: d) }.listRowBackground(Color.clear).listRowSeparator(.hidden).listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                        }
                    }.listStyle(.plain).scrollContentBackground(.hidden)
                }
            }
        }
        .navigationTitle("Forum")
        .searchable(text: $search, prompt: "Cari diskusi...")
        .toolbar { ToolbarItem(placement: .topBarTrailing) { Button { showNew = true } label: { Label("Baru", systemImage: "square.and.pencil.circle.fill").foregroundStyle(Color.edutaraSecondary) } } }
        .sheet(isPresented: $showNew) { NavigationStack { NewDiscussionView() } }
    }
}

struct ForumRow: View {
    @Environment(AppState.self) var appState
    var discussion: Discussion
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle().fill(Color.edutaraPrimary.opacity(0.08)).frame(width: 28, height: 28).overlay { Text(appState.initials(for: appState.user(for: discussion.authorID)?.name ?? "?")).font(.caption2.weight(.bold)).foregroundStyle(Color.edutaraPrimary) }
                Text(appState.user(for: discussion.authorID)?.name ?? "-").font(.caption.weight(.semibold)).foregroundStyle(Color.edutaraPrimary)
                Spacer()
                Text(Helpers.relativeString(from: discussion.createdAt)).font(.caption2).foregroundStyle(.secondary)
            }
            Text(discussion.title).font(.subheadline.weight(.semibold)).foregroundStyle(Color.edutaraPrimary).lineLimit(2)
            Text(discussion.body).font(.caption).foregroundStyle(.secondary).lineLimit(2)
            HStack(spacing: 10) {
                Label("\(discussion.replies.count) balasan", systemImage: "bubble.left.fill").font(.caption2.weight(.medium)).foregroundStyle(Color.edutaraPrimary)
                Label("\(discussion.likes)", systemImage: "heart.fill").font(.caption2.weight(.medium)).foregroundStyle(Color.edutaraSecondary)
                Spacer()
                Text(discussion.subject.rawValue).font(.caption2.weight(.bold)).padding(.horizontal, 8).padding(.vertical, 4).background(Color.edutaraSecondary.opacity(0.14), in: Capsule()).foregroundStyle(Color.edutaraSecondary)
            }
        }.padding(14).glassCard(cornerRadius: 16)
    }
}
#Preview { NavigationStack { ForumListView().environment(AppState()) } }
