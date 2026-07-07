import Foundation

struct WaterSession: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var zone: String
    var minutes: String
    var notes: String
}
