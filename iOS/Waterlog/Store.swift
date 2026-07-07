import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    static let freeLimit = 10

    @Published var items: [WaterSession] = []
    @Published var isPro: Bool = false

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("waterlog_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: WaterSession) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: WaterSession) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = item
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: WaterSession) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([WaterSession].self, from: data) else {
            items = Store.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [WaterSession] {
        [
        WaterSession(date: Date().addingTimeInterval(-86400), zone: "Front Beds", minutes: "15", notes: "Drip line"),
        WaterSession(date: Date().addingTimeInterval(-172800), zone: "Vegetable Patch", minutes: "20", notes: "Hand watered"),
        WaterSession(date: Date().addingTimeInterval(-259200), zone: "Container Pots", minutes: "5", notes: "Morning top-up")
        ]
    }
}
