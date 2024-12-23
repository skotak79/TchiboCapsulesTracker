//
//  CapsuleTrackerApp.swift
//  CapsuleTracker
//

import SwiftUI
import HealthKit

@main
struct CapsuleTrackerApp: App {
    @Environment(\.scenePhase) private var scenePhase

    private static let healthClient = HealthClientActor()
    private let isHealthDataAvailable = HKHealthStore.isHealthDataAvailable()

    @State private var mainModel: ContainersProvider = ContainersProvider(quantityStore: QuantityPersistentStore())
    @State private var isPresentingToast = false
    @State private var isShowing = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContainersList(model: mainModel)
                    .navigationDestination(for: CapsuleContainer.self, destination: { container in
                        if let binded = mainModel.getBindingOfContainer(container.id) {
                            DetailModern(capsuleContainer: binded,
                                         isHealthDataAvailable: isHealthDataAvailable,
                                         makeLogView: { capsule in
                                LogView(capsule: capsule,
                                        model: LogCapsuleService(
                                            makeHealthClient: { CapsuleTrackerApp.healthClient },
                                            containersBindingProvider: mainModel,
                                            onLog: { _, _ in
                                                isPresentingToast = true
                                            }
                                        )
                                )
                            })
                        }
                    })
            }
            .simpleToast(isShowing: $isPresentingToast, text: "Caffeine logged")
            .task {
                if mainModel.containers.isEmpty {
                    try? await mainModel.loadContainers()
                }
            }
            .onChange(of: scenePhase) {_, newPhase in
                if newPhase == .background {
                    Task {
                        await mainModel.saveAll()
                    }
                }
            }
        }
    }
}
