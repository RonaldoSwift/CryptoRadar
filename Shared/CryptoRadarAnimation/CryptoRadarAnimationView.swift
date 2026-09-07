import Lottie
import SwiftUI

public struct CryptoRadarAnimationView: View {
    public init() {}

    public var body: some View {
        LottieView(
            animation: .named("CryptoRadar", bundle: .module)
        )
        .playing(loopMode: .loop)
        .configuration(
            LottieConfiguration(renderingEngine: .automatic)
        )
        .accessibilityLabel("CryptoRadar")
    }
}