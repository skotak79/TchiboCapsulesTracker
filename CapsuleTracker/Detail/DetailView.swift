import SwiftUI

struct DetailModern<LogView: View>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    private let isHealthDataAvailable: Bool

    @ViewBuilder
    private let makeLogView: (CapsuleModel) -> LogView

    @State private var initialQuantity = 0
    @State private var isPresentingLog = false
    @State private var isPresentingToast = false
    @State private var sheetHeight: CGFloat = .zero

    @Binding var capsuleContainer: CapsuleContainer

    private var quantityDidChange: Bool {
        initialQuantity != capsuleContainer.quantity
    }

    private var capsuleModel: CapsuleModel {
        capsuleContainer.capsule
    }

    private var maxValue: Double {
        Double(FeatureRating.maxValue)
    }

    private var isPortraitOrientation: Bool {
        horizontalSizeClass == .compact && verticalSizeClass == .regular
    }

    private var presentLogButton: Bool {
        capsuleContainer.quantity != 0 && isHealthDataAvailable
    }

    private var containerIsEmpty: Bool {
        capsuleContainer.quantity == 0
    }

    init(
        capsuleContainer: Binding<CapsuleContainer>,
        isHealthDataAvailable: Bool = true,
        makeLogView: @escaping (CapsuleModel) -> LogView
    ) {
        _capsuleContainer = capsuleContainer
        self.isHealthDataAvailable = isHealthDataAvailable
        self.makeLogView = makeLogView
    }

    var body: some View {
        ScrollView {
            image
                .padding()
            Divider()
                .padding(.horizontal)
            stepper
                .padding(12)
            Divider()
                .padding(.horizontal)
            description
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            features
                .padding(.horizontal)
        }
        .toolbar {
            if presentLogButton {
                Button(action: {
                    isPresentingLog.toggle()
                }, label: {
                    Text("Log")
                })
                .buttonStyle(.borderedProminent)
                .tint(Color.brown)
            }
        }
        .sheet(isPresented: $isPresentingLog, content: {
            NavigationStack {
                ScrollView {
                    makeLogView(capsuleContainer.capsule)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button(action: {
                        isPresentingLog.toggle()
                    }, label: {
                        Text("Dismiss")
                    })
                    .tint(.brown)
                }
            }
            .presentationSizing(.fitted)
            .presentationDragIndicator(.visible)
        })
        .onAppear {
            initialQuantity = Int(capsuleContainer.quantity)
        }
        .navigationTitle(capsuleModel.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    var image: some View {
        Image(capsuleModel.capsuleImageName)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(maxHeight: isPortraitOrientation ? .infinity : 200, alignment: .center)
    }
}

private extension DetailModern {

    var stepper: some View {
        HStack(spacing: 58) {
            Button(action: {
                if let newContainer = capsuleContainer.decreaseQuantityByOneIfPossible() {
                    capsuleContainer = newContainer
                }
            }, label: {
                Image(systemName: "minus.circle.fill")
            })
            .disabled(containerIsEmpty)
            .foregroundStyle(containerIsEmpty ? .brown.opacity(0.6) : .brown)
            Text("\(capsuleContainer.quantity)")
                .foregroundStyle(quantityDidChange ? .red : .brown)
            Button(action: {
                capsuleContainer = capsuleContainer.increaseQuantityByOne()
            }, label: {
                Image(systemName: "plus.circle.fill")
            })
        }
        .font(.title)
        .fontWeight(.semibold)
        .foregroundStyle(.brown)
    }

    var description: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(capsuleModel.name)
                .font(.title)
                .bold()
            Text(capsuleModel.shortDesc)
                .font(.headline)
                .fontWeight(.light)
        }
    }

    var features: some View {
        VStack {
            ForEach(capsuleModel.features) { feature in
                HStack {
                    Text(feature.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    RatingView(rating: feature.rating)
                }
                .padding(.bottom, 2)
                .fontDesign(.rounded)
                .font(.body)
                .fontWeight(.light)
            }
        }
    }
}

private struct TestModernDetail: View {
    let authorized: Bool
    @State var capsule = CapsuleContainer(capsule: .espressoBrasil, quantity: 2)
    var body: some View {
        NavigationStack {
            DetailModern(capsuleContainer: $capsule, makeLogView: { capsule in
                LogView(capsule: capsule, model: authorized ? LogCapsuleServicePreview.authorized : .denied)
            })
        }
    }
}

#Preview("Authorized") {
    TestModernDetail(authorized: true)
}

#Preview("Denied") {
    TestModernDetail(authorized: false)
}
