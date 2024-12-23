//
//  ContainersProviderProtocol.swift
//  CapsuleTracker
//
import Observation

protocol ContainersProviderProtocol: Observable {
    var containers: [CapsuleContainer] { get }
}

extension ContainersProvider: ContainersProviderProtocol {}
