import SwiftUI

struct ProfileView: View {
    @Environment(AppState.self) var appState
    @State private var showNotes = false
    @State private var showFavs = false
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 16) {
                    if let user = appState.currentUser {
                        GlassCard {
                            VStack(spacing: 12) {
                                ZStack { Circle().fill(Color.edutaraPrimary).frame(width: 72, height: 72); Text(appState.initials(for: user.name)).font(.title2.weight(.bold)).foregroundStyle(.white) }
                                Text(user.name).font(.headline.weight(.bold)).foregroundStyle(Color.edutaraPrimary)
                                Text(user.email).font(.caption).foregroundStyle(.secondary)
                                HStack(spacing: 8) {
                                    Text("\(user.educationLevel) Kelas \(user.grade)").font(.caption.weight(.semibold)).padding(.horizontal, 10).padding(.vertical, 6).background(.ultraThinMaterial, in: Capsule()).overlay(Capsule().stroke(Color.edutaraGlassStroke))
                                    Text(user.favoriteSubject.rawValue).font(.caption2.weight(.bold)).padding(.horizontal, 10).padding(.vertical, 6).background(Color.edutaraSecondary, in: Capsule()).foregroundStyle(.white)
                                }
                            }.frame(maxWidth: .infinity)
                        }
                    }
                    if let s = appState.statsForCurrentUser() {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            statTile("XP", value: "\(s.xp)", icon: "star.fill")
                            statTile("Streak", value: "\(s.streakDays) hari", icon: "flame.fill")
                            statTile("Kuis", value: "\(s.quizzesCompleted)", icon: "checkmark.seal.fill")
                            statTile("Rata-rata", value: String(format: "%.1f", s.averageScore), icon: "chart.bar.fill")
                        }
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Pencapaian").font(.subheadline.weight(.bold)).foregroundStyle(Color.edutaraPrimary)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(appState.achievements) { a in
                                    VStack(spacing: 8) {
                                        ZStack { Circle().fill(a.isUnlocked ? Color.edutaraSecondary.opacity(0.14) : Color.gray.opacity(0.12)).frame(width: 44, height: 44); Image(systemName: a.symbol).foregroundStyle(a.isUnlocked ? Color.edutaraSecondary : .gray) }
                                        Text(a.title).font(.caption2.weight(.semibold)).foregroundStyle(a.isUnlocked ? Color.edutaraPrimary : .secondary).lineLimit(1)
                                        GeometryReader { geo in ZStack(alignment: .leading) { Capsule().fill(Color.black.opacity(0.08)).frame(height: 4); Capsule().fill(Color.edutaraSecondary).frame(width: geo.size.width * a.progress, height: 4) } }.frame(height: 4).frame(width: 80)
                                    }.padding(12).frame(width: 120).glassCard(cornerRadius: 16).opacity(a.isUnlocked ? 1 : 0.6).grayscale(a.isUnlocked ? 0 : 0.4)
                                }
                            }
                        }
                    }
                    GlassCard {
                        VStack(spacing: 14) {
                            VStack(alignment: .leading, spacing: 6) {
                                HStack { Text("Target belajar harian").font(.caption.weight(.semibold)).foregroundStyle(Color.edutaraPrimary); Spacer(); Text("\(Int(appState.dailyGoalMinutes)) min").font(.caption.weight(.bold)).foregroundStyle(Color.edutaraSecondary) }
                                Slider(value: Binding(get: { appState.dailyGoalMinutes }, set: { appState.dailyGoalMinutes = $0 }), in: 10...120, step: 5).tint(Color.edutaraSecondary)
                            }
                            Toggle("Mode gelap", isOn: Binding(get: { appState.isDarkMode }, set: { appState.isDarkMode = $0 })).tint(Color.edutaraSecondary)
                            Toggle("Pengingat belajar", isOn: Binding(get: { appState.isReminderOn }, set: { appState.isReminderOn = $0 })).tint(Color.edutaraSecondary)
                        }
                    }
                    VStack(spacing: 10) {
                        Button { showNotes = true } label: { HStack { Label("Catatanku", systemImage: "note.text"); Spacer(); Image(systemName: "chevron.right").font(.caption2.weight(.bold)).foregroundStyle(.secondary) }.padding(14).glassCard(cornerRadius: 14) }.buttonStyle(.plain)
                        Button { showFavs = true } label: { HStack { Label("Materi Favorit", systemImage: "heart.fill"); Spacer(); Text("\(appState.favoriteMaterialIDs.count)").font(.caption.weight(.bold)).foregroundStyle(Color.edutaraSecondary) }.padding(14).glassCard(cornerRadius: 14) }.buttonStyle(.plain)
                    }
                    Button { appState.currentUser = nil } label: { Text("Keluar").font(.headline.weight(.semibold)).foregroundStyle(.red).frame(maxWidth: .infinity).padding(.vertical, 12).glassCard(cornerRadius: 14) }.buttonStyle(.plain)
                }.padding(16)
            }
        }
        .navigationTitle("Profil").navigationDestination(isPresented: $showNotes) { NotesListView() }.navigationDestination(isPresented: $showFavs) { FavoritesView() }
    }
    func statTile(_ title: String, value: String, icon: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon).foregroundStyle(Color.edutaraSecondary)
            Text(value).font(.headline.weight(.bold)).foregroundStyle(Color.edutaraPrimary)
            Text(title).font(.caption2).foregroundStyle(.secondary)
        }.frame(maxWidth: .infinity).padding(14).glassCard(cornerRadius: 16)
    }
}

struct FavoritesView: View {
    @Environment(AppState.self) var appState
    var favs: [Material] { MockData.materials.filter { appState.favoriteMaterialIDs.contains($0.id) } }
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            if favs.isEmpty { ContentUnavailableView("Belum ada favorit", systemImage: "heart", description: Text("Tap ♥ di detail materi")) }
            else { List { ForEach(favs) { m in NavigationLink(destination: MaterialDetailView(material: m)) { Text(m.title) }.listRowBackground(Color.clear) } }.listStyle(.plain).scrollContentBackground(.hidden) }
        }.navigationTitle("Favorit").navigationBarTitleDisplayMode(.inline)
    }
}
#Preview { NavigationStack { ProfileView().environment(AppState()) } }
