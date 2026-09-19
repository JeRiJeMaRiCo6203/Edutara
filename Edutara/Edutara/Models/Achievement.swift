import Foundation

struct Achievement: Identifiable {
    let id = UUID()
    var title: String
    var symbol: String
    var isUnlocked: Bool
    var progress: Double
}
