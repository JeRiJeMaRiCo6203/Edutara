import Foundation

struct Material: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var subject: Subject
    var educationLevel: String
    var grade: String
    var difficulty: Difficulty
    var estimatedMinutes: Int
    var summary: String
    var content: String
    var publishedAt: Date
    var isPremium: Bool
}
