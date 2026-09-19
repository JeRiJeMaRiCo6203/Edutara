import Foundation
import Observation

@Observable final class AppState {
    var currentUser: User? = nil
    var favoriteMaterialIDs: Set<UUID> = []
    var notes: [Note] = MockData.notes
    var discussions: [Discussion] = MockData.discussions
    var users: [User] = MockData.users
    var stats: [Stats] = MockData.stats
    var achievements: [Achievement] = MockData.achievements
    var dailyGoalMinutes: Double = 30
    var isDarkMode: Bool = false
    var isReminderOn: Bool = true
    static let registrationFallbackUser = MockData.budi

    func statsForCurrentUser() -> Stats? {
        guard let id = currentUser?.id else { return nil }
        return stats.first(where: { $0.userID == id })
    }

    func updateStatsAfterQuiz(correct: Int, total: Int) {
        guard let uid = currentUser?.id, let idx = stats.firstIndex(where: { $0.userID == uid }) else { return }
        let earned = correct * 10
        stats[idx].xp += earned
        stats[idx].quizzesCompleted += 1
        let prevTotal = stats[idx].quizzesCompleted - 1
        let prevAvg = stats[idx].averageScore
        let newScore = Double(correct) / Double(max(total, 1)) * 100
        stats[idx].averageScore = (prevAvg * Double(prevTotal) + newScore) / Double(stats[idx].quizzesCompleted)
        stats[idx].streakDays += 1
    }

    func toggleFavorite(_ id: UUID) {
        if favoriteMaterialIDs.contains(id) { favoriteMaterialIDs.remove(id) } else { favoriteMaterialIDs.insert(id) }
    }

    func leaderboardSorted() -> [Stats] {
        stats.sorted { $0.xp > $1.xp }
    }

    func user(for id: UUID) -> User? {
        users.first(where: { $0.id == id })
    }

    func initials(for name: String) -> String {
        let parts = name.split(separator: " ")
        let letters = parts.prefix(2).compactMap { $0.first.map(String.init) }
        return letters.joined().uppercased()
    }
}
