import Foundation

struct Stats: Identifiable {
    let id = UUID()
    let userID: UUID
    var xp: Int
    var streakDays: Int
    var quizzesCompleted: Int
    var averageScore: Double
}
