import Foundation

struct Quiz: Identifiable {
    let id = UUID()
    var title: String
    var subject: Subject
    var materialID: UUID?
    var questions: [QuizQuestion]
}

struct QuizQuestion: Identifiable {
    let id = UUID()
    var text: String
    var options: [String]
    var correctIndex: Int
    var explanation: String
}
