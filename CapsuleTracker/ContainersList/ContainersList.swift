import SwiftUI
import Foundation

struct ContainersList: View {
    enum Filtering: String, CaseIterable {
        case all, owned
        var desc: String {
            return rawValue.capitalized
        }

        var showOwned: Bool {
            self == .owned
        }
    }

    enum ListSection: CaseIterable, Identifiable {
        case crema, espresso, coffee, flavored
        var name: String {
            switch self {
            case .espresso:
                "Espresso"
            case .crema:
                "Caffè Crema"
            case .coffee:
                "Coffee"
            case .flavored:
                "Flavored Editions"
            }
        }
        var id: String { name }
    }

    private let grouping = CapsuleGrouping()

    var model: any ContainersProviderProtocol

    @State private var filterOwnedCapsules = false
    @State private var searchText = ""
    @State private var filtering: Filtering = .all

    private func filteredContainers() -> [CapsuleContainer] {
        return model.containers
            .filteredContainers(showOwned: filtering.showOwned,
                                searchText: searchText)
    }

    private var isSearching: Bool {
        !searchText.isEmpty
    }

    private var sectionsDict: [ListSection: [CapsuleContainer]] {
        return grouping.group(filteredContainers())
    }

    var body: some View {
        let sections = sectionsDict
        return VStack(spacing: 16) {
            ScrollViewReader { value in
                FlowLayout(alignment: .leading, spacing: 8) {
                    ForEach(ListSection.allCases) { section in
                        goToButton(section: section, proxy: value)
                            .disabled(sections.isEmpty(for: section))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing], 18)
                list_(sections: sections)
            }
            .tint(Color.primary)
            .fontDesign(.rounded)
            .overlay {
                if sections.isEmpty {
                    if isSearching {
                        ContentUnavailableView.search(text: searchText)
                    } else if filtering.showOwned {
                        ownedCapsulesUnavailableContent
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal, content: {
                    picker
                        .frame(maxWidth: 150)
                })
            }
        }
        .animation(.default, value: filtering)
        .animation(.default, value: searchText)
        .searchable(text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .automatic))
        .navigationTitle("Capsules")
    }
}

private extension ContainersList {
    var picker: some View {
        Picker("", selection: $filtering) {
            ForEach(Filtering.allCases, id: \.self) { type in
                Text("\(type.desc)")
                    .tag(type)
            }
        }
        .pickerStyle(.segmented)
        .tint(Color.brown)
    }

    func goToButton(section: ListSection, proxy: ScrollViewProxy) -> some View {
        Button(action: {
            withAnimation(.easeIn) {
                proxy.scrollTo(section.id, anchor: .center)
            }
        }, label: {
            HStack {
                Text(section.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .padding(10)
            .background(Capsule()
                .stroke(Color.primary, lineWidth: 1)
            )
        })
    }

    var ownedCapsulesUnavailableContent: some View {
        ContentUnavailableView("No results",
                               systemImage: "magnifyingglass",
                               description:
                                Text("You do not have any capsules.")
            .foregroundStyle(.secondary))
    }

    func list_(sections: [ListSection: [CapsuleContainer]]) -> some View {
        List {
            ForEach(ListSection.allCases) { section in
                if let containers = sections[section] {
                    Section {
                        ForEach(containers) { container in
                            NavigationLink(value: container) {
                                RowView(container: container)
                            }
                        }
                    } header: {
                        Text(section.name)
                            .id(section.id)
                            .font(.title3)
                            .foregroundStyle(Color.secondary)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                    }
                    .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 12))
                }
            }
        }
        .listStyle(.plain)
    }
}

private extension [ContainersList.ListSection: [CapsuleContainer]] {
    func isEmpty(for section: ContainersList.ListSection) -> Bool {
        (self[section] ?? []).isEmpty
    }

    func isEmpty() -> Bool {
        self.values.allSatisfy(\.isEmpty)
    }
}

private struct MainTestView: View {
    @State var provider = ContainersProviderPreview(
        capsuleOwnedID: CapsuleModel.baristaCrema.id,
        quantity: 5)

    @State private var isPresentingToast = false
    var body: some View {
        NavigationStack {
            ContainersList(model: ContainersProviderPreview(capsuleOwnedID: CapsuleModel.baristaCrema.id, quantity: 5))
                .navigationDestination(for: CapsuleContainer.self, destination: { container in
                    Text(container.capsule.name)
                })
        }
    }
}

#Preview("Populated") {
    MainTestView()
}

#Preview("Empty") {
    NavigationStack {
        ContainersList(model: ContainersProviderPreview.empty)
            .navigationDestination(for: CapsuleContainer.self, destination: { container in
                Text(container.capsule.name)
            })
    }
}
