import SwiftUI

struct Note: Identifiable {
    let id = UUID()
    var materialID: UUID?
    var title: String
    var body: AttributedString
    var updatedAt: Date
    var subject: Subject
}
