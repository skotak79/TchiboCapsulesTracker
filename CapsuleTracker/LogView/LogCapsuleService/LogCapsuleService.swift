//
//  LogCapsuleService.swift
//  CapsuleTracker
//

import Observation

@Observable
class LogCapsuleService: LogCapsuleServiceProtocol {

    var isHealthAccessAuthorized: Bool = false

    internal init(makeHealthClient: @escaping () -> HealthClientSendableProtocol,
                  containersBindingProvider: ContainersBindingProviderProtocol,
                  onLog: @escaping (CapsuleModel.ID, Double) -> Void = {_, _ in }) {
        self.makeHealthClient = makeHealthClient
        self.provider = containersBindingProvider
        self.onLog = onLog
        self.isHealthAccessAuthorized = makeHealthClient().healthAccessAuthorized()
    }

    private let onLog: (CapsuleModel.ID, Double) -> Void
    private let provider: ContainersBindingProviderProtocol
    private let makeHealthClient: () -> HealthClientSendableProtocol

    func askIfHealthAuthorized() {
        isHealthAccessAuthorized = makeHealthClient().healthAccessAuthorized()
    }

    @MainActor
    func requestPermission() async {
        isHealthAccessAuthorized = await makeHealthClient().requestPermisson()
    }

    @MainActor
    func logCapsule(id: CapsuleModel.ID, amountInMiligrams: Double) async {
        askIfHealthAuthorized()
        guard
            let binded = provider.getBindingOfContainer(id),
            let newContainer = binded.wrappedValue.decreaseQuantityByOneIfPossible() else { return }
        do {
            try await makeHealthClient().addCoffeine(amountInMiligrams: amountInMiligrams)
            binded.wrappedValue = newContainer
            onLog(id, amountInMiligrams)
        } catch {
            print(error.localizedDescription)
        }
    }
}
