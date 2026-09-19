import Foundation

enum Validators {
    static func validateName(_ name: String) -> Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ").count >= 2
    }
    static func validateEmail(_ email: String) -> Bool {
        guard let at = email.firstIndex(of: "@") else { return false }
        let after = email[email.index(after: at)...]
        return after.contains(".")
    }
    static func validatePassword(_ password: String) -> Bool {
        guard password.count >= 8 else { return false }
        let hasLetter = password.range(of: "[A-Za-z]", options: .regularExpression) != nil
        let hasDigit = password.range(of: "[0-9]", options: .regularExpression) != nil
        let hasSpecial = password.range(of: "[!@#$%^&*]", options: .regularExpression) != nil
        return hasLetter && hasDigit && hasSpecial
    }
    static func nameError(_ name: String) -> String? {
        if name.isEmpty { return nil }
        return validateName(name) ? nil : "Nama minimal 2 kata"
    }
    static func emailError(_ email: String) -> String? {
        if email.isEmpty { return nil }
        return validateEmail(email) ? nil : "Email harus mengandung @ dan ."
    }
    static func passwordError(_ password: String) -> String? {
        if password.isEmpty { return nil }
        return validatePassword(password) ? nil : "Min 8 karakter, huruf+angka+simbol (!@#$%^&*)"
    }
}
