import Foundation
import SwiftUI

enum Subject: String, CaseIterable, Identifiable, Hashable {
    case matematika = "Matematika"
    case english = "English"
    case kimia = "Kimia"
    var id: String { rawValue }
}

extension Subject {
    var displayColor: Color {
        switch self {
        case .matematika: return .edutaraPrimary
        case .english: return .edutaraSecondary
        case .kimia: return .edutaraKimia
        }
    }
    var symbol: String {
        switch self {
        case .matematika: return "function"
        case .english: return "character.book.closed"
        case .kimia: return "atom"
        }
    }
}

enum Difficulty: String, CaseIterable, Hashable {
    case beginner = "Pemula"
    case intermediate = "Menengah"
    case advanced = "Lanjut"
    var sortOrder: Int {
        switch self { case .beginner: return 0; case .intermediate: return 1; case .advanced: return 2 }
    }
    var color: Color {
        switch self {
        case .beginner: return .edutaraSuccess
        case .intermediate: return .edutaraWarning
        case .advanced: return .red.opacity(0.85)
        }
    }
}
