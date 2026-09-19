import Foundation

enum Helpers {
    static let gradesByLevel: [String: [String]] = [
        "SD": ["1","2","3","4","5","6"],
        "SMP": ["7","8","9"],
        "SMA": ["10","11","12","13"]
    ]
    static func relativeString(from date: Date) -> String {
        let fmt = RelativeDateTimeFormatter()
        fmt.unitsStyle = .abbreviated
        fmt.locale = Locale(identifier: "id_ID")
        return fmt.localizedString(for: date, relativeTo: Date())
    }
    static func dateString(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.locale = Locale(identifier: "id_ID")
        return f.string(from: date)
    }
}
