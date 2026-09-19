import Foundation

struct Discussion: Identifiable {
    let id = UUID()
    var authorID: UUID
    var title: String
    var body: String
    var subject: Subject
    var createdAt: Date
    var replies: [Reply]
    var likes: Int
    init(authorID: UUID, title: String, body: String, subject: Subject, createdAt: Date, replies: [Reply], likes: Int) {
        self.authorID = authorID; self.title = title; self.body = body; self.subject = subject; self.createdAt = createdAt; self.replies = replies; self.likes = likes
    }
    init(authorID: UUID, title: String, subject: Subject, createdAt: Date, replies: [Reply], body: String, likes: Int) {
        self.authorID = authorID; self.title = title; self.body = body; self.subject = subject; self.createdAt = createdAt; self.replies = replies; self.likes = likes
    }
}

struct Reply: Identifiable {
    let id = UUID()
    var authorID: UUID
    var body: String
    var createdAt: Date
    var likes: Int
}
