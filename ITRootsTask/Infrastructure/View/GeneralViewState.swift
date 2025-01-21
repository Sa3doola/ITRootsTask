//
//  GeneralViewState.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


// MARK: - View State
enum GeneralViewState: Equatable {
    case initial
    case loading
    case error(message: String)
    case noInternet
    case connecting
}