//
//  LogServiceTests.swift
//  CapsuleTracker
//

import Testing
import SwiftUI
@testable import CapsuleTracker

private actor HealthClientMock: HealthClientSendableProtocol {

    init(
         isHealthAuthorized: Bool = true,
         permissionResult: Bool = true) {
        self._isHealthAuthorized = isHealthAuthorized
        self._permissionResult = permissionResult
    }

    private let _isHealthAuthorized: Bool
    private let _permissionResult: Bool

    var requestedPermissionCount = 0
    var coffeineAdded = 0.0

    func addCoffeine(amountInMiligrams: Double) async throws {
        coffeineAdded = amountInMiligrams
    }

    func requestPermisson() async -> Bool {
        requestedPermissionCount += 1
        return _permissionResult
    }

    func requestedPermissionOnce() async -> Bool {
        requestedPermissionCount == 1
    }

    nonisolated func healthAccessAuthorized() -> Bool {
        _isHealthAuthorized
    }
}

private class BindingStub: ContainersBindingProviderProtocol {
    var container: CapsuleContainer?
    init(container: CapsuleContainer? = nil) {
        self.container = container
    }

    func getBindingOfContainer(_ containerID: CapsuleContainer.ID) -> Binding<CapsuleContainer>? {
        guard let container else { return nil }
        return Binding(get: { container }, set: { newValue in
            self.container = newValue
        })
    }
}

struct LogServiceTests {

    @Test func whenServiceIsInitialized_healthAccessIsNotAuthorized() {
        let sut = LogCapsuleService(makeHealthClient: { HealthClientMock(isHealthAuthorized: false) }, containersBindingProvider: BindingStub())
        #expect(sut.isHealthAccessAuthorized == false)
    }

    @MainActor @Test func whenAskIfHealthAuthorizedIsCalled_healthAccessIsAuthorized() {
        let sut = LogCapsuleService(makeHealthClient: { HealthClientMock() }, containersBindingProvider: BindingStub())

        sut.askIfHealthAuthorized()

        #expect(sut.isHealthAccessAuthorized == true)

    }

    @MainActor
    @Test
    func whenAskIfHealthAuthorizedIsCalled_healthAccessIsNotAuthorized() {
        let sut = LogCapsuleService(makeHealthClient: { HealthClientMock(isHealthAuthorized: false) }, containersBindingProvider: BindingStub())

        sut.askIfHealthAuthorized()

        #expect(sut.isHealthAccessAuthorized == false)
    }

    @MainActor
    @Test
    func whenRequestPermissionIsCalled_healthClientPermissionRequestIsCalled() async {
        let healthClient = HealthClientMock(isHealthAuthorized: false, permissionResult: true)
        let sut = LogCapsuleService(makeHealthClient: { healthClient }, containersBindingProvider: BindingStub())

        await sut.requestPermission()

        #expect(sut.isHealthAccessAuthorized == true)
        #expect(await healthClient.requestedPermissionOnce())
    }

    @MainActor
    @Test
    func whenRequestPermissionIsCalled_healthAccessIsDenied() async {
        let healthClient = HealthClientMock(isHealthAuthorized: false, permissionResult: false)
        let sut = LogCapsuleService(makeHealthClient: { healthClient }, containersBindingProvider: BindingStub())

        await sut.requestPermission()

        #expect(sut.isHealthAccessAuthorized == false)
        #expect(await healthClient.requestedPermissionOnce())
    }

    @MainActor
    @Test
    func whenLogCapsuleIsCalled_CapsulesQuantityInContainerDecreases() async throws {
        let healthClient = HealthClientMock()

        let bindingStub = BindingStub(container: CapsuleContainer(capsule: .coconutEspresso, quantity: 1))
        let sut = LogCapsuleService(makeHealthClient: { healthClient }, containersBindingProvider: bindingStub)
        let coconutEspressoID = CapsuleModel.coconutEspresso.id

        await sut.logCapsule(id: coconutEspressoID, amountInMiligrams: 20)

        #expect(await healthClient.coffeineAdded == 20)
        #expect(bindingStub.container?.quantity == 0)
    }
}
