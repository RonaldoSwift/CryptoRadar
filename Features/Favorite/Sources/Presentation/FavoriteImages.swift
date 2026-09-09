import Foundation

enum FavoriteImages {
    static let heart = system("heart")
    static let heartFilled = system("heart.fill")

    private static func system(_ name: String) -> String {
        name
    }
}
