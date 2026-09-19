import SwiftUI

struct SubjectChip: View {
    var subject: Subject
    var selected: Bool = false
    var body: some View {
        Text(subject.rawValue)
            .font(.caption2.weight(.semibold))
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(selected ? Color.edutaraSecondary : Color.white.opacity(0.0))
            .foregroundStyle(selected ? .white : .edutaraPrimary)
            .glassCapsule()
            .overlay { if selected { Capsule().fill(Color.edutaraSecondary) } }
            .overlay { Text(subject.rawValue).font(.caption2.weight(.semibold)).padding(.horizontal, 10).padding(.vertical, 6).foregroundStyle(selected ? .white : .edutaraPrimary) }
    }
}

struct SimpleSubjectChip: View {
    var subject: Subject
    var selected: Bool
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(subject.rawValue)
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 14).padding(.vertical, 8)
                .foregroundStyle(selected ? .white : .edutaraPrimary)
                .background(selected ? AnyShapeStyle(Color.edutaraSecondary) : AnyShapeStyle(.ultraThinMaterial), in: Capsule())
                .overlay(Capsule().stroke(selected ? Color.edutaraSecondary : Color.edutaraGlassStroke, lineWidth: 1))
        }.buttonStyle(.plain)
    }
}

struct DifficultyPill: View {
    var difficulty: Difficulty
    var body: some View {
        Text(difficulty.rawValue).font(.caption2.weight(.bold)).padding(.horizontal, 8).padding(.vertical, 4)
            .background(difficulty.color.opacity(0.14), in: Capsule())
            .foregroundStyle(difficulty.color)
    }
}

struct ProgressRing: View {
    var progress: Double
    var lineWidth: CGFloat = 8
    var body: some View {
        ZStack {
            Circle().stroke(Color.edutaraSecondary.opacity(0.18), lineWidth: lineWidth)
            Circle().trim(from: 0, to: progress).stroke(Color.edutaraSecondary, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)).rotationEffect(.degrees(-90))
            Text("\(Int(progress*100))%").font(.system(size: 22, weight: .bold, design: .rounded)).foregroundStyle(Color.edutaraPrimary)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ProgressRing(progress: 0.72).frame(width: 90, height: 90)
        DifficultyPill(difficulty: .advanced)
    }.padding()
}
