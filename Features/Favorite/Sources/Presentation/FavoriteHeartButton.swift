import Lottie
import SwiftUI

public struct FavoriteHeartButton: View {
    private let isFavorite: Bool
    private let size: CGFloat
    private let action: () -> Void
    @State private var trigger = false
    @State private var animationID = UUID()

    public init(isFavorite: Bool, size: CGFloat = 22, action: @escaping () -> Void) {
        self.isFavorite = isFavorite
        self.size = size
        self.action = action
    }

    public var body: some View {
        Button {
            trigger = true
            animationID = UUID()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                action()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                trigger = false
            }
        } label: {
            ZStack {
                if trigger {
                    LottieView(animation: .named("favorite_burst", bundle: .module))
                        .playing(loopMode: .playOnce)
                        .id(animationID)
                        .frame(width: size * 2.2, height: size * 2.2)
                        .scaleEffect(trigger ? 1 : 0.85)
                        .opacity(trigger ? 1 : 0)
                        .animation(SwiftUI.Animation.easeOut(duration: 0.2), value: trigger)
                }

                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundStyle(isFavorite ? Color.red : Color.gray)
                    .shadow(color: isFavorite ? Color.red.opacity(0.35) : .clear, radius: 8, x: 0, y: 4)
                    .scaleEffect(trigger ? 1.08 : 1)
                    .animation(SwiftUI.Animation.spring(response: 0.28, dampingFraction: 0.75), value: trigger)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    FavoriteHeartButton(isFavorite: true) {
        print("favorite tapped")
    }
}
