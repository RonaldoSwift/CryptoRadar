import Lottie
import SwiftUI

public struct FavoriteBurstAnimationView: View {
    public init() {}

    public var body: some View {
        LottieView(animation: .named("favorite_burst", bundle: .module))
            .playing(loopMode: .playOnce)
            .configuration(LottieConfiguration(renderingEngine: .automatic))
            .accessibilityLabel("Favorite burst")
    }
}
