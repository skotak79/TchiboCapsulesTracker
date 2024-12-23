import Foundation

actor QuantityPersistentStore: QuantityStoreProtocol {

    private var savedValue: [CapsuleQuantityPersisted] = [CapsuleQuantityPersisted]()

    func loadAll() async -> [CapsuleQuantityPersisted] {
        var quantities: [CapsuleQuantityPersisted]
        do {
            let data = try Data(contentsOf: Self.fileURL)
            quantities = try JSONDecoder().decode([CapsuleQuantityPersisted].self, from: data)
        } catch CocoaError.fileReadNoSuchFile {
            quantities = [CapsuleQuantityPersisted]()
        } catch {
            fatalError("An unexpected error loading the favorites list \(error.localizedDescription)")
        }

        savedValue = quantities
        return quantities
    }

    func saveAll(_ quantities: [CapsuleQuantityPersisted]) async {
        if quantities == savedValue {
            return
        }

        let data: Data
        do {
            data = try JSONEncoder().encode(quantities)
        } catch {
            fatalError("Error while encoding the data: \(error.localizedDescription)")
        }

        do {
            let outfileURL = Self.fileURL
            try data.write(to: outfileURL)
        } catch {
            fatalError("Error while saving the data \(error.localizedDescription)")
        }
    }

    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }

    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("quantities.data")
    }

}
