import SwiftUI

struct DiscussionDetailView: View {
    @Environment(AppState.self) var appState
    var discussionID: UUID
    @State private var replyText = ""
    var discussion: Discussion? { appState.discussions.first(where: { $0.id == discussionID }) }
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            if let d = discussion {
                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        GlassCard {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack(spacing: 10) {
                                    ZStack { Circle().fill(Color.edutaraPrimary).frame(width: 36, height: 36); Text(appState.initials(for: appState.user(for: d.authorID)?.name ?? "?")).font(.caption.weight(.bold)).foregroundStyle(.white) }
                                    VStack(alignment: .leading, spacing: 2) { Text(appState.user(for: d.authorID)?.name ?? "-").font(.subheadline.weight(.semibold)).foregroundStyle(Color.edutaraPrimary); Text(Helpers.relativeString(from: d.createdAt)).font(.caption2).foregroundStyle(.secondary) }
                                    Spacer()
                                    Button { likeDiscussion() } label: { Label("\(d.likes)", systemImage: "heart.fill").font(.caption.weight(.bold)).foregroundStyle(Color.edutaraSecondary) }.buttonStyle(.plain)
                                }
                                Text(d.title).font(.headline.weight(.bold)).foregroundStyle(Color.edutaraPrimary)
                                Text(d.body).font(.subheadline).foregroundStyle(.secondary)
                                Text(d.subject.rawValue).font(.caption2.weight(.bold)).padding(.horizontal, 8).padding(.vertical, 4).background(Color.edutaraSecondary.opacity(0.14), in: Capsule()).foregroundStyle(Color.edutaraSecondary)
                            }
                        }
                        Text("Balasan (\(d.replies.count))").font(.subheadline.weight(.bold)).foregroundStyle(Color.edutaraPrimary).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 4)
                        ForEach(d.replies) { r in
                            HStack(alignment: .top, spacing: 10) {
                                ZStack { Circle().fill(Color.edutaraSecondary.opacity(0.18)).frame(width: 28, height: 28); Text(appState.initials(for: appState.user(for: r.authorID)?.name ?? "?")).font(.caption2.weight(.bold)).foregroundStyle(Color.edutaraPrimary) }
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack { Text(appState.user(for: r.authorID)?.name ?? "-").font(.caption.weight(.semibold)).foregroundStyle(Color.edutaraPrimary); Spacer(); Text(Helpers.relativeString(from: r.createdAt)).font(.caption2).foregroundStyle(.secondary) }
                                    Text(r.body).font(.caption).foregroundStyle(.secondary)
                                    Label("\(r.likes)", systemImage: "heart.fill").font(.caption2).foregroundStyle(Color.edutaraSecondary)
                                }
                                Spacer()
                            }.padding(12).glassCard(cornerRadius: 14)
                        }
                    }.padding(16).padding(.bottom, 80)
                }
                VStack {
                    Spacer()
                    HStack(spacing: 10) {
                        TextField("Tulis balasan...", text: $replyText).padding(.horizontal, 14).padding(.vertical, 10).background(.ultraThinMaterial, in: Capsule()).overlay(Capsule().stroke(Color.edutaraGlassStroke))
                        Button { sendReply() } label: { Image(systemName: "paperplane.fill").foregroundStyle(.white).padding(10).background(replyText.trimmingCharacters(in: .whitespaces).isEmpty ? Color.gray.opacity(0.4) : Color.edutaraButton, in: Circle()) }.disabled(replyText.trimmingCharacters(in: .whitespaces).isEmpty)
                    }.padding(.horizontal, 16).padding(.vertical, 10).background(.ultraThinMaterial)
                }
            } else { ContentUnavailableView("Diskusi tidak ditemukan", systemImage: "exclamationmark.bubble") }
        }.navigationTitle("Diskusi").navigationBarTitleDisplayMode(.inline)
    }
    func likeDiscussion() {
        guard let idx = appState.discussions.firstIndex(where: { $0.id == discussionID }) else { return }
        appState.discussions[idx].likes += 1
    }
    func sendReply() {
        guard let uid = appState.currentUser?.id, let idx = appState.discussions.firstIndex(where: { $0.id == discussionID }) else { return }
        let t = replyText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !t.isEmpty else { return }
        appState.discussions[idx].replies.append(Reply(authorID: uid, body: t, createdAt: Date(), likes: 0))
        replyText = ""
    }
}
#Preview { NavigationStack { DiscussionDetailView(discussionID: MockData.discussions[0].id).environment(AppState()) } }
