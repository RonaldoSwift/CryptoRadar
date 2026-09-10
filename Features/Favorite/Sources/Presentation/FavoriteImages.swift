import Foundation

public enum FavoriteImages {
    public static let heart = system("heart")
    public static let heartFilled = system("heart.fill")

    private static func system(_ name: String) -> String {
        name
    }
}
