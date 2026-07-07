import SwiftUI

enum Theme {
    static let background = Color(red: 0.055, green: 0.118, blue: 0.169)
    static let accent = Color(red: 0.247, green: 0.655, blue: 0.839)
    static let accent2 = Color(red: 0.867, green: 0.910, blue: 0.925)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
