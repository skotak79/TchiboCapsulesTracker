import SwiftUI
import HealthKit

struct LogView: View {
    private let coffeineAmountForDecaffInMiligramms = 5
    @Environment(\.dismiss) private var dismiss

    let capsule: CapsuleModel
    var model: any LogCapsuleServiceProtocol

    @State private var selectedType: LogPreparationType = .espresso

    let calculator = CaffeineCalcuator()

    private var estimatedCaffeineAmount: Int {
        return calculator.calculateCaffeineAmount(isDecaff: capsule.isDecaff,
                                                  with: selectedType)
    }

    var body: some View {
        VStack(spacing: 12) {
            if model.isHealthAccessAuthorized {
                HealthKitAuthorizedInfo()
            } else {
                HealthAuthorizationButton(action: {
                    Task {
                        await model.requestPermission()
                    }
                })
            }
            if model.isHealthAccessAuthorized {
                preparationSection
            } else {
                Divider()
            }
            logButton
        }
        .padding(.horizontal)
        .presentationDetents(model.isHealthAccessAuthorized ? [.fraction(0.4)] : [.fraction(0.35)])
        .onAppear {
            setInitialPreparation()
            model.askIfHealthAuthorized()
        }
    }
}

private extension LogView {
    var logButton: some View {
        Button(action: {
            Task {
                await model.logCapsule(id: capsule.id, amountInMiligrams: Double(estimatedCaffeineAmount))
                dismiss()
            }
        }, label: {
            HStack {
                Image(systemName: "mug.fill")
                Text(logButtonText)

            }
            .frame(maxWidth: .infinity)
            .bold()
            .padding(4)
        })
        .buttonStyle(.borderedProminent)
        .tint(Color.brown.gradient)
    }

    var preparationSection: some View {
        VStack(spacing: 8) {
            Text("Preparation")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
                .bold()
            Picker("Picker", selection: $selectedType, content: {
                ForEach(LogPreparationType.allCases, id: \.rawValue) { model in
                    Text(model.desc)
                        .tag(model)
                }
            })
            .pickerStyle(.segmented)
            Text("Tap 'regular' if you selected Caffe Crema or Caffee")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    var logButtonText: String {
        if model.isHealthAccessAuthorized {
            return "Log \(estimatedCaffeineAmount) mg of Caffeine"
        } else {
            return "Log capsule"
        }
    }

    func setInitialPreparation() {
        updatePreparation()
    }

    func updatePreparation() {
        switch capsule.preparation {
        case .espresso:
            self.selectedType = .espresso
        default:
            self.selectedType = .regular
        }
    }
}

#Preview("Authorized") {
    LogView(capsule: .baristaCrema, model: LogCapsuleServicePreview.authorized)
}

#Preview("Denied") {
    LogView(capsule: .coconutEspresso, model: LogCapsuleServicePreview.denied)
}

private struct TestBaseBrewView: View {
    @State var isPresentingSheet: Bool = false
    let authorized: Bool
    @State var capsuleContainer = CapsuleContainer(capsule: .decaff, quantity: 2)
    var body: some View {
        Button(action: { isPresentingSheet.toggle() }, label: {
            Text("Show Sheet")
        })
        .sheet(isPresented: $isPresentingSheet) {
            NavigationStack {
                ScrollView {
                    LogView(capsule: capsuleContainer.capsule,
                            model: authorized ? LogCapsuleServicePreview.authorized : .denied)
                    .toolbar {
                        Text("Test ")
                    }
                }
            }
        }
    }
}

#Preview("Sheet Presentation, Authorized", body: {
    TestBaseBrewView(authorized: true)
})

#Preview("Sheet Presentation, Denied", body: {
    TestBaseBrewView(authorized: false)
})

extension LogView {
    enum LogPreparationType: String, CaseIterable, Identifiable {
        var id: String { rawValue }
        case espresso, regular

        var desc: String {
            rawValue.capitalized
        }

        var systemImageName: String {
            switch self {
            case .espresso:
                "cup.and.saucer"
            case .regular:
                "mug.fill"
            }
        }
    }
}
