import SwiftUI

extension Color {
    init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: h).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch h.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
    static let edutaraPrimary = Color(hex: "#351904")
    static let edutaraSecondary = Color(hex: "#B89650")
    static let edutaraAccent = Color(hex: "#F5F0E6")
    static let edutaraButton = Color(hex: "#000000")
    static let edutaraGlassStroke = Color.white.opacity(0.18)
    static let edutaraSuccess = Color(hex: "#1A7F4B")
    static let edutaraWarning = Color(hex: "#C08A2C")
    static let edutaraKimia = Color(hex: "#2A9D8F")
}

enum Theme {
    static let heroGradient = LinearGradient(colors: [Color.edutaraPrimary, Color.edutaraSecondary.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let cardGradient = LinearGradient(colors: [Color.edutaraPrimary.opacity(0.12), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing)

    struct GlassCardModifier: ViewModifier {
        var cornerRadius: CGFloat
        func body(content: Content) -> some View {
            content
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(Color.edutaraGlassStroke, lineWidth: 1)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(Color.white.opacity(0.22), lineWidth: 1)
                        .mask(
                            LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .center)
                        )
                        .allowsHitTesting(false)
                }
                .shadow(color: .black.opacity(0.10), radius: 24, x: 0, y: 8)
        }
    }

    struct GlassCapsuleModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .background(.ultraThinMaterial, in: Capsule())
                .overlay(Capsule().stroke(Color.edutaraGlassStroke, lineWidth: 1))
                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
        }
    }

    struct FloatingBarModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .background(.ultraThinMaterial, in: Capsule())
                .overlay(Capsule().stroke(Color.edutaraGlassStroke, lineWidth: 1))
                .shadow(color: .black.opacity(0.12), radius: 20, x: 0, y: 8)
        }
    }

    static func glassCard(cornerRadius: CGFloat = 20) -> GlassCardModifier { GlassCardModifier(cornerRadius: cornerRadius) }
    static func glassCapsule() -> GlassCapsuleModifier { GlassCapsuleModifier() }
    static func floatingBar() -> FloatingBarModifier { FloatingBarModifier() }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 20) -> some View {
        modifier(Theme.GlassCardModifier(cornerRadius: cornerRadius))
    }
    func glassCapsule() -> some View {
        modifier(Theme.GlassCapsuleModifier())
    }
    func floatingBar() -> some View {
        modifier(Theme.FloatingBarModifier())
    }
    @ViewBuilder
    func glassEffectIfAvailable() -> some View {
        if #available(iOS 26, *) {
            self.glassEffect(.regular.tint(.white.opacity(0.72)), in: .rect(cornerRadius: 20))
        } else {
            self
        }
    }
    @ViewBuilder
    func capsuleGlassEffectIfAvailable() -> some View {
        if #available(iOS 26, *) {
            self.glassEffect(.regular.tint(.white.opacity(0.72)), in: .capsule)
        } else {
            self
        }
    }
}

extension View {
    var edutaraBackground: some View {
        ZStack {
            Color.edutaraAccent.ignoresSafeArea()
            RadialGradient(colors: [Color.edutaraSecondary.opacity(0.08), .clear], center: .topTrailing, startRadius: 20, endRadius: 600)
                .ignoresSafeArea()
            RadialGradient(colors: [Color.edutaraPrimary.opacity(0.04), .clear], center: .bottomLeading, startRadius: 20, endRadius: 700)
                .ignoresSafeArea()
        }
    }
}
