import SwiftUI

public struct FavoriteHeartButton: View {
    private let isFavorite: Bool
    private let size: CGFloat
    private let action: () -> Void
    @State private var trigger = false

    public init(isFavorite: Bool, size: CGFloat = 22, action: @escaping () -> Void) {
        self.isFavorite = isFavorite
        self.size = size
        self.action = action
    }

    public var body: some View {
        Button {
            trigger = true
            action()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                trigger = false
            }
        } label: {
            ZStack {
                if trigger {
                    ForEach(0..<12, id: \ .self) { index in
                        Circle()
                            .fill(isFavorite ? Color.red : Color.gray)
                            .frame(width: 6, height: 6)
                            .offset(
                                x: cos(Double(index) * .pi / 6.0) * 16,
                                y: sin(Double(index) * .pi / 6.0) * 16
                            )
                            .opacity(trigger ? 1 : 0)
                            .scaleEffect(trigger ? 1 : 0.1)
                            .animation(
                                .easeOut(duration: 0.45)
                                .delay(Double(index) * 0.015),
                                value: trigger
                            )
                    }
                }

                HeartShape()
                    .fill(isFavorite ? Color.red : Color.gray.opacity(0.7))
                    .frame(width: size, height: size)
                    .shadow(color: isFavorite ? Color.red.opacity(0.35) : .clear, radius: 8, x: 0, y: 4)
                    .scaleEffect(trigger ? 1.45 : 1)
                    .rotationEffect(.degrees(trigger ? 8 : 0))
                    .animation(.spring(response: 0.32, dampingFraction: 0.7), value: trigger)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct HeartShape: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let centerX = width / 2
        let centerY = height / 2

        var path = Path()
        let topY = height * 0.18
        let leftX = width * 0.2
        let rightX = width * 0.8

        path.move(to: CGPoint(x: centerX, y: height * 0.96))
        path.addCurve(
            to: CGPoint(x: leftX, y: topY),
            control1: CGPoint(x: centerX * 0.25, y: height * 0.7),
            control2: CGPoint(x: leftX, y: height * 0.42)
        )
        path.addCurve(
            to: CGPoint(x: centerX, y: height * 0.38),
            control1: CGPoint(x: width * 0.15, y: height * 0.12),
            control2: CGPoint(x: centerX * 0.85, y: height * 0.22)
        )
        path.addCurve(
            to: CGPoint(x: rightX, y: topY),
            control1: CGPoint(x: centerX * 1.15, y: height * 0.22),
            control2: CGPoint(x: width * 0.85, y: height * 0.12)
        )
        path.addCurve(
            to: CGPoint(x: centerX, y: height * 0.96),
            control1: CGPoint(x: rightX, y: height * 0.42),
            control2: CGPoint(x: centerX * 1.75, y: height * 0.7)
        )
        path.closeSubpath()
        return path
    }
}

#Preview {
    FavoriteHeartButton(isFavorite: true) {
        print("favorite tapped")
    }
}
