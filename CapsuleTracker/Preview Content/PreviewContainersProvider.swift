//
//  PreviewContainersProvider.swift
//  CapsuleTracker
//

import Observation

@Observable
final class ContainersProviderPreview: ContainersProviderProtocol {
    var containers: [CapsuleContainer] = []

    convenience init(capsuleOwnedID: CapsuleModel.ID, quantity: UInt) {
        self.init()
        if let index = containers.firstIndex(where: { $0.id == capsuleOwnedID }) {
            containers[index] = CapsuleContainer(capsule: containers[index].capsule, quantity: quantity)
        }
    }

    init(containers: [CapsuleContainer] = CapsuleModel.all.map { CapsuleContainer(capsule: $0, quantity: 0) }) {
        self.containers = containers
    }

    @MainActor
    static let empty = ContainersProviderPreview()
}
