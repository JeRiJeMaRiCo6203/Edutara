import SwiftUI

struct DailyFactWidget: View {
    @Binding var toast: String
    var body: some View {
        HStack(spacing: 12) {
            Rectangle().fill(Color.edutaraSecondary).frame(width: 4).clipShape(Capsule())
            Image(systemName: "book.fill").font(.title3).foregroundStyle(Color.edutaraSecondary)
            VStack(alignment: .leading, spacing: 4) {
                Text("Fakta Budaya Harian").font(.caption.weight(.bold)).foregroundStyle(Color.edutaraPrimary)
                Text("Tahukah kamu? Candi Borobudur memiliki 2.672 panel relief dan 504 arca Buddha — mahakarya Nusantara.").font(.caption).foregroundStyle(.secondary).lineLimit(2)
            }
            Spacer()
            Button {
                toast = "Memutar..."
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) { toast = "" }
            } label: {
                Image(systemName: "play.fill").font(.caption.weight(.bold)).foregroundStyle(.white).padding(10).background(Color.edutaraButton, in: Circle())
            }.buttonStyle(.plain)
        }.padding(14).glassCard(cornerRadius: 20)
    }
}
#Preview { DailyFactWidget(toast: .constant("")).padding() }
