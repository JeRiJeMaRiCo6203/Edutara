import SwiftUI

struct RegisterView: View {
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var level = "SMA"
    @State private var grade = "11"
    @State private var fav: Subject = .matematika
    @State private var error = ""
    let levels = ["SD","SMP","SMA"]
    var isValid: Bool { Validators.validateName(name) && Validators.validateEmail(email) && Validators.validatePassword(password) }
    var body: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 16) {
                    Text("Daftar Akun").font(.system(size: 24, weight: .bold, design: .rounded)).foregroundStyle(Color.edutaraPrimary).frame(maxWidth: .infinity, alignment: .leading)
                    GlassCard {
                        VStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                TextField("Nama lengkap (min 2 kata)", text: $name).padding(12).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.edutaraGlassStroke))
                                if let e = Validators.nameError(name) { Text(e).font(.caption2).foregroundStyle(.red) }
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                TextField("Email", text: $email).textInputAutocapitalization(.never).keyboardType(.emailAddress).padding(12).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.edutaraGlassStroke))
                                if let e = Validators.emailError(email) { Text(e).font(.caption2).foregroundStyle(.red) }
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                SecureField("Password (huruf+angka+simbol)", text: $password).padding(12).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.edutaraGlassStroke))
                                if let e = Validators.passwordError(password) { Text(e).font(.caption2).foregroundStyle(.red) }
                            }
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Jenjang").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                                Picker("Level", selection: $level) { ForEach(levels, id: \.self) { Text($0) } }.pickerStyle(.segmented)
                            }
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Kelas").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                                Picker("Grade", selection: $grade) { ForEach(Helpers.gradesByLevel[level] ?? ["1"], id: \.self) { Text($0) } }.pickerStyle(.segmented)
                                    .padding(.horizontal, 12).padding(.vertical, 8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.edutaraGlassStroke))
                            }
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Mata pelajaran favorit").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                                Picker("Fav", selection: $fav) { ForEach(Subject.allCases) { Text($0.rawValue).tag($0) } }.pickerStyle(.segmented)
                                    .padding(.horizontal, 12).padding(.vertical, 8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.edutaraGlassStroke))
                            }
                            if !error.isEmpty { Text(error).font(.caption.weight(.semibold)).foregroundStyle(.red) }
                            Button { register() } label: {
                                Text("Daftar").font(.headline.weight(.semibold)).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 14).background(isValid ? Color.edutaraButton : Color.gray.opacity(0.4), in: RoundedRectangle(cornerRadius: 14))
                            }.disabled(!isValid)
                        }
                    }
                }.padding(20)
            }
        }
        .onChange(of: level) { _, new in grade = Helpers.gradesByLevel[new]?.first ?? "1" }
        .navigationBarTitleDisplayMode(.inline)
    }
    private func register() {
        guard isValid else { error = "Periksa kembali isian"; return }
        appState.currentUser = AppState.registrationFallbackUser
        dismiss()
    }
}
#Preview { NavigationStack { RegisterView().environment(AppState()) } }
