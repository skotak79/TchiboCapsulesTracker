//
//  ContainersBindingProviderProtocol.swift
//  CapsuleTracker
//

import SwiftUI

protocol ContainersBindingProviderProtocol {
    @MainActor
    func getBindingOfContainer(_ containerID: CapsuleContainer.ID) -> Binding<CapsuleContainer>?
}

extension ContainersProvider: ContainersBindingProviderProtocol {}
