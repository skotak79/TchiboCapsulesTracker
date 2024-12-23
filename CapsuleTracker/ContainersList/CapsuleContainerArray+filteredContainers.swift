extension [CapsuleContainer] {
    func filteredContainers(showOwned: Bool = false,
                            searchText: String = "") -> [CapsuleContainer] {
        self
            .filter {
                $0.matches(searchText: searchText)
            }
            .filter { !showOwned || $0.owned }
            .sorted {
                return $0.capsule.name < $1.capsule.name
            }
    }
}
