import SwiftUI

struct LoginView: View {
    @Environment(AppState.self) var appState
    @State private var email = ""
    @State private var password = ""
    @State private var error = ""
    @State private var showRegister = false
    @State private var isPasswordVisible: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color.edutaraAccent.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Image("EDUTARA")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300)
                        }.padding(.top, 40)
                        GlassCard {
                            VStack(spacing: 14) {
                                TextField("Email", text: $email).textContentType(.emailAddress).textInputAutocapitalization(.never).keyboardType(.emailAddress).padding(12).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.edutaraGlassStroke))
                                HStack {
                                            if isPasswordVisible {
                                                TextField("Password", text: $password)
                                            } else {
                                                SecureField("Password", text: $password)
                                            }

                                            Button(action: {
                                                isPasswordVisible.toggle()
                                            }) {
                                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        .padding(12)
                                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.edutaraGlassStroke)
                                        )
                                if !error.isEmpty { Text(error).font(.caption.weight(.semibold)).foregroundStyle(.red).frame(maxWidth: .infinity, alignment: .leading) }
                                Button { login() } label: {
                                    Text("Masuk").font(.headline.weight(.semibold)).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 14).background(Color.edutaraButton, in: RoundedRectangle(cornerRadius: 14))
                                }
                                Button("Belum punya akun? Daftar") { showRegister = true }.font(.footnote.weight(.semibold)).foregroundStyle(Color.edutaraPrimary)
                            }
                        }
                    }.padding(20)
                }
            }.navigationDestination(isPresented: $showRegister) { RegisterView() }
        }
    }
    private func login() {
        error = ""
        guard let user = appState.users.first(where: { $0.email.lowercased() == email.lowercased().trimmingCharacters(in: .whitespaces) }) else { error = "Email tidak ditemukan"; return }
        guard user.password == password else { error = "Password salah"; return }
        appState.currentUser = user
    }
}
#Preview { LoginView().environment(AppState()) }
